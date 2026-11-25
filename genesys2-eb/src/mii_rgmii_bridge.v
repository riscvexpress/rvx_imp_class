//------------------------------------------------------------------------------
// mii_rgmii_bridge
//
// 100 Mb/s bridge between a MII MAC (AXI EthernetLite) and an RGMII PHY
// (Genesys2: Realtek RTL8211E). Kintex-7 has no Xilinx MII/GMII-to-RGMII IP
// (gmii_to_rgmii 4.1 is Zynq/UltraScale only), so this replaces it.
//
// At 10/100 Mb/s RGMII carries one nibble per clock: the same nibble on both
// edges of TXC/RXC, and CTL = EN/DV on the rising edge, EN^ER / DV^ER on the
// falling edge (RGMII v2.0). The data is therefore stable for the whole 40 ns
// period, which this bridge uses to stay independent of the PHY's internal
// clock delays (RTL8211E TXDLY/RXDLY straps):
//   - TX: data leaves ODDRs on the rising edge of clk_25m; TXC is forwarded
//     from a 90-degree shifted copy of clk_25m, so TXC rises 10 ns and falls
//     30 ns after each data change: both TXC edges sit inside the 40 ns
//     data window. (v1/v2 forwarded TXC inverted: rising edge at 20 ns, but
//     the falling edge then landed exactly on the data transition. The
//     RTL8211E evidently also samples the falling edge at 100 Mb/s: PHY
//     loopback returned 0/300 frames with RXERC counting one error per
//     frame, and the Orin counted rx_errors on frames from the FPGA.)
//   - RX: RXD is taken from the falling-edge sample of RXC, 20 ns from the
//     PHY's launch edge, whether or not the PHY delays RXC by ~2 ns.
//
// RX_CTL is also taken at the falling edge, where it carries DV^ER. With ER=0
// (every normal frame) that is DV. With ER=1 it is the inverse of DV, which
// matters for EEE: during low-power idle the PHY drives DV=0/ER=1 with
// RXD=0x1 (RGMII v2.0 table 4), so a bridge that just forwards the falling
// sample tells the MAC "frame" for the whole LPI period. The first version of
// this bridge did that, and with an EEE link partner (Jetson Orin) the MAC
// received garbage during every idle period and lost real frames.
// Therefore RX_DV is qualified by a frame tracker: a frame starts only when
// CTL=1 arrives together with a preamble nibble (0x5) and lasts while CTL
// stays 1. LPI (RXD=0x1) and false carrier (RXD=0xE, ER=1) never start a
// frame. An in-frame error (DV=1/ER=1, CTL falling-edge value 0) ends the
// frame early and the MAC drops it on the FCS check, so RX_ER stays 0.
// Only the falling-edge sample is used, 20 ns from every RGMII transition at
// 100 Mb/s, so nothing depends on the exact RXC phase (no IDDR same-edge
// capture, which Vivado cannot constrain separately from the other edge).
//
// The PHY must link at 100 Mb/s (firmware restricts the MDIO advertisement;
// the RTL8211E would otherwise prefer 1000 Mb/s, which this bridge does not
// support). Full duplex only: CRS is derived from DV/TX_EN, COL is 0.
//------------------------------------------------------------------------------
`timescale 1ns / 1ps

module mii_rgmii_bridge (
	input  wire       clk_25m,       // 25 MHz TX clock (100 Mb/s)
	input  wire       clk_25m_90,    // same clock, +90 degrees (TXC forwarding)

	// MII, MAC side (the MAC is the interface master)
	(* X_INTERFACE_MODE = "slave" *)
	(* X_INTERFACE_INFO = "xilinx.com:interface:mii:1.0 MII TX_CLK" *)
	output wire       mii_tx_clk,
	(* X_INTERFACE_INFO = "xilinx.com:interface:mii:1.0 MII TXD" *)
	input  wire [3:0] mii_txd,
	(* X_INTERFACE_INFO = "xilinx.com:interface:mii:1.0 MII TX_EN" *)
	input  wire       mii_tx_en,
	(* X_INTERFACE_INFO = "xilinx.com:interface:mii:1.0 MII RX_CLK" *)
	output wire       mii_rx_clk,
	(* X_INTERFACE_INFO = "xilinx.com:interface:mii:1.0 MII RXD" *)
	output reg  [3:0] mii_rxd,
	(* X_INTERFACE_INFO = "xilinx.com:interface:mii:1.0 MII RX_DV" *)
	output reg        mii_rx_dv,
	(* X_INTERFACE_INFO = "xilinx.com:interface:mii:1.0 MII RX_ER" *)
	output reg        mii_rx_er,
	(* X_INTERFACE_INFO = "xilinx.com:interface:mii:1.0 MII CRS" *)
	output wire       mii_crs,
	(* X_INTERFACE_INFO = "xilinx.com:interface:mii:1.0 MII COL" *)
	output wire       mii_col,
	(* X_INTERFACE_INFO = "xilinx.com:interface:mii:1.0 MII RST_N" *)
	input  wire       mii_rst_n,

	// RGMII, PHY side
	output wire       rgmii_txc,
	output wire [3:0] rgmii_td,
	output wire       rgmii_tx_ctl,
	input  wire       rgmii_rxc,
	input  wire [3:0] rgmii_rd,
	input  wire       rgmii_rx_ctl,
	output wire       phy_rst_n
);

	//--------------------------------------------------------------------------
	// TX
	//--------------------------------------------------------------------------
	assign mii_tx_clk = clk_25m;

	reg [3:0] txd_r;
	reg       tx_en_r;

	always @(posedge clk_25m) begin
		txd_r   <= mii_txd;
		tx_en_r <= mii_tx_en;
	end

	genvar i;
	generate
		for (i = 0; i < 4; i = i + 1) begin : g_td
			ODDR #(.DDR_CLK_EDGE("SAME_EDGE"), .INIT(1'b0), .SRTYPE("SYNC")) u_oddr_td (
				.Q(rgmii_td[i]), .C(clk_25m), .CE(1'b1),
				.D1(txd_r[i]), .D2(txd_r[i]), .R(1'b0), .S(1'b0));
		end
	endgenerate

	// TX_ER is not driven by the MAC, so the falling-edge value EN^ER = EN.
	ODDR #(.DDR_CLK_EDGE("SAME_EDGE"), .INIT(1'b0), .SRTYPE("SYNC")) u_oddr_tx_ctl (
		.Q(rgmii_tx_ctl), .C(clk_25m), .CE(1'b1),
		.D1(tx_en_r), .D2(tx_en_r), .R(1'b0), .S(1'b0));

	// Forwarded clock from the 90-degree copy: TXC rises 10 ns and falls
	// 30 ns after the data changes (quarter-period centred on both edges).
	ODDR #(.DDR_CLK_EDGE("SAME_EDGE"), .INIT(1'b0), .SRTYPE("SYNC")) u_oddr_txc (
		.Q(rgmii_txc), .C(clk_25m_90), .CE(1'b1),
		.D1(1'b1), .D2(1'b0), .R(1'b0), .S(1'b0));

	//--------------------------------------------------------------------------
	// RX
	//--------------------------------------------------------------------------
	wire rx_clk;

	BUFG u_bufg_rxc (.I(rgmii_rxc), .O(rx_clk));
	assign mii_rx_clk = rx_clk;

	// Sample once per period, on the falling edge, in IOB flip-flops. The PHY
	// changes RXD/RX_CTL near the rising edge of RXC, so a rising-edge sample
	// would sit on the transition; the falling edge is 20 ns away from it.
	(* IOB = "TRUE" *) reg [3:0] rd_fall;
	(* IOB = "TRUE" *) reg       ctl_fall;

	always @(negedge rx_clk) begin
		rd_fall  <= rgmii_rd;
		ctl_fall <= rgmii_rx_ctl;
	end

	// Frame tracker: CTL=1 opens a frame only with a preamble nibble, so EEE
	// LPI (CTL 0/1, RXD=0x1) and false carrier (RXD=0xE) are not forwarded.
	reg rx_active;

	always @(posedge rx_clk) begin
		rx_active <= ctl_fall & (rx_active | (rd_fall == 4'h5));
		mii_rxd   <= rd_fall;
		mii_rx_dv <= ctl_fall & (rx_active | (rd_fall == 4'h5));
		mii_rx_er <= 1'b0;
	end

	//--------------------------------------------------------------------------
	// Status and reset
	//--------------------------------------------------------------------------
	assign mii_crs   = mii_rx_dv | mii_tx_en;
	assign mii_col   = 1'b0;
	assign phy_rst_n = mii_rst_n;

endmodule
