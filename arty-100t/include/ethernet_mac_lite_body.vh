localparam MDC_DIVIDER = 40;
localparam FIFO_DEPTH = 16;
localparam TX_START_LEVEL = 8;

localparam BW_MAC_ADDR = 13;

/////////////
/* signals */
/////////////

wire phy_mdio_i;
wire phy_mdio_o;
wire phy_mdio_t;

////////////
/* logics */
////////////

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
	.phy_mdc(phy_mdc)
);

assign phy_mdio = phy_mdio_t ? 1'b z : phy_mdio_o;
assign phy_mdio_i = phy_mdio;
assign phy_ref_clk = clk_phy_ref;

