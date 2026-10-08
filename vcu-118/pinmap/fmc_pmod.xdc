#ETRI-FM
set_property -dict { PACKAGE_PIN AK12    IOSTANDARD LVCMOS18 } [get_ports { pjtag_rtdo }];    #1 LA_30P
set_property -dict { PACKAGE_PIN AR13    IOSTANDARD LVCMOS18 } [get_ports { pjtag_rtrstnn }]; #2 LA_24N
set_property -dict { PACKAGE_PIN AL12    IOSTANDARD LVCMOS18 } [get_ports { pjtag_rtck }];  #3 LA_30N
set_property -dict { PACKAGE_PIN AV10    IOSTANDARD LVCMOS18 } [get_ports { pjtag_rtdi }];  #7 LA_28P
set_property -dict { PACKAGE_PIN AW10    IOSTANDARD LVCMOS18 } [get_ports { pjtag_rtms }];  #8 LA_28N

set_property -dict { PACKAGE_PIN AJ13    IOSTANDARD LVCMOS18 } [get_ports { printf_rx }];   #4 LA_32P
set_property -dict { PACKAGE_PIN AJ12    IOSTANDARD LVCMOS18 } [get_ports { printf_tx }];  #10 LA_32N


