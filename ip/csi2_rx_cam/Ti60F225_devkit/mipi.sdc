# Efinity Interface Designer SDC
# Version: 2024.M.263
# Date: 2024-10-02 16:57

# Copyright (C) 2013 - 2024 Efinix Inc. All rights reserved.

# Device: Ti60F225
# Project: top
# Timing Model: C4 (final)

# PLL Constraints
#################
create_clock -period 8.000 -name pixel_clk [get_ports {pixel_clk}]
create_clock -period 5.333 -name mipi_dphy_tx_SLOWCLK [get_ports {mipi_dphy_tx_SLOWCLK}]
create_clock -waveform {0.667 1.333} -period 1.333 -name mipi_dphy_tx_FASTCLK_C [get_ports {mipi_dphy_tx_FASTCLK_C}]
create_clock -waveform {0.333 1.000} -period 1.333 -name mipi_dphy_tx_FASTCLK_D [get_ports {mipi_dphy_tx_FASTCLK_D}]
create_clock -period 10.000 -name mipi_clk [get_ports {mipi_clk}]
create_clock -period 5.333 mipi_dphy_rx_clk_CLKOUT

set_clock_groups -exclusive -group {mipi_clk} -group {mipi_dphy_rx_clk_CLKOUT} -group {pixel_clk} 
set_clock_groups -exclusive -group {mipi_clk} -group {mipi_dphy_tx_SLOWCLK} -group {pixel_clk} 

set_multicycle_path 3 -setup -to [get_ports mipi_dphy_tx_clk_HS_OUT[*]] -end
set_multicycle_path 2 -hold -to [get_ports mipi_dphy_tx_clk_HS_OUT[*]] -end

# HSIO GPIO Constraints
#########################
# set_input_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {reset_n}]
# set_input_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {reset_n}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {led[2]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {led[2]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {led[3]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {led[3]}]

# MIPI RX Lane Constraints
############################
# create_clock -period <USER_PERIOD> [get_ports {mipi_dphy_rx_clk_CLKOUT}]
set_output_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~149~1}] -max 0.525 [get_ports {mipi_dphy_rx_data0_FIFO_RD}]
set_output_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~149~1}] -min 0.070 [get_ports {mipi_dphy_rx_data0_FIFO_RD}]
set_output_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~149~1}] -max 0.315 [get_ports {mipi_dphy_rx_data0_RST}]
set_output_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~149~1}] -min -0.140 [get_ports {mipi_dphy_rx_data0_RST}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~149~1}] -max 0.630 [get_ports {mipi_dphy_rx_data0_FIFO_EMPTY}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~149~1}] -min 0.420 [get_ports {mipi_dphy_rx_data0_FIFO_EMPTY}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~149~1}] -max 0.487 [get_ports {mipi_dphy_rx_data0_HS_IN[*]}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~149~1}] -min 0.325 [get_ports {mipi_dphy_rx_data0_HS_IN[*]}]
set_output_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~157~1}] -max 0.525 [get_ports {mipi_dphy_rx_data1_FIFO_RD}]
set_output_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~157~1}] -min 0.070 [get_ports {mipi_dphy_rx_data1_FIFO_RD}]
set_output_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~157~1}] -max 0.315 [get_ports {mipi_dphy_rx_data1_RST}]
set_output_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~157~1}] -min -0.140 [get_ports {mipi_dphy_rx_data1_RST}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~157~1}] -max 0.630 [get_ports {mipi_dphy_rx_data1_FIFO_EMPTY}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~157~1}] -min 0.420 [get_ports {mipi_dphy_rx_data1_FIFO_EMPTY}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~157~1}] -max 0.487 [get_ports {mipi_dphy_rx_data1_HS_IN[*]}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~157~1}] -min 0.325 [get_ports {mipi_dphy_rx_data1_HS_IN[*]}]
set_output_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~173~1}] -max 0.525 [get_ports {mipi_dphy_rx_data2_FIFO_RD}]
set_output_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~173~1}] -min 0.070 [get_ports {mipi_dphy_rx_data2_FIFO_RD}]
set_output_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~173~1}] -max 0.315 [get_ports {mipi_dphy_rx_data2_RST}]
set_output_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~173~1}] -min -0.140 [get_ports {mipi_dphy_rx_data2_RST}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~173~1}] -max 0.630 [get_ports {mipi_dphy_rx_data2_FIFO_EMPTY}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~173~1}] -min 0.420 [get_ports {mipi_dphy_rx_data2_FIFO_EMPTY}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~173~1}] -max 0.487 [get_ports {mipi_dphy_rx_data2_HS_IN[*]}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~173~1}] -min 0.325 [get_ports {mipi_dphy_rx_data2_HS_IN[*]}]
set_output_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~189~1}] -max 0.525 [get_ports {mipi_dphy_rx_data3_FIFO_RD}]
set_output_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~189~1}] -min 0.070 [get_ports {mipi_dphy_rx_data3_FIFO_RD}]
set_output_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~189~1}] -max 0.315 [get_ports {mipi_dphy_rx_data3_RST}]
set_output_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~189~1}] -min -0.140 [get_ports {mipi_dphy_rx_data3_RST}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~189~1}] -max 0.630 [get_ports {mipi_dphy_rx_data3_FIFO_EMPTY}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~189~1}] -min 0.420 [get_ports {mipi_dphy_rx_data3_FIFO_EMPTY}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~189~1}] -max 0.487 [get_ports {mipi_dphy_rx_data3_HS_IN[*]}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~189~1}] -min 0.325 [get_ports {mipi_dphy_rx_data3_HS_IN[*]}]

# MIPI TX Lane Constraints
############################
set_output_delay -clock mipi_dphy_tx_FASTCLK_D -reference_pin [get_ports {mipi_dphy_tx_FASTCLK_D~CLKOUT~45~1}] -max 0.378 [get_ports {mipi_dphy_tx_clk_HS_OUT[*]}]
set_output_delay -clock mipi_dphy_tx_FASTCLK_D -reference_pin [get_ports {mipi_dphy_tx_FASTCLK_D~CLKOUT~45~1}] -min -0.140 [get_ports {mipi_dphy_tx_clk_HS_OUT[*]}]
set_output_delay -clock mipi_dphy_tx_FASTCLK_D -reference_pin [get_ports {mipi_dphy_tx_FASTCLK_D~CLKOUT~45~1}] -max 0.315 [get_ports {mipi_dphy_tx_clk_RST}]
set_output_delay -clock mipi_dphy_tx_FASTCLK_D -reference_pin [get_ports {mipi_dphy_tx_FASTCLK_D~CLKOUT~45~1}] -min -0.140 [get_ports {mipi_dphy_tx_clk_RST}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~21~1}] -max 0.378 [get_ports {mipi_dphy_tx_data0_HS_OUT[*]}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~21~1}] -min -0.140 [get_ports {mipi_dphy_tx_data0_HS_OUT[*]}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~21~1}] -max 0.315 [get_ports {mipi_dphy_tx_data0_RST}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~21~1}] -min -0.140 [get_ports {mipi_dphy_tx_data0_RST}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~29~1}] -max 0.378 [get_ports {mipi_dphy_tx_data1_HS_OUT[*]}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~29~1}] -min -0.140 [get_ports {mipi_dphy_tx_data1_HS_OUT[*]}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~29~1}] -max 0.315 [get_ports {mipi_dphy_tx_data1_RST}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~29~1}] -min -0.140 [get_ports {mipi_dphy_tx_data1_RST}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~37~1}] -max 0.378 [get_ports {mipi_dphy_tx_data2_HS_OUT[*]}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~37~1}] -min -0.140 [get_ports {mipi_dphy_tx_data2_HS_OUT[*]}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~37~1}] -max 0.315 [get_ports {mipi_dphy_tx_data2_RST}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~37~1}] -min -0.140 [get_ports {mipi_dphy_tx_data2_RST}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~54~1}] -max 0.378 [get_ports {mipi_dphy_tx_data3_HS_OUT[*]}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~54~1}] -min -0.140 [get_ports {mipi_dphy_tx_data3_HS_OUT[*]}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~54~1}] -max 0.315 [get_ports {mipi_dphy_tx_data3_RST}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~54~1}] -min -0.140 [get_ports {mipi_dphy_tx_data3_RST}]

# Clock Latency Constraints
############################
# set_clock_latency -source -setup <pll_clk_latency_mipi_clk_max + 1.793> [get_ports {CLKOUT0}]
# set_clock_latency -source -hold <pll_clk_latency_mipi_clk_min + 1.161> [get_ports {CLKOUT0}]
# set_clock_latency -source -setup <pll_clk_latency_mipi_clk_max + 1.793> [get_ports {pixel_clk}]
# set_clock_latency -source -hold <pll_clk_latency_mipi_clk_min + 1.161> [get_ports {pixel_clk}]
# set_clock_latency -source -setup <board_max -1.053> [get_ports {mipi_dphy_tx_SLOWCLK}]
# set_clock_latency -source -hold <board_min -0.665> [get_ports {mipi_dphy_tx_SLOWCLK}]
# set_clock_latency -source -setup <board_max -1.053> [get_ports {mipi_dphy_tx_FASTCLK_C}]
# set_clock_latency -source -hold <board_min -0.665> [get_ports {mipi_dphy_tx_FASTCLK_C}]
# set_clock_latency -source -setup <board_max -1.053> [get_ports {mipi_dphy_tx_FASTCLK_D}]
# set_clock_latency -source -hold <board_min -0.665> [get_ports {mipi_dphy_tx_FASTCLK_D}]
# set_clock_latency -source -setup <board_max -1.053> [get_ports {mipi_clk}]
# set_clock_latency -source -hold <board_min -0.665> [get_ports {mipi_clk}]
