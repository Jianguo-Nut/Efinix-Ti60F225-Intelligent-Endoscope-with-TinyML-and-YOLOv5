////////////////////////////////////////////////////////////////////////////
//           _____       
//          / _______    Copyright (C) 2013-2023 Efinix Inc. All rights reserved.
//         / /       \   
//        / /  ..    /   tb_soc.v
//       / / .'     /    
//    __/ /.'      /     Description:
//   __   \       /      Testbench for SapphireSoC simulation
//  /_/ /\ \_____/ /     
// ____/  \_______/      
//
// ***********************************************************************
// Revisions:
// 1.0 Initial rev
// 1.1 [Feature] Added configurable peripheral(s) based on user setting
// ***********************************************************************
`timescale 1ns / 1ps
//`define SKIP_TEST

module tb_soc ();

localparam PMHZ=50000000;
localparam  MHZ=100000000;

/////////////////////////////////////////////////////////////////////////////
wire		io_systemClk; 
wire        io_memoryClk;
wire        io_peripheralClk;
wire        systemClk_locked;
wire        memoryClk_locked;
wire        peripheralClk_locked;
wire        systemClk_rstn;
wire        memoryClk_rstn;
reg		    rst			            = 1'b1;
wire        systemClk_rst;
wire        memoryClk_rst;
//stimulus & monitor
reg		    uart_pass		        = 1'b0;
reg         uart_done               = 1'b0;
reg         uart_active             = 1'b0;
reg [191:0] uart_rdata;
reg [191:0] uart_mdata;
reg [10:0]	baudreg;
wire		baudtick;
reg [9:0]	uart_rxd_buffer;
integer		i,j,k;
//connection
wire 		system_spi_0_io_ss;
wire 		system_spi_0_io_sclk_write;
wire 		system_spi_0_io_data_0;
wire 		system_spi_0_io_data_1;
wire		system_uart_0_io_txd;
reg		    system_uart_0_io_rxd	= 1'b1;
wire        memoryCheckerPass;
wire		baudClk=io_systemClk;
reg  [10:0] BAUDRATE=(MHZ/115200);
wire  [7:0]	system_gpio_0_io;
wire  [1:0]	system_gpio_1_io;


/////////////////////////////////////////////////////////////////////////////
//system reset
initial begin
     rst = 1;
     repeat(100)@(posedge io_systemClk);
     rst = 0;
end

assign systemClk_rst = rst & ~systemClk_rstn;
assign memoryClk_rst = rst & ~memoryClk_rstn;

//system clock
clock_gen #(
        .FREQ_CLK_MHZ(MHZ/1000000)
) clock_gen_0_inst (
        .rst            (systemClk_rst),
        .clk_out0       (io_systemClk),
        .clk_out45      (),
        .clk_out90      (),
        .clk_out135     (),
        .locked         (systemClk_locked)
);
//memory clock
clock_gen #(
        .FREQ_CLK_MHZ(100)
) clock_gen_1_inst (
        .rst            (memoryClk_rst),
        .clk_out0       (io_memoryClk),
        .clk_out45      (),
        .clk_out90      (),
        .clk_out135     (),
        .locked         (memoryClk_locked)
);

//peripheral clock
clock_gen #(
        .FREQ_CLK_MHZ(PMHZ/1000000)
) clock_gen_2_inst (
        .rst            (systemClk_rst),
        .clk_out0       (io_peripheralClk),
        .clk_out45      (),
        .clk_out90      (),
        .clk_out135     (),
        .locked         (peripheralClk_locked)
);

//115200 baudrate
always@(posedge baudClk)
begin
	if(!uart_active)
		baudreg <= BAUDRATE/2;
	else begin
		if(baudreg !== BAUDRATE)
		baudreg <= baudreg + 1'b1;
		else
		baudreg <= 'h0;
	end
end

assign baudtick = (baudreg == BAUDRATE);

/////////////////////////////////////////////////////////////////////////////
`ifndef SKIP_TEST

initial
begin:system
	$display($time,,"-----------------------------------------");
	$display($time,,"[EFX_INFO]: Start executing helloWorld TEST");
	$display($time,,"-----------------------------------------");
end

initial 
begin:timeout
	#50000000
	$display($time,,"-----------------------------------------");
	$display($time,,"[EFX_FATAL]: Simulation timeout, aborting simulation  ");
	$display($time,,"-----------------------------------------");
	$finish;

end

initial 
begin:monitor
    uart_mdata =  { 8'h21,8'h78,8'h69,8'h6e,8'h69,8'h66,8'h45,8'h20,
                    8'h6d,8'h6f,8'h72,8'h66,8'h20,8'h64,8'h6c,8'h72,
                    8'h6f,8'h57,8'h20,8'h6f,8'h6c,8'h6c,8'h65,8'h48  };
	wait(uart_done);
    for(j=0; j<24; j=j+1)
    begin
        if (uart_rdata[j*8 +: 8] != uart_mdata[j*8 +:8])
        begin
		    $display($time,,"[EFX_FATAL]: Wrong data received on [%d], expect=0x%h, received=0x%h",j,uart_mdata[j*8 +:8], uart_rdata[j*8 +: 8]);
            $display($time,,"[EFX_FATAL]: Aborting simulation...");
		    $stop;
        end
    end
             
	$display($time,,"-----------------------------------------");
	$display($time,,"[EFX_INFO]: TEST PASSED ");
	$display($time,,"[EFX_INFO]: Hello World from Efinix!");
	$display($time,,"-----------------------------------------");
	$finish;
end

initial 
begin:uart
    k=0;
    forever
    begin
	    @(negedge system_uart_0_io_txd);
        if(k==0)
        begin
	        $display($time,,"-----------------------------------------");
	        $display($time,,"[EFX_INFO]: Receiving uart data from soc");
	        $display($time,,"-----------------------------------------");
        end
	    uart_active = 1;
	    for(i =0; i < 10; i=i+1)
	    begin
		    @(posedge baudtick);
		    uart_rxd_buffer[i] = system_uart_0_io_txd;
	    end
	    if(uart_rxd_buffer[0] !== 1'b0 && uart_rxd_buffer[9] !== 1'b1 ) begin
		    $display($time,,"[EFX_FATAL]: Data corrupted, aborting simulation");
		    $stop;
	    end
        uart_rdata[k*8 +: 8]=uart_rxd_buffer[8:1];
        if(uart_rxd_buffer[8:1] == 'h21)
        begin
            uart_done = 1'b1;
        end
    	uart_active = 0;
        k=k+1;
    end
end

`ifdef SKIP_INVALID_LOAD
initial 
begin:spi_monitor
    forever
    begin
        @(posedge system_spi_0_io_sclk_write);
        if(system_spi_0_io_data_1 === 1'bx)
        begin
            rst = 1;
            repeat(10)@(posedge io_systemClk);
            rst = 0;
        end
    end
end
`endif

`else

initial
begin:system
	$display($time,,"-----------------------------------------");
	$display($time,,"[EFX_INFO]: Executing custom binary file...");
	$display($time,,"[EFX_WARN]: Skipped testbench default driver and monitor sequences.");
	$display($time,,"[EFX_INFO]: Running simulation...");
	$display($time,,"-----------------------------------------");
end

initial 
begin:timeout
	#50000000
	$display($time,,"-----------------------------------------");
	$display($time,,"[EFX_FATAL]: Simulation timeout, aborting simulation  ");
	$display($time,,"-----------------------------------------");
	$finish;

end

`endif
//////////////////////////////////////////////////////////////////////////////

top_soc_wrapper dut_wrapper(
.system_gpio_1_io(system_gpio_1_io),
.system_gpio_0_io(system_gpio_0_io),

//clock and reset
.io_asyncResetn(~rst),
.io_systemClk(io_systemClk),
.systemClk_rstn(systemClk_rstn),
.systemClk_locked(systemClk_locked),
.memoryCheckerPass(memoryCheckerPass)
);



W25Q32JVxxIM spi_flash(
    .CSn    (system_spi_0_io_ss),
    .CLK    (system_spi_0_io_sclk_write),
    .RESETn (systemClk_locked),
    .DIO    (system_spi_0_io_data_0),
    .WPn    (),
    .HOLDn  (),
    .DO     (system_spi_0_io_data_1)
);

endmodule

//////////////////////////////////////////////////////////////////////////////

module top_soc_wrapper(
inout [1:0]	system_gpio_1_io,
inout [7:0]	system_gpio_0_io,

output      systemClk_rstn,
input       systemClk_locked,
input       io_systemClk,
input       io_asyncResetn,
output      memoryCheckerPass
);
//////////////////////////////////////////////////////////////////////////////
wire  [7:0]	system_gpio_0_io_read;
wire  [7:0]	system_gpio_0_io_write;
wire  [7:0]	system_gpio_0_io_writeEnable;
wire  [1:0]	system_gpio_1_io_read;
wire  [1:0]	system_gpio_1_io_write;
wire  [1:0]	system_gpio_1_io_writeEnable;



io_sim  #(.WIDTH(2),.REG(0)) gpio1_io_data ( 
.clk(io_systemClk),
.out_pad(system_gpio_1_io_write),
.out_oe(system_gpio_1_io_writeEnable),
.in_pad(system_gpio_1_io_read),
.io(system_gpio_1_io));

io_sim  #(.WIDTH(8),.REG(0)) gpio0_io_data ( 
.clk(io_systemClk),
.out_pad(system_gpio_0_io_write),
.out_oe(system_gpio_0_io_writeEnable),
.in_pad(system_gpio_0_io_read),
.io(system_gpio_0_io));

//////////////////////////////////////////////////////////////////////////////
top_soc dut (
.system_gpio_1_io_read(system_gpio_1_io_read),
.system_gpio_1_io_write(system_gpio_1_io_write),
.system_gpio_1_io_writeEnable(system_gpio_1_io_writeEnable),
.system_gpio_0_io_read(system_gpio_0_io_read),
.system_gpio_0_io_write(system_gpio_0_io_write),
.system_gpio_0_io_writeEnable(system_gpio_0_io_writeEnable),

//clock and reset
.io_asyncResetn(io_asyncResetn),
.io_systemClk(io_systemClk),
.systemClk_rstn(systemClk_rstn),
.systemClk_locked(systemClk_locked),
.memoryCheckerPass(memoryCheckerPass)
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

