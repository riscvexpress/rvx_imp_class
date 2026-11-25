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

## Realtek RTL8211E-VL Ethernet PHY (RGMII, used at 100 Mb/s through mii_rgmii_bridge)
set_property -dict { PACKAGE_PIN AF12  IOSTANDARD LVCMOS15 } [get_ports { eth_mdc }];
set_property -dict { PACKAGE_PIN AG12  IOSTANDARD LVCMOS15 } [get_ports { eth_mdio }];
set_property -dict { PACKAGE_PIN AH24  IOSTANDARD LVCMOS33 } [get_ports { eth_phyrst_n }];

set_property -dict { PACKAGE_PIN AG10  IOSTANDARD LVCMOS15 } [get_ports { eth_rxck }];
set_property -dict { PACKAGE_PIN AH11  IOSTANDARD LVCMOS15 } [get_ports { eth_rxctl }];
set_property -dict { PACKAGE_PIN AJ14  IOSTANDARD LVCMOS15 } [get_ports { eth_rxd[0] }];
set_property -dict { PACKAGE_PIN AH14  IOSTANDARD LVCMOS15 } [get_ports { eth_rxd[1] }];
set_property -dict { PACKAGE_PIN AK13  IOSTANDARD LVCMOS15 } [get_ports { eth_rxd[2] }];
set_property -dict { PACKAGE_PIN AJ13  IOSTANDARD LVCMOS15 } [get_ports { eth_rxd[3] }];

set_property -dict { PACKAGE_PIN AE10  IOSTANDARD LVCMOS15 } [get_ports { eth_txck }];
set_property -dict { PACKAGE_PIN AK14  IOSTANDARD LVCMOS15 } [get_ports { eth_txctl }];
set_property -dict { PACKAGE_PIN AJ12  IOSTANDARD LVCMOS15 } [get_ports { eth_txd[0] }];
set_property -dict { PACKAGE_PIN AK11  IOSTANDARD LVCMOS15 } [get_ports { eth_txd[1] }];
set_property -dict { PACKAGE_PIN AJ11  IOSTANDARD LVCMOS15 } [get_ports { eth_txd[2] }];
set_property -dict { PACKAGE_PIN AK10  IOSTANDARD LVCMOS15 } [get_ports { eth_txd[3] }];

create_clock -period 40.000 -name rgmii_rxc [get_ports eth_rxck]
create_generated_clock -name rgmii_txc -source [get_pins -hier -filter {NAME =~ *i_mii_rgmii_bridge/u_oddr_txc/C}] -divide_by 1 [get_ports eth_txck]

set_input_delay -clock rgmii_rxc -max  1.000 [get_ports {eth_rxd[*] eth_rxctl}]
set_input_delay -clock rgmii_rxc -min -2.500 [get_ports {eth_rxd[*] eth_rxctl}]

set_output_delay -clock rgmii_txc -max  1.000 [get_ports {eth_txd[*] eth_txctl}]
set_output_delay -clock rgmii_txc -min -2.800 [get_ports {eth_txd[*] eth_txctl}]
set_output_delay -clock rgmii_txc -max  1.000 [get_ports {eth_txd[*] eth_txctl}] -clock_fall -add_delay
set_output_delay -clock rgmii_txc -min -2.800 [get_ports {eth_txd[*] eth_txctl}] -clock_fall -add_delay
set_false_path -fall_from [get_clocks -of_objects [get_pins -hier -filter {NAME =~ *i_mii_rgmii_bridge/*u_oddr_td/C}]] -to [get_ports {eth_txd[*] eth_txctl}]

set_false_path -to   [get_ports {eth_phyrst_n eth_mdc eth_mdio}]
set_false_path -from [get_ports eth_mdio]
