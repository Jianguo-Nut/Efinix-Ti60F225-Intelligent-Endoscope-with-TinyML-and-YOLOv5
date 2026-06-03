/////////////////////////////////////////////////////////////////////////////
//
// Copyright (C) 2013-2023 Efinix Inc. All rights reserved.
//
// Description:
// Example top file for EfxSapphireSoc
//
// Language:  Verilog 2001
//
// ------------------------------------------------------------------------------
// REVISION:
//  $Snapshot: $
//  $Id:$
//
// History:
// 1.0 Initial Release. 
/////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module top_soc (
output		system_i2c_0_io_sda_writeEnable,
output		system_i2c_0_io_sda_write,
input		system_i2c_0_io_sda_read,
output		system_i2c_0_io_scl_writeEnable,
output		system_i2c_0_io_scl_write,
input		system_i2c_0_io_scl_read,
input		io_memoryClk,
output		system_uart_0_io_txd,
input		system_uart_0_io_rxd,
output		system_spi_0_io_sclk_write,
output		system_spi_0_io_data_0_writeEnable,
input		system_spi_0_io_data_0_read,
output		system_spi_0_io_data_0_write,
output		system_spi_0_io_data_1_writeEnable,
input		system_spi_0_io_data_1_read,
output		system_spi_0_io_data_1_write,
output		system_spi_0_io_ss,
input		io_peripheralClk,
input		jtag_inst1_TCK,
input		jtag_inst1_TDI,
output		jtag_inst1_TDO,
input		jtag_inst1_SEL,
input		jtag_inst1_CAPTURE,
input		jtag_inst1_SHIFT,
input		jtag_inst1_UPDATE,
input		jtag_inst1_RESET,
output		io_ddrA_arw_valid,
input		io_ddrA_arw_ready,
output [31:0] io_ddrA_arw_payload_addr,
output [7:0] io_ddrA_arw_payload_id,
output [7:0] io_ddrA_arw_payload_len,
output [2:0] io_ddrA_arw_payload_size,
output [1:0] io_ddrA_arw_payload_burst,
output [1:0] io_ddrA_arw_payload_lock,
output		io_ddrA_arw_payload_write,
output [7:0] io_ddrA_w_payload_id,
output		io_ddrA_w_valid,
input		io_ddrA_w_ready,
output [127:0] io_ddrA_w_payload_data,
output [15:0] io_ddrA_w_payload_strb,
output		io_ddrA_w_payload_last,
input		io_ddrA_b_valid,
output		io_ddrA_b_ready,
input [7:0] io_ddrA_b_payload_id,
input		io_ddrA_r_valid,
output		io_ddrA_r_ready,
input [127:0] io_ddrA_r_payload_data,
input [7:0] io_ddrA_r_payload_id,
input [1:0] io_ddrA_r_payload_resp,
input		io_ddrA_r_payload_last,
output		ddr_inst1_CFG_SEQ_START,
output		ddr_inst1_CFG_RST_N,
output		ddr_inst1_CFG_SEQ_RST,
output		memoryClk_rstn,

output      memoryCheckerPass,
output      systemClk_rstn,
input       systemClk_locked,
input       io_systemClk,
input       io_asyncResetn

);
/////////////////////////////////////////////////////////////////////////////
//Reset and PLL
wire 		reset;
wire        w_io_asyncReset;
wire		io_systemReset;
wire 	    io_memoryReset;				
wire [1:0]  io_ddrA_b_payload_resp=2'b00;
wire [15:0] io_apbSlave_0_PADDR;
wire		io_apbSlave_0_PSEL;
wire		io_apbSlave_0_PENABLE;
wire		io_apbSlave_0_PREADY;
wire		io_apbSlave_0_PWRITE;
wire [31:0] io_apbSlave_0_PWDATA;
wire [31:0] io_apbSlave_0_PRDATA;
wire		io_apbSlave_0_PSLVERROR;
wire		start;
wire [31:0] iaddr;
wire [31:0] idata;
wire [7:0]  ilen;
wire [1:0]  status;
wire [15:0] io_apbSlave_1_PADDR;
wire		io_apbSlave_1_PSEL;
wire		io_apbSlave_1_PENABLE;
wire		io_apbSlave_1_PREADY;
wire		io_apbSlave_1_PWRITE;
wire [31:0] io_apbSlave_1_PWDATA;
wire [31:0] io_apbSlave_1_PRDATA;
wire		io_apbSlave_1_PSLVERROR;
wire		ddrReset;
wire		io_ddrA_ar_valid;
wire		io_ddrA_ar_ready;
wire [31:0] io_ddrA_ar_payload_addr;
wire [7:0] io_ddrA_ar_payload_id;
wire [7:0] io_ddrA_ar_payload_len;
wire [2:0] io_ddrA_ar_payload_size;
wire [1:0] io_ddrA_ar_payload_burst;
wire [1:0] io_ddrA_ar_payload_lock;
wire		io_ddrA_aw_valid;
wire		io_ddrA_aw_ready;
wire [31:0] io_ddrA_aw_payload_addr;
wire [7:0] io_ddrA_aw_payload_id;
wire [7:0] io_ddrA_aw_payload_len;
wire [2:0] io_ddrA_aw_payload_size;
wire [1:0] io_ddrA_aw_payload_burst;
wire [1:0] io_ddrA_aw_payload_lock;
wire [7:0] soc_ddrA_ar_payload_id;
wire [7:0] soc_ddrA_aw_payload_id;
wire [7:0] soc_ddrA_b_payload_id;
wire [7:0] soc_ddrA_r_payload_id;
wire userInterrupt_0;
wire io_peripheralReset;
wire cpu0_customInstruction_cmd_valid;
wire		cpu0_customInstruction_cmd_ready;
wire [9:0] cpu0_customInstruction_function_id;
wire [31:0] cpu0_customInstruction_inputs_0;
wire [31:0] cpu0_customInstruction_inputs_1;
wire		cpu0_customInstruction_rsp_valid;
wire		cpu0_customInstruction_rsp_ready;
wire [31:0] cpu0_customInstruction_outputs_0;
wire userInterrupt_1;


/////////////////////////////////////////////////////////////////////////////
//Reset and PLL
assign reset 	= ~( io_asyncResetn & systemClk_locked);
assign systemClk_rstn 	= 1'b1;
assign io_ddrA_w_payload_id='h0;
assign io_ddrA_aw_payload_id = soc_ddrA_aw_payload_id;
assign io_ddrA_ar_payload_id = soc_ddrA_ar_payload_id;
assign soc_ddrA_b_payload_id = io_ddrA_b_payload_id;
assign soc_ddrA_r_payload_id = io_ddrA_r_payload_id;
assign system_i2c_0_io_sda_writeEnable = !system_i2c_0_io_sda_write;
assign system_i2c_0_io_scl_writeEnable = !system_i2c_0_io_scl_write;
assign w_io_asyncReset = reset ;
assign memoryCheckerPass=1'b0;
assign memoryClk_rstn=1'b1;


/////////////////////////////////////////////////////////////////////////////
timer_start #(
.MHZ(100),
.SECOND(10),
.PULSE(1)
) intr_s0 (
.clk(io_peripheralClk),
.rst_n(~io_peripheralReset),
.start(userInterrupt_0));

custom_instruction_tea cpu0_custom_instruction_tea_inst(
.clk(io_systemClk),
.reset(io_systemReset),
.cmd_valid(cpu0_customInstruction_cmd_valid),
.cmd_ready(cpu0_customInstruction_cmd_ready),
.cmd_function_id(cpu0_customInstruction_function_id),
.cmd_inputs_0(cpu0_customInstruction_inputs_0),
.cmd_inputs_1(cpu0_customInstruction_inputs_1),
.rsp_valid(cpu0_customInstruction_rsp_valid),
.rsp_ready(cpu0_customInstruction_rsp_ready),
.rsp_outputs_0(cpu0_customInstruction_outputs_0));

apb3_slave #(
.ADDR_WIDTH(16)) apb_slave_0 (
.clk(io_peripheralClk),
.resetn(~io_peripheralReset),
.PADDR(io_apbSlave_0_PADDR),
.PSEL(io_apbSlave_0_PSEL),
.PENABLE(io_apbSlave_0_PENABLE),
.PREADY(io_apbSlave_0_PREADY),
.PWRITE(io_apbSlave_0_PWRITE),
.PWDATA(io_apbSlave_0_PWDATA),
.PRDATA(io_apbSlave_0_PRDATA),
.PSLVERROR(io_apbSlave_0_PSLVERROR),
.start(start),
.iaddr(iaddr),
.ilen(ilen),
.idata(idata),
.status(status));

ddr_reset_sequencer#(
.FREQ(100)
) reset_sequencer (
.ddr_rstn_i(~io_memoryReset),
.clk(io_memoryClk),
.ddr_rstn(ddr_inst1_CFG_RST_N),
.ddr_cfg_seq_rst(ddr_inst1_CFG_SEQ_RST),
.ddr_cfg_seq_start(ddr_inst1_CFG_SEQ_START),
.ddr_init_done(ddrReset));

fd_to_hd_wrapper fd_to_hd_wrapper_inst(
.clk(io_memoryClk),
.reset(~ddrReset),
.io_ddrA_arw_valid(io_ddrA_arw_valid),
.io_ddrA_arw_ready(io_ddrA_arw_ready),
.io_ddrA_arw_payload_addr(io_ddrA_arw_payload_addr),
.io_ddrA_arw_payload_id(io_ddrA_arw_payload_id),
.io_ddrA_arw_payload_len(io_ddrA_arw_payload_len),
.io_ddrA_arw_payload_size(io_ddrA_arw_payload_size),
.io_ddrA_arw_payload_burst(io_ddrA_arw_payload_burst),
.io_ddrA_arw_payload_lock(io_ddrA_arw_payload_lock),
.io_ddrA_arw_payload_write(io_ddrA_arw_payload_write),
.io_ddrA_aw_valid(io_ddrA_aw_valid),
.io_ddrA_aw_ready(io_ddrA_aw_ready),
.io_ddrA_aw_payload_addr(io_ddrA_aw_payload_addr),
.io_ddrA_aw_payload_id(io_ddrA_aw_payload_id),
.io_ddrA_aw_payload_len(io_ddrA_aw_payload_len),
.io_ddrA_aw_payload_size(io_ddrA_aw_payload_size),
.io_ddrA_aw_payload_burst(io_ddrA_aw_payload_burst),
.io_ddrA_aw_payload_lock(io_ddrA_aw_payload_lock),
.io_ddrA_ar_valid(io_ddrA_ar_valid),
.io_ddrA_ar_ready(io_ddrA_ar_ready),
.io_ddrA_ar_payload_addr(io_ddrA_ar_payload_addr),
.io_ddrA_ar_payload_id(io_ddrA_ar_payload_id),
.io_ddrA_ar_payload_len(io_ddrA_ar_payload_len),
.io_ddrA_ar_payload_size(io_ddrA_ar_payload_size),
.io_ddrA_ar_payload_burst(io_ddrA_ar_payload_burst),
.io_ddrA_ar_payload_lock(io_ddrA_ar_payload_lock));

timer_start #(
.MHZ(100),
.SECOND(12),
.PULSE(1)
) intr_s1 (
.clk(io_peripheralClk),
.rst_n(~io_peripheralReset),
.start(userInterrupt_1));

apb3_slave #(
.ADDR_WIDTH(16)) apb_slave_1 (
.clk(io_peripheralClk),
.resetn(~io_peripheralReset),
.PADDR(io_apbSlave_1_PADDR),
.PSEL(io_apbSlave_1_PSEL),
.PENABLE(io_apbSlave_1_PENABLE),
.PREADY(io_apbSlave_1_PREADY),
.PWRITE(io_apbSlave_1_PWRITE),
.PWDATA(io_apbSlave_1_PWDATA),
.PRDATA(io_apbSlave_1_PRDATA),
.PSLVERROR(io_apbSlave_1_PSLVERROR),
.start(),
.iaddr(),
.ilen(),
.idata(),
.status(2'b00));



/////////////////////////////////////////////////////////////////////////////

sapphire_soc soc_inst
(
.io_peripheralClk(io_peripheralClk),
.io_peripheralReset(io_peripheralReset),
.io_apbSlave_0_PADDR(io_apbSlave_0_PADDR),
.io_apbSlave_0_PSEL(io_apbSlave_0_PSEL),
.io_apbSlave_0_PENABLE(io_apbSlave_0_PENABLE),
.io_apbSlave_0_PREADY(io_apbSlave_0_PREADY),
.io_apbSlave_0_PWRITE(io_apbSlave_0_PWRITE),
.io_apbSlave_0_PWDATA(io_apbSlave_0_PWDATA),
.io_apbSlave_0_PRDATA(io_apbSlave_0_PRDATA),
.io_apbSlave_0_PSLVERROR(io_apbSlave_0_PSLVERROR),
.io_ddrA_aw_valid(io_ddrA_aw_valid),
.io_ddrA_aw_ready(io_ddrA_aw_ready),
.io_ddrA_aw_payload_addr(io_ddrA_aw_payload_addr),
.io_ddrA_aw_payload_id(soc_ddrA_aw_payload_id),
.io_ddrA_aw_payload_len(io_ddrA_aw_payload_len),
.io_ddrA_aw_payload_size(io_ddrA_aw_payload_size),
.io_ddrA_aw_payload_burst(io_ddrA_aw_payload_burst),
.io_ddrA_aw_payload_lock(io_ddrA_aw_payload_lock[0]),
.io_ddrA_aw_payload_prot(),
.io_ddrA_aw_payload_qos(),
.io_ddrA_aw_payload_cache(),
.io_ddrA_aw_payload_region(),
.io_ddrA_ar_valid(io_ddrA_ar_valid),
.io_ddrA_ar_ready(io_ddrA_ar_ready),
.io_ddrA_ar_payload_addr(io_ddrA_ar_payload_addr),
.io_ddrA_ar_payload_id(soc_ddrA_ar_payload_id),
.io_ddrA_ar_payload_len(io_ddrA_ar_payload_len),
.io_ddrA_ar_payload_size(io_ddrA_ar_payload_size),
.io_ddrA_ar_payload_burst(io_ddrA_ar_payload_burst),
.io_ddrA_ar_payload_lock(io_ddrA_ar_payload_lock[0]),
.io_ddrA_ar_payload_prot(),
.io_ddrA_ar_payload_qos(),
.io_ddrA_ar_payload_cache(),
.io_ddrA_ar_payload_region(),
.io_ddrA_w_valid(io_ddrA_w_valid),
.io_ddrA_w_ready(io_ddrA_w_ready),
.io_ddrA_w_payload_data(io_ddrA_w_payload_data),
.io_ddrA_w_payload_strb(io_ddrA_w_payload_strb),
.io_ddrA_w_payload_last(io_ddrA_w_payload_last),
.io_ddrA_b_valid(io_ddrA_b_valid),
.io_ddrA_b_ready(io_ddrA_b_ready),
.io_ddrA_b_payload_id(soc_ddrA_b_payload_id),
.io_ddrA_b_payload_resp(io_ddrA_b_payload_resp),
.io_ddrA_r_valid(io_ddrA_r_valid),
.io_ddrA_r_ready(io_ddrA_r_ready),
.io_ddrA_r_payload_data(io_ddrA_r_payload_data),
.io_ddrA_r_payload_id(soc_ddrA_r_payload_id),
.io_ddrA_r_payload_resp(io_ddrA_r_payload_resp),
.io_ddrA_r_payload_last(io_ddrA_r_payload_last),
.system_uart_0_io_txd(system_uart_0_io_txd),
.system_uart_0_io_rxd(system_uart_0_io_rxd),
.io_apbSlave_1_PADDR(io_apbSlave_1_PADDR),
.io_apbSlave_1_PSEL(io_apbSlave_1_PSEL),
.io_apbSlave_1_PENABLE(io_apbSlave_1_PENABLE),
.io_apbSlave_1_PREADY(io_apbSlave_1_PREADY),
.io_apbSlave_1_PWRITE(io_apbSlave_1_PWRITE),
.io_apbSlave_1_PWDATA(io_apbSlave_1_PWDATA),
.io_apbSlave_1_PRDATA(io_apbSlave_1_PRDATA),
.io_apbSlave_1_PSLVERROR(io_apbSlave_1_PSLVERROR),
.userInterruptB(userInterrupt_1),
.system_spi_0_io_sclk_write(system_spi_0_io_sclk_write),
.system_spi_0_io_data_0_writeEnable(system_spi_0_io_data_0_writeEnable),
.system_spi_0_io_data_0_read(system_spi_0_io_data_0_read),
.system_spi_0_io_data_0_write(system_spi_0_io_data_0_write),
.system_spi_0_io_data_1_writeEnable(system_spi_0_io_data_1_writeEnable),
.system_spi_0_io_data_1_read(system_spi_0_io_data_1_read),
.system_spi_0_io_data_1_write(system_spi_0_io_data_1_write),
.system_spi_0_io_data_2_writeEnable(),
.system_spi_0_io_data_2_read(),
.system_spi_0_io_data_2_write(),
.system_spi_0_io_data_3_writeEnable(),
.system_spi_0_io_data_3_read(),
.system_spi_0_io_data_3_write(),
.system_spi_0_io_ss(system_spi_0_io_ss),
.jtagCtrl_tck(jtag_inst1_TCK),
.jtagCtrl_tdi(jtag_inst1_TDI),
.jtagCtrl_tdo(jtag_inst1_TDO),
.jtagCtrl_enable(jtag_inst1_SEL),
.jtagCtrl_capture(jtag_inst1_CAPTURE),
.jtagCtrl_shift(jtag_inst1_SHIFT),
.jtagCtrl_update(jtag_inst1_UPDATE),
.jtagCtrl_reset(jtag_inst1_RESET),
.userInterruptA(userInterrupt_0),
.cpu0_customInstruction_cmd_valid(cpu0_customInstruction_cmd_valid),
.cpu0_customInstruction_cmd_ready(cpu0_customInstruction_cmd_ready),
.cpu0_customInstruction_function_id(cpu0_customInstruction_function_id),
.cpu0_customInstruction_inputs_0(cpu0_customInstruction_inputs_0),
.cpu0_customInstruction_inputs_1(cpu0_customInstruction_inputs_1),
.cpu0_customInstruction_rsp_valid(cpu0_customInstruction_rsp_valid),
.cpu0_customInstruction_rsp_ready(cpu0_customInstruction_rsp_ready),
.cpu0_customInstruction_outputs_0(cpu0_customInstruction_outputs_0),
.io_memoryClk(io_memoryClk),
.io_memoryReset(io_memoryReset),
.system_i2c_0_io_sda_write(system_i2c_0_io_sda_write),
.system_i2c_0_io_sda_read(system_i2c_0_io_sda_read),
.system_i2c_0_io_scl_write(system_i2c_0_io_scl_write),
.system_i2c_0_io_scl_read(system_i2c_0_io_scl_read),

.io_systemClk(io_systemClk),
.io_asyncReset(w_io_asyncReset),
.io_systemReset(io_systemReset)		
);

endmodule

//////////////////////////////////////////////////////////////////////////////
// Copyright (C) 2013-2023 Efinix Inc. All rights reserved.
//
// This   document  contains  proprietary information  which   is
// protected by  copyright. All rights  are reserved.  This notice
// refers to original work by Efinix, Inc. which may be derivitive
// of other work distributed under license of the authors.  In the
// case of derivative work, nothing in this notice overrides the
// original author's license agreement.  Where applicable, the 
// original license agreement is included in it's original 
// unmodified form immediately below this header.
//
// WARRANTY DISCLAIMER.  
//     THE  DESIGN, CODE, OR INFORMATION ARE PROVIDED “AS IS” AND 
//     EFINIX MAKES NO WARRANTIES, EXPRESS OR IMPLIED WITH 
//     RESPECT THERETO, AND EXPRESSLY DISCLAIMS ANY IMPLIED WARRANTIES, 
//     INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF 
//     MERCHANTABILITY, NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR 
//     PURPOSE.  SOME STATES DO NOT ALLOW EXCLUSIONS OF AN IMPLIED 
//     WARRANTY, SO THIS DISCLAIMER MAY NOT APPLY TO LICENSEE.
//
// LIMITATION OF LIABILITY.  
//     NOTWITHSTANDING ANYTHING TO THE CONTRARY, EXCEPT FOR BODILY 
//     INJURY, EFINIX SHALL NOT BE LIABLE WITH RESPECT TO ANY SUBJECT 
//     MATTER OF THIS AGREEMENT UNDER TORT, CONTRACT, STRICT LIABILITY 
//     OR ANY OTHER LEGAL OR EQUITABLE THEORY (I) FOR ANY INDIRECT, 
//     SPECIAL, INCIDENTAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES OF ANY 
//     CHARACTER INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF 
//     GOODWILL, DATA OR PROFIT, WORK STOPPAGE, OR COMPUTER FAILURE OR 
//     MALFUNCTION, OR IN ANY EVENT (II) FOR ANY AMOUNT IN EXCESS, IN 
//     THE AGGREGATE, OF THE FEE PAID BY LICENSEE TO EFINIX HEREUNDER 
//     (OR, IF THE FEE HAS BEEN WAIVED, $100), EVEN IF EFINIX SHALL HAVE 
//     BEEN INFORMED OF THE POSSIBILITY OF SUCH DAMAGES.  SOME STATES DO 
//     NOT ALLOW THE EXCLUSION OR LIMITATION OF INCIDENTAL OR 
//     CONSEQUENTIAL DAMAGES, SO THIS LIMITATION AND EXCLUSION MAY NOT 
//     APPLY TO LICENSEE.
//
/////////////////////////////////////////////////////////////////////////////
