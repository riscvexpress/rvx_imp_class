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
## 2018-03-19 : Sukho Lee (shlee99@etri.re.kr)
## ****************************************************************************
## ****************************************************************************

###########
## reset ##
###########

#Active high
set_property -dict { PACKAGE_PIN L19    IOSTANDARD LVCMOS12 } [get_ports { external_rstpp }]; # CPU_RESET Pin


########################
## differential clock ##
########################
#
set_property -dict { PACKAGE_PIN AY23  IOSTANDARD LVDS } [get_ports { external_clk_0_pair }];  # 125MHz
set_property -dict { PACKAGE_PIN AY24  IOSTANDARD LVDS } [get_ports { external_clk_0 }];  # 125MHz
#
#set_property -dict { PACKAGE_PIN F31  IOSTANDARD LVDS } [get_ports { external_clk_0_pair }];  # 300MHz
#set_property -dict { PACKAGE_PIN G31  IOSTANDARD LVDS } [get_ports { external_clk_0 }];  # 300MHz


#############

create_clock -period 8  -name external_clk [get_ports external_clk_0]
set_input_jitter external_clk_0 0.1


set_false_path -from [get_ports external_rstpp]

