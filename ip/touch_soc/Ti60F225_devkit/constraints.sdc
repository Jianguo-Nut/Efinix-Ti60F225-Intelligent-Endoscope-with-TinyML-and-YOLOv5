# PLL Constraints
#################
create_clock -period 10.0 io_systemClk
create_clock -period 100 jtag_inst1_TCK

# False Path
#################
set_clock_groups -exclusive  -group {io_systemClk} -group {jtag_inst1_TCK}

#SPI Constraints
#################
set_output_delay -clock io_systemClk -reference_pin [get_ports {io_systemClk~CLKOUT~1~31}] -max 0.263 [get_ports {system_spi_0_io_sclk_write}]
set_output_delay -clock io_systemClk -reference_pin [get_ports {io_systemClk~CLKOUT~1~31}] -min 0.140 [get_ports {system_spi_0_io_sclk_write}]
set_output_delay -clock io_systemClk -reference_pin [get_ports {io_systemClk~CLKOUT~1~30}] -max 0.263 [get_ports {system_spi_0_io_ss}]
set_output_delay -clock io_systemClk -reference_pin [get_ports {io_systemClk~CLKOUT~1~30}] -min 0.140 [get_ports {system_spi_0_io_ss}]
set_input_delay -clock io_systemClk -reference_pin [get_ports {io_systemClk~CLKOUT~1~59}] -max 0.414 [get_ports {system_spi_0_io_data_0_read}]
set_input_delay -clock io_systemClk -reference_pin [get_ports {io_systemClk~CLKOUT~1~59}] -min 0.276 [get_ports {system_spi_0_io_data_0_read}]
set_output_delay -clock io_systemClk -reference_pin [get_ports {io_systemClk~CLKOUT~1~61}] -max 0.263 [get_ports {system_spi_0_io_data_0_write}]
set_output_delay -clock io_systemClk -reference_pin [get_ports {io_systemClk~CLKOUT~1~61}] -min 0.140 [get_ports {system_spi_0_io_data_0_write}]
set_output_delay -clock io_systemClk -reference_pin [get_ports {io_systemClk~CLKOUT~1~61}] -max 0.263 [get_ports {system_spi_0_io_data_0_writeEnable}]
set_output_delay -clock io_systemClk -reference_pin [get_ports {io_systemClk~CLKOUT~1~61}] -min 0.140 [get_ports {system_spi_0_io_data_0_writeEnable}]
set_input_delay -clock io_systemClk -reference_pin [get_ports {io_systemClk~CLKOUT~1~60}] -max 0.414 [get_ports {system_spi_0_io_data_1_read}]
set_input_delay -clock io_systemClk -reference_pin [get_ports {io_systemClk~CLKOUT~1~60}] -min 0.276 [get_ports {system_spi_0_io_data_1_read}]
set_output_delay -clock io_systemClk -reference_pin [get_ports {io_systemClk~CLKOUT~1~62}] -max 0.263 [get_ports {system_spi_0_io_data_1_write}]
set_output_delay -clock io_systemClk -reference_pin [get_ports {io_systemClk~CLKOUT~1~62}] -min 0.140 [get_ports {system_spi_0_io_data_1_write}]
set_output_delay -clock io_systemClk -reference_pin [get_ports {io_systemClk~CLKOUT~1~62}] -max 0.263 [get_ports {system_spi_0_io_data_1_writeEnable}]
set_output_delay -clock io_systemClk -reference_pin [get_ports {io_systemClk~CLKOUT~1~62}] -min 0.140 [get_ports {system_spi_0_io_data_1_writeEnable}]

# JTAG Constraints
####################
set_output_delay -clock jtag_inst1_TCK -max 0.117 [get_ports {jtag_inst1_TDO}]
set_output_delay -clock jtag_inst1_TCK -min 0.075 [get_ports {jtag_inst1_TDO}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.280 [get_ports {jtag_inst1_CAPTURE}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.187 [get_ports {jtag_inst1_CAPTURE}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.243 [get_ports {jtag_inst1_SEL}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.162 [get_ports {jtag_inst1_SEL}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.337 [get_ports {jtag_inst1_SHIFT}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.225 [get_ports {jtag_inst1_SHIFT}]
