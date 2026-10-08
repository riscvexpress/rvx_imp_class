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
## 2018-03 : Sukho Lee (shlee99@etri.re.kr)
## ****************************************************************************
## ****************************************************************************

##########
## JTAG ##
##########
#PMOD0 Female ;; VADJ = 1.8V -> 1.2V 
#set_property -dict { PACKAGE_PIN AY14    IOSTANDARD LVCMOS12 PULLUP TRUE} [get_ports { pjtag_rtdo }]; #IO_L11N_T1_SRCC_35 Sch=jd[1]
#set_property -dict { PACKAGE_PIN AY15    IOSTANDARD LVCMOS12 PULLUP TRUE} [get_ports { pjtag_rtrstnn }]; #IO_L11N_T1_SRCC_35 Sch=jd[2]
#set_property -dict { PACKAGE_PIN AW15    IOSTANDARD LVCMOS12 PULLUP TRUE} [get_ports { pjtag_rtck }]; #IO_L13P_T2_MRCC_35 Sch=jd[3]
#set_property -dict { PACKAGE_PIN AV16    IOSTANDARD LVCMOS12 PULLUP TRUE} [get_ports { pjtag_rtdi }]; #IO_L14P_T2_SRCC_35 Sch=jd[7]
#set_property -dict { PACKAGE_PIN AU16    IOSTANDARD LVCMOS12 PULLUP TRUE} [get_ports { pjtag_rtms }]; #IO_L14N_T2_SRCC_35 Sch=jd[8]

#set_property -dict { PACKAGE_PIN AV15    IOSTANDARD LVCMOS12 } [get_ports { test_50MHz_clk }]; #4

#PMOD1 Male Npt Working 
#set_property -dict { PACKAGE_PIN N28  IOSTANDARD LVCMOS12 PULLUP TRUE } [get_ports {pjtag_rtdo}];     #PMOD1-1
#set_property -dict { PACKAGE_PIN M30  IOSTANDARD LVCMOS12 PULLUP TRUE } [get_ports {pjtag_rtrstnn}];  #PMOD1-2
#set_property -dict { PACKAGE_PIN N30  IOSTANDARD LVCMOS12 PULLUP TRUE } [get_ports {pjtag_rtck}];     #PMOD1-3
#set_property -dict { PACKAGE_PIN P29  IOSTANDARD LVCMOS12 PULLUP TRUE } [get_ports {pjtag_rtdi}];  #PMOD1-7
#set_property -dict { PACKAGE_PIN L31  IOSTANDARD LVCMOS12 PULLUP TRUE } [get_ports {pjtag_rtms}];  #PMOD1-8

#Last OK.
#FMC-XM119-PMOD1 must be 1.5V
#set_property -dict { PACKAGE_PIN BC11    IOSTANDARD LVCMOS15 PULLUP     } [get_ports { pjtag_rtdo }];  #1 02P
#set_property -dict { PACKAGE_PIN BD12    IOSTANDARD LVCMOS15 PULLUP TRUE} [get_ports { pjtag_rtrstnn }];  #2 03P
#set_property -dict { PACKAGE_PIN BF12    IOSTANDARD LVCMOS15 PULLUP TRUE} [get_ports { pjtag_rtck }];  #3 04P
#set_property -dict { PACKAGE_PIN AY9     IOSTANDARD LVCMOS15            } [get_ports { printf_rx }];  #4 00P
#set_property -dict { PACKAGE_PIN BE14    IOSTANDARD LVCMOS15 PULLUP TRUE} [get_ports { pjtag_rtdi }];  #7 05P
#set_property -dict { PACKAGE_PIN BD13    IOSTANDARD LVCMOS15 PULLUP TRUE} [get_ports { pjtag_rtms }];  #8 06P
#set_property -dict { PACKAGE_PIN BC15    IOSTANDARD LVCMOS15            } [get_ports {  }];  #9 07P
#set_property -dict { PACKAGE_PIN BE15    IOSTANDARD LVCMOS15            } [get_ports { printf_tx }];  #10 08P

#FMC-XM119-PMOD2
#set_property -dict { PACKAGE_PIN BF10    IOSTANDARD LVCMOS18 } [get_ports { pjtag_rtdo }]; #1 01P
#set_property -dict { PACKAGE_PIN BA14    IOSTANDARD LVCMOS18 } [get_ports { pjtag_rtrstnn }]; #2 09P
#set_property -dict { PACKAGE_PIN BB13    IOSTANDARD LVCMOS18 } [get_ports { pjtag_rtck }]; #3 10P
#set_property -dict { PACKAGE_PIN BA16    IOSTANDARD LVCMOS18 } [get_ports { printf_rx }]; #4 11P
#set_property -dict { PACKAGE_PIN BC14    IOSTANDARD LVCMOS18 } [get_ports { pjtag_rtdi }]; #7 12P
#set_property -dict { PACKAGE_PIN AY8     IOSTANDARD LVCMOS18 } [get_ports { pjtag_rtms }]; #8 13P
#set_property -dict { PACKAGE_PIN AW8     IOSTANDARD LVCMOS18 } [get_ports {  }]; #9 14P
#set_property -dict { PACKAGE_PIN BB16    IOSTANDARD LVCMOS18 } [get_ports { printf_tx }]; #10 15P

#FMC-XM119-PMOD3
#set_property -dict { PACKAGE_PIN AV9    IOSTANDARD LVCMOS15 } [get_ports { pjtag_rtdo }]; #1 16P 
#set_property -dict { PACKAGE_PIN AP12   IOSTANDARD LVCMOS15 } [get_ports { pjtag_rtrstnn }]; #2 18P
#set_property -dict { PACKAGE_PIN AW12   IOSTANDARD LVCMOS15 } [get_ports { pjtag_rtck }]; #3 19P
#set_property -dict { PACKAGE_PIN AR14   IOSTANDARD LVCMOS15 } [get_ports { printf_rx  }]; #4 17P
#set_property -dict { PACKAGE_PIN AW11   IOSTANDARD LVCMOS15 } [get_ports { pjtag_rtdi }]; #7 20P
#set_property -dict { PACKAGE_PIN AU11   IOSTANDARD LVCMOS15 } [get_ports { pjtag_rtms }]; #8 21P
#set_property -dict { PACKAGE_PIN AW13   IOSTANDARD LVCMOS15 } [get_ports {            }]; #9 22P
#set_property -dict { PACKAGE_PIN AN16   IOSTANDARD LVCMOS15 } [get_ports { printf_tx  }]; #10 23P


# FMC-XM105
#set_property -dict { PACKAGE_PIN AJ12    IOSTANDARD LVCMOS18 } [get_ports { pjtag_rtdo }]; 
#set_property -dict { PACKAGE_PIN AJ13    IOSTANDARD LVCMOS18 } [get_ports { pjtag_rtck }]; 
#set_property -dict { PACKAGE_PIN AK14    IOSTANDARD LVCMOS18 } [get_ports { pjtag_rtdi }]; 
#set_property -dict { PACKAGE_PIN AK13    IOSTANDARD LVCMOS18 } [get_ports { pjtag_rtms }]; 
#set_property -dict { PACKAGE_PIN AL12    IOSTANDARD LVCMOS18 } [get_ports { pjtag_rtrstnn }];

#set_property PULLUP true [get_ports pjtag_rtck]
#set_property PULLUP true [get_ports pjtag_rtdi]
#set_property PULLUP true [get_ports pjtag_rtms]
#set_property PULLUP true [get_ports pjtag_rtrstnn]

create_clock -period 100 -name pjtag_rclk [get_ports pjtag_rtck]
set_input_jitter pjtag_rtck 0.1

set_input_delay -clock pjtag_rclk 25.000 [get_ports pjtag_rtdi]
set_input_delay -clock pjtag_rclk 25.000 [get_ports pjtag_rtrstnn]
set_input_delay -clock pjtag_rclk 25.000 [get_ports pjtag_rtms]
set_output_delay -clock pjtag_rclk 25.000 [get_ports pjtag_rtdo]


set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets pjtag_rtck]

