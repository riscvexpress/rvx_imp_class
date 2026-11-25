## ****************************************************************************
## ****************************************************************************
## Copyright SoC Design Research Group, All rights reserved.
## Electronics and Telecommunications Research Institute (ETRI)
##
## THESE DOCUMENTS CONTAIN CONFIDENTIAL INFORMATION AND KNOWLEDGE
## WHICH IS THE PROPERTY OF ETRI. NO PART OF THIS PUBLICATION IS
## TO BE USED FOR ANY OTHER PURPOSE, AND THESE ARE NOT TO BE
## REPRODUCED, COPIED, DISCLOSED, TRANSMITTED, STORED IN A RETRIEVAL
## SYSTEM OR TRANSLATED INTO ANY OTHER HUMAN OR COMPUTER LANGUAGE,
## IN ANY FORM, BY ANY MEANS, IN WHOLE OR IN PART, WITHOUT THE
## COMPLETE PRIOR WRITTEN PERMISSION OF ETRI.
## ****************************************************************************
## 2026-11-17 : Kyuseung Han (han@etri.re.kr)
## ****************************************************************************
## ****************************************************************************

## TI DP83848J Ethernet PHY (MII)
set_property -dict { PACKAGE_PIN D17   IOSTANDARD LVCMOS33 } [get_ports { phy_col }]; #IO_L16N_T2_A27_15 Sch=phy_col
set_property -dict { PACKAGE_PIN G14   IOSTANDARD LVCMOS33 } [get_ports { phy_crs }]; #IO_L15N_T2_DQS_ADV_B_15 Sch=phy_crs
set_property -dict { PACKAGE_PIN F16   IOSTANDARD LVCMOS33 } [get_ports { phy_mdc }]; #IO_L14N_T2_SRCC_15 Sch=phy_mdc
set_property -dict { PACKAGE_PIN K13   IOSTANDARD LVCMOS33 } [get_ports { phy_mdio }]; #IO_L17P_T2_A26_15 Sch=phy_mdio
set_property -dict { PACKAGE_PIN G18   IOSTANDARD LVCMOS33 } [get_ports { phy_ref_clk }]; #IO_L22P_T3_A17_15 Sch=phy_ref_clk
set_property -dict { PACKAGE_PIN C16   IOSTANDARD LVCMOS33 } [get_ports { phy_rst_n }]; #IO_L20P_T3_A20_15 Sch=phy_rstn
set_property -dict { PACKAGE_PIN F15   IOSTANDARD LVCMOS33 } [get_ports { phy_rx_clk }]; #IO_L14P_T2_SRCC_15 Sch=phy_rx_clk
set_property -dict { PACKAGE_PIN G16   IOSTANDARD LVCMOS33 } [get_ports { phy_dv }]; #IO_L13N_T2_MRCC_15 Sch=phy_rx_dv
set_property -dict { PACKAGE_PIN D18   IOSTANDARD LVCMOS33 } [get_ports { phy_rx_data[0] }]; #IO_L21N_T3_DQS_A18_15 Sch=phy_rxd[0]
set_property -dict { PACKAGE_PIN E17   IOSTANDARD LVCMOS33 } [get_ports { phy_rx_data[1] }]; #IO_L16P_T2_A28_15 Sch=phy_rxd[1]
set_property -dict { PACKAGE_PIN E18   IOSTANDARD LVCMOS33 } [get_ports { phy_rx_data[2] }]; #IO_L21P_T3_DQS_15 Sch=phy_rxd[2]
set_property -dict { PACKAGE_PIN G17   IOSTANDARD LVCMOS33 } [get_ports { phy_rx_data[3] }]; #IO_L18N_T2_A23_15 Sch=phy_rxd[3]
set_property -dict { PACKAGE_PIN C17   IOSTANDARD LVCMOS33 } [get_ports { phy_rx_er }]; #IO_L20N_T3_A19_15 Sch=phy_rxerr
set_property -dict { PACKAGE_PIN H16   IOSTANDARD LVCMOS33 } [get_ports { phy_tx_clk }]; #IO_L13P_T2_MRCC_15 Sch=phy_tx_clk
set_property -dict { PACKAGE_PIN H15   IOSTANDARD LVCMOS33 } [get_ports { phy_tx_en }]; #IO_L19N_T3_A21_VREF_15 Sch=phy_tx_en
set_property -dict { PACKAGE_PIN H14   IOSTANDARD LVCMOS33 } [get_ports { phy_tx_data[0] }]; #IO_L15P_T2_DQS_15 Sch=phy_txd[0]
set_property -dict { PACKAGE_PIN J14   IOSTANDARD LVCMOS33 } [get_ports { phy_tx_data[1] }]; #IO_L19P_T3_A22_15 Sch=phy_txd[1]
set_property -dict { PACKAGE_PIN J13   IOSTANDARD LVCMOS33 } [get_ports { phy_tx_data[2] }]; #IO_L17N_T2_A25_15 Sch=phy_txd[2]
set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports { phy_tx_data[3] }]; #IO_L18P_T2_A24_15 Sch=phy_txd[3]


create_clock -period 40.000 -name phy_tx_clk [get_ports phy_tx_clk]
create_clock -period 40.000 -name phy_rx_clk [get_ports phy_rx_clk]
