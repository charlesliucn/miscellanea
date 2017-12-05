set_property PACKAGE_PIN V17 [get_ports {reset}]

set_property PACKAGE_PIN U17 [get_ports {btnd}]

set_property PACKAGE_PIN U2 [get_ports {ano[0]}]
set_property PACKAGE_PIN U4 [get_ports {ano[1]}]
set_property PACKAGE_PIN V4 [get_ports {ano[2]}]
set_property PACKAGE_PIN W4 [get_ports {ano[3]}]

#CA->CG
set_property PACKAGE_PIN W7 [get_ports {leds[6]}]
set_property PACKAGE_PIN W6 [get_ports {leds[5]}]
set_property PACKAGE_PIN U8 [get_ports {leds[4]}]
set_property PACKAGE_PIN V8 [get_ports {leds[3]}]
set_property PACKAGE_PIN U5 [get_ports {leds[2]}]
set_property PACKAGE_PIN V5 [get_ports {leds[1]}]
set_property PACKAGE_PIN U7 [get_ports {leds[0]}]

set_property PACKAGE_PIN W5 [get_ports clk]

create_clock -period 10.000 -name CLK -waveform {0.000 5.000} [get_ports clk]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk]

set_property IOSTANDARD LVCMOS33 [get_ports {clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ano[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ano[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ano[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ano[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {reset}]
set_property IOSTANDARD LVCMOS33 [get_ports {btnd}]