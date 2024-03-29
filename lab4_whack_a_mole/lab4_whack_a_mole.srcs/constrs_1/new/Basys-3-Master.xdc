# Clock signal
set_property -dict { PACKAGE_PIN W5    IOSTANDARD LVCMOS33 } [get_ports clk]

# Reset button
set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports clr]

# Left button
set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports lft]

# Right button
set_property -dict { PACKAGE_PIN T17   IOSTANDARD LVCMOS33 } [get_ports rgt]

# Pause button
set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports pse]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets pse_IBUF]

# Switches
set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports {sw[0]}]
set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports {sw[1]}]
set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS33 } [get_ports {sw[2]}]
set_property -dict { PACKAGE_PIN W17   IOSTANDARD LVCMOS33 } [get_ports {sw[3]}]
set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS33 } [get_ports {sw[4]}]
set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33 } [get_ports {sw[5]}]
set_property -dict { PACKAGE_PIN W14   IOSTANDARD LVCMOS33 } [get_ports {sw[6]}]
set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33 } [get_ports {sw[7]}]

# Analog display
set_property -dict { PACKAGE_PIN U2   IOSTANDARD LVCMOS33 } [get_ports {an[0]}]
set_property -dict { PACKAGE_PIN U4   IOSTANDARD LVCMOS33 } [get_ports {an[1]}]
set_property -dict { PACKAGE_PIN V4   IOSTANDARD LVCMOS33 } [get_ports {an[2]}]
set_property -dict { PACKAGE_PIN W4   IOSTANDARD LVCMOS33 } [get_ports {an[3]}]

# 7-segment display
set_property -dict { PACKAGE_PIN W7    IOSTANDARD LVCMOS33 } [get_ports {a2g[6]}]
set_property -dict { PACKAGE_PIN W6    IOSTANDARD LVCMOS33 } [get_ports {a2g[5]}]
set_property -dict { PACKAGE_PIN U8    IOSTANDARD LVCMOS33 } [get_ports {a2g[4]}]
set_property -dict { PACKAGE_PIN V8   IOSTANDARD LVCMOS33 } [get_ports {a2g[3]}]
set_property -dict { PACKAGE_PIN U5    IOSTANDARD LVCMOS33 } [get_ports {a2g[2]}]
set_property -dict { PACKAGE_PIN V5    IOSTANDARD LVCMOS33 } [get_ports {a2g[1]}]
set_property -dict { PACKAGE_PIN U7    IOSTANDARD LVCMOS33 } [get_ports {a2g[0]}]

# LEDs
set_property -dict { PACKAGE_PIN U16    IOSTANDARD LVCMOS33 } [get_ports {ld[0]}]
set_property -dict { PACKAGE_PIN E19    IOSTANDARD LVCMOS33 } [get_ports {ld[1]}]
set_property -dict { PACKAGE_PIN U19    IOSTANDARD LVCMOS33 } [get_ports {ld[2]}]
set_property -dict { PACKAGE_PIN V19    IOSTANDARD LVCMOS33 } [get_ports {ld[3]}]
set_property -dict { PACKAGE_PIN W18    IOSTANDARD LVCMOS33 } [get_ports {ld[4]}]
set_property -dict { PACKAGE_PIN U15    IOSTANDARD LVCMOS33 } [get_ports {ld[5]}]
set_property -dict { PACKAGE_PIN U14    IOSTANDARD LVCMOS33 } [get_ports {ld[6]}]
set_property -dict { PACKAGE_PIN V14    IOSTANDARD LVCMOS33 } [get_ports {ld[7]}]