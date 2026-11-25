localparam MDC_DIVIDER = 40;
localparam FIFO_DEPTH = 16;
localparam TX_START_LEVEL = 8;

localparam BW_MAC_ADDR = 13;

/////////////
/* signals */
/////////////

wire phy_tx_clk;
wire phy_rx_clk;
wire phy_crs;
wire phy_dv;
wire [3:0] phy_rx_data;
wire phy_col;
wire phy_rx_er;
wire phy_rst_n;
wire phy_tx_en;
wire [3:0] phy_tx_data;
wire phy_mdio_i;
wire phy_mdio_o;
wire phy_mdio_t;

wire clk_25m_fb;
wire clk_25m_unbuf;
wire clk_25m_90_unbuf;
wire clk_25m;
wire clk_25m_90;

////////////
/* logics */
////////////

MMCME2_BASE
#(
	.CLKIN1_PERIOD(40.0),
	.DIVCLK_DIVIDE(1),
	.CLKFBOUT_MULT_F(40.0),
	.CLKOUT0_DIVIDE_F(40.0),
	.CLKOUT0_PHASE(0.0),
	.CLKOUT1_DIVIDE(40),
	.CLKOUT1_PHASE(90.0)
)
i_mmcm
(
	.CLKIN1(clk_phy_ref),
	.CLKFBIN(clk_25m_fb),
	.CLKFBOUT(clk_25m_fb),
	.CLKFBOUTB(),
	.CLKOUT0(clk_25m_unbuf),
	.CLKOUT0B(),
	.CLKOUT1(clk_25m_90_unbuf),
	.CLKOUT1B(),
	.CLKOUT2(),
	.CLKOUT2B(),
	.CLKOUT3(),
	.CLKOUT3B(),
	.CLKOUT4(),
	.CLKOUT5(),
	.CLKOUT6(),
	.LOCKED(),
	.PWRDWN(1'b 0),
	.RST(1'b 0)
);

BUFG i_bufg_25m (.I(clk_25m_unbuf), .O(clk_25m));
BUFG i_bufg_25m_90 (.I(clk_25m_90_unbuf), .O(clk_25m_90));

ETH_MAC_LITE
#(
	.MDC_DIVIDER(MDC_DIVIDER),
	.FIFO_DEPTH(FIFO_DEPTH),
	.TX_START_LEVEL(TX_START_LEVEL)
)
i_mac
(
	.s_axi_aclk(clk_axi),
	.s_axi_aresetn(rstnn_axi),
	.ip2intc_irpt(interrupt),

	.s_axi_awid(rxawid),
	.s_axi_awaddr(rxawaddr[BW_MAC_ADDR-1:0]),
	.s_axi_awlen(rxawlen),
	.s_axi_awsize(rxawsize),
	.s_axi_awburst(rxawburst),
	.s_axi_awcache(4'b 0),
	.s_axi_awvalid(rxawvalid),
	.s_axi_awready(rxawready),

	.s_axi_wdata(rxwdata),
	.s_axi_wstrb(rxwstrb),
	.s_axi_wlast(rxwlast),
	.s_axi_wvalid(rxwvalid),
	.s_axi_wready(rxwready),

	.s_axi_bid(rxbid),
	.s_axi_bresp(rxbresp),
	.s_axi_bvalid(rxbvalid),
	.s_axi_bready(rxbready),

	.s_axi_arid(rxarid),
	.s_axi_araddr(rxaraddr[BW_MAC_ADDR-1:0]),
	.s_axi_arlen(rxarlen),
	.s_axi_arsize(rxarsize),
	.s_axi_arburst(rxarburst),
	.s_axi_arcache(4'b 0),
	.s_axi_arvalid(rxarvalid),
	.s_axi_arready(rxarready),

	.s_axi_rid(rxrid),
	.s_axi_rdata(rxrdata),
	.s_axi_rresp(rxrresp),
	.s_axi_rlast(rxrlast),
	.s_axi_rvalid(rxrvalid),
	.s_axi_rready(rxrready),

	.phy_tx_clk(phy_tx_clk),
	.phy_rx_clk(phy_rx_clk),
	.phy_crs(phy_crs),
	.phy_dv(phy_dv),
	.phy_rx_data(phy_rx_data),
	.phy_col(phy_col),
	.phy_rx_er(phy_rx_er),
	.phy_rst_n(phy_rst_n),
	.phy_tx_en(phy_tx_en),
	.phy_tx_data(phy_tx_data),
	.phy_mdio_i(phy_mdio_i),
	.phy_mdio_o(phy_mdio_o),
	.phy_mdio_t(phy_mdio_t),
	.phy_mdc(eth_mdc)
);

mii_rgmii_bridge i_mii_rgmii_bridge
(
	.clk_25m(clk_25m),
	.clk_25m_90(clk_25m_90),

	.mii_tx_clk(phy_tx_clk),
	.mii_txd(phy_tx_data),
	.mii_tx_en(phy_tx_en),
	.mii_rx_clk(phy_rx_clk),
	.mii_rxd(phy_rx_data),
	.mii_rx_dv(phy_dv),
	.mii_rx_er(phy_rx_er),
	.mii_crs(phy_crs),
	.mii_col(phy_col),
	.mii_rst_n(phy_rst_n),

	.rgmii_txc(eth_txck),
	.rgmii_td(eth_txd),
	.rgmii_tx_ctl(eth_txctl),
	.rgmii_rxc(eth_rxck),
	.rgmii_rd(eth_rxd),
	.rgmii_rx_ctl(eth_rxctl),
	.phy_rst_n(eth_phyrst_n)
);

assign eth_mdio = phy_mdio_t ? 1'b z : phy_mdio_o;
assign phy_mdio_i = eth_mdio;

