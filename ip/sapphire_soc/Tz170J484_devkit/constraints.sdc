# PLL Constraints
#################
# io_systemClk = 300.0MHz
create_clock -period 3.3333 io_systemClk 

# io_peripheralClk = 100.0MHz 
create_clock -period 10.0 io_peripheralClk

# jtag_inst1_TCK = 10MHz 
create_clock -period 100 jtag_inst1_TCK 

# False Path 
#################
set_clock_groups -exclusive  -group {io_systemClk} -group {io_peripheralClk} -group {jtag_inst1_TCK}

# JTAG Constraints 
####################
set_output_delay -clock jtag_inst1_TCK -max 1.595 [get_ports {jtag_inst1_TDO}]
set_output_delay -clock jtag_inst1_TCK -min 0.555 [get_ports {jtag_inst1_TDO}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.693 [get_ports {jtag_inst1_CAPTURE}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.282 [get_ports {jtag_inst1_CAPTURE}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.682 [get_ports {jtag_inst1_SEL}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.344 [get_ports {jtag_inst1_SEL}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.662 [get_ports {jtag_inst1_SHIFT}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.294 [get_ports {jtag_inst1_SHIFT}]

# SPI Constraints 
#########################
set_output_delay -clock io_peripheralClk -reference_pin [get_ports {io_peripheralClk~CLKOUT~18~1}] -max 0.302 [get_ports {system_spi_0_io_sclk_write}]
set_output_delay -clock io_peripheralClk -reference_pin [get_ports {io_peripheralClk~CLKOUT~18~1}] -min -0.140 [get_ports {system_spi_0_io_sclk_write}]
set_output_delay -clock io_peripheralClk -reference_pin [get_ports {io_peripheralClk~CLKOUT~78~1}] -max 0.302 [get_ports {system_spi_0_io_ss}]
set_output_delay -clock io_peripheralClk -reference_pin [get_ports {io_peripheralClk~CLKOUT~78~1}] -min -0.140 [get_ports {system_spi_0_io_ss}]
set_input_delay -clock io_peripheralClk -reference_pin [get_ports {io_peripheralClk~CLKOUT~85~1}] -max 0.476 [get_ports {system_spi_0_io_data_0_read}]
set_input_delay -clock io_peripheralClk -reference_pin [get_ports {io_peripheralClk~CLKOUT~85~1}] -min 0.276 [get_ports {system_spi_0_io_data_0_read}]
set_output_delay -clock io_peripheralClk -reference_pin [get_ports {io_peripheralClk~CLKOUT~87~1}] -max 0.301 [get_ports {system_spi_0_io_data_0_write}]
set_output_delay -clock io_peripheralClk -reference_pin [get_ports {io_peripheralClk~CLKOUT~87~1}] -min -0.140 [get_ports {system_spi_0_io_data_0_write}]
set_output_delay -clock io_peripheralClk -reference_pin [get_ports {io_peripheralClk~CLKOUT~87~1}] -max 0.302 [get_ports {system_spi_0_io_data_0_writeEnable}]
set_output_delay -clock io_peripheralClk -reference_pin [get_ports {io_peripheralClk~CLKOUT~87~1}] -min -0.140 [get_ports {system_spi_0_io_data_0_writeEnable}]
set_input_delay -clock io_peripheralClk -reference_pin [get_ports {io_peripheralClk~CLKOUT~86~1}] -max 0.476 [get_ports {system_spi_0_io_data_1_read}]
set_input_delay -clock io_peripheralClk -reference_pin [get_ports {io_peripheralClk~CLKOUT~86~1}] -min 0.276 [get_ports {system_spi_0_io_data_1_read}]
set_output_delay -clock io_peripheralClk -reference_pin [get_ports {io_peripheralClk~CLKOUT~88~1}] -max 0.302 [get_ports {system_spi_0_io_data_1_write}]
set_output_delay -clock io_peripheralClk -reference_pin [get_ports {io_peripheralClk~CLKOUT~88~1}] -min -0.140 [get_ports {system_spi_0_io_data_1_write}]
set_output_delay -clock io_peripheralClk -reference_pin [get_ports {io_peripheralClk~CLKOUT~88~1}] -max 0.302 [get_ports {system_spi_0_io_data_1_writeEnable}]
set_output_delay -clock io_peripheralClk -reference_pin [get_ports {io_peripheralClk~CLKOUT~88~1}] -min -0.140 [get_ports {system_spi_0_io_data_1_writeEnable}]
