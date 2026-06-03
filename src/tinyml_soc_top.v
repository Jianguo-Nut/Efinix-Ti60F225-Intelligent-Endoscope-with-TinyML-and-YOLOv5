//***************************************************************/
//
// Moudel Name    : ddr3_example_top.v
// Version        : 1.1
// Date Created   : 2023-02-23 10:37:59
// Last Modified  : 2023-02-24 15:27:41
// Abstract       : ---
//
//***************************************************************/
//Modification History
//1.initial
//***************************************************************/
`include "ddr3_controller/ddr3_parameter.vh"
`include "define.v"
`include "src/tinyml/defines.v"
module tinyml_soc_top #
(
parameter                       RANK_RATIO         = 1,       // # of unique CS outputs per rank
parameter                       CK_RATIO           = `CK_RATIO, 
parameter                       ASYN_AXI_CLK       = `ASYN_AXI_CLK, 
parameter                       RANKS              = `RANKS,
parameter                       CK_WIDTH           = `CK_WIDTH,       // # of CK/CK# outputs to memory   
parameter                       CKE_WIDTH          = `CKE_WIDTH,       // # of cke outputs
parameter                       CS_WIDTH           = `CS_WIDTH,       // # of unique CS outputs
parameter                       BANK_WIDTH         = `BANK_WIDTH,       // # of bank bits
parameter                       ROW_WIDTH          = `ROW_WIDTH,       // DRAM address bus width
parameter                       COL_WIDTH          = `COL_WIDTH,      // column address width
parameter                       DM_WIDTH           = `DM_WIDTH,       // # of DM (data mask)
parameter                       DQS_WIDTH          = `DQS_WIDTH,       // # of DQS (strobe)
parameter                       DQ_WIDTH           = `DQ_WIDTH,      // # of DQ (data)
parameter                       ODT_WIDTH          = `ODT_WIDTH,
parameter                       DQ_CNT_WIDTH       = `DQ_CNT_WIDTH,       // = ceil(log2(DQ_WIDTH))
parameter                       DQS_CNT_WIDTH      = `DQS_CNT_WIDTH,       // = ceil(log2(DQS_WIDTH))  
parameter                       DRAM_WIDTH         = `DRAM_WIDTH,       // # of DQ per DQS   
parameter                       DATA_WIDTH         = `DATA_WIDTH,
parameter                       ADDR_WIDTH         = `ADDR_WIDTH,    
parameter                       AXI_ID_WIDTH       = `AXI_ID_WIDTH,
parameter                       AXI_ADDR_WIDTH     = `AXI_ADDR_WIDTH,
parameter                       AXI_DATA_WIDTH     = `AXI_DATA_WIDTH,
//Input frame resolution from MIPI Rx.
parameter                       MIPI_FRAME_WIDTH      = 1280,  
parameter                       MIPI_FRAME_HEIGHT     = 960,
//Actual frame resolution used for subsequent processing (after cropping/scaling).
parameter                       FRAME_WIDTH           = 1280, //Multiple of 2 - To match with 2PPC pixel data.
parameter                       FRAME_HEIGHT          = 720  //Multiple of 2 - To preserve bayer format prior to raw2rgb conversion.
)
(
   //Keys
   input                              k1,
   input                              k2,

   //soc external GPIO
   output [1:0]                       system_gpio_1_io_write,
   input  [1:0]                       system_gpio_1_io_read,
   output [1:0]                       system_gpio_1_io_writeEnable,

   output                             system_spi_0_io_sclk_write,
   output                             system_spi_0_io_data_0_writeEnable,
   input                              system_spi_0_io_data_0_read,
   output                             system_spi_0_io_data_0_write,
   output                             system_spi_0_io_data_1_writeEnable,
   input                              system_spi_0_io_data_1_read,
   output                             system_spi_0_io_data_1_write,
   output                             system_spi_0_io_ss,
   // Clock and reset ports
   input                              core_clk,     // CORE CLK @ 100MHz
   input                              sdram_clk,    // SDRAM CK @ 400MHz
   input                              rx_cal_clk,   // SDRAM CK @ 400MHz
   input                              tx_cal_clk,   // SDRAM CK @ 400MHz
   input                              tx_cal_clk_90edge,   // SDRAM CK @ 400MHz
   input                              pll_locked,
   input                              user_pll_locked,
   input                              i_sysclk,
   input                              i_peripheralClk,
   input                              i_fb_clk,
   input                              clk_pixel,
   input                              clk_pixel_2x,
   input                              clk_pixel_10x,
   //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

   ////////////////////////////////////////////////////////////////
	//	UART Interface
	input 		 	uart_rx_i,			
	output 		 	uart_tx_o, 
	
	//	LEDs
	output 	[5:0] 	led_o,			

`ifdef  Efinity_Debug  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& 
  input                               jtag_inst1_CAPTURE ,
  input                               jtag_inst1_DRCK    ,
  input                               jtag_inst1_RESET   ,
  input                               jtag_inst1_RUNTEST ,
  input                               jtag_inst1_SEL     ,
  input                               jtag_inst1_SHIFT   ,
  input                               jtag_inst1_TCK     ,
  input                               jtag_inst1_TDI     ,
  input                               jtag_inst1_TMS     ,
  input                               jtag_inst1_UPDATE  ,
  output                              jtag_inst1_TDO     ,
`endif  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
   

   ////////////////////////////////////////////////////////////////
	//	MIPI-CSI Ctl / I2C
	output 			csi_ctl0_o,
	output 			csi_ctl0_oe,
	input 			csi_ctl0_i,
	
	output 			csi_ctl1_o,
	output 			csi_ctl1_oe,
	input 			csi_ctl1_i,
	
	output 			csi_scl_o,
	output 			csi_scl_oe,
	input 			csi_scl_i,
	
	output 			csi_sda_o,
	output 			csi_sda_oe,
	input 			csi_sda_i,
	
	//	MIPI-CSI RXC 
	input 			csi_rxc_lp_p_i,
	input 			csi_rxc_lp_n_i,
	output 			csi_rxc_hs_en_o,
	output 			csi_rxc_hs_term_en_o,
	input 			csi_rxc_i,
	
	//	MIPI-CSI RXD0
	output 			csi_rxd0_rst_o,
	output 			csi_rxd0_hs_en_o,
	output 			csi_rxd0_hs_term_en_o,
	
	input 			csi_rxd0_lp_p_i,
	input 			csi_rxd0_lp_n_i,
	input 	[7:0] 	csi_rxd0_hs_i,
	
	//	MIPI-CSI RXD1
	output 			csi_rxd1_rst_o,
	output 			csi_rxd1_hs_en_o,
	output 			csi_rxd1_hs_term_en_o,
	
	input 			csi_rxd1_lp_n_i,
	input 			csi_rxd1_lp_p_i,
	input 	[7:0] 	csi_rxd1_hs_i,
	
	//	MIPI-CSI RXD2
	output 			csi_rxd2_rst_o,
	output 			csi_rxd2_hs_en_o,
	output 			csi_rxd2_hs_term_en_o,
	
	input 			csi_rxd2_lp_p_i,
	input 			csi_rxd2_lp_n_i,
	input 	[7:0] 	csi_rxd2_hs_i,
	
	//	MIPI-CSI RXD3
	output 			csi_rxd3_rst_o,
	output 			csi_rxd3_hs_en_o,
	output 			csi_rxd3_hs_term_en_o,
	
	input 			csi_rxd3_lp_p_i,
	input 			csi_rxd3_lp_n_i,
	input 	[7:0] 	csi_rxd3_hs_i,


  //HDMI Interface
  	//	HDMI Interface
	output 			                        hdmi_txc_oe,
	output 			                        hdmi_txd0_oe,
	output 			                        hdmi_txd1_oe,
	output 			                        hdmi_txd2_oe,
	
	output 			                        hdmi_txc_rst_o,
	output 			                        hdmi_txd0_rst_o,
	output 			                        hdmi_txd1_rst_o,
	output 			                        hdmi_txd2_rst_o,
	
	output 	[9:0] 	                    hdmi_txc_o,
	output 	[9:0] 	                    hdmi_txd0_o,
	output 	[9:0] 	                    hdmi_txd1_o,
	output 	[9:0] 	                    hdmi_txd2_o,
    
   // PLL status flags  
   output [2:0]                       pll_shift,  
   output [4:0]                       pll_shift_sel,
   output                             pll_shift_ena,  
   // memory interface ports
   output                             ddr_ck_hi,
   output                             ddr_ck_lo,
   output                             ddr_reset_n,
   output [CKE_WIDTH-1:0]             ddr_cke,     
   output [ROW_WIDTH-1:0]             ddr_addr,
   output [BANK_WIDTH-1:0]            ddr_ba,
   output                             ddr_cas_n,

   output [CS_WIDTH*RANK_RATIO-1:0]   ddr_cs_n,
   output                             ddr_ras_n,
   output                             ddr_we_n,
   
   input  [DQS_WIDTH-1:0]             ddr_dqs_in_hi,
   input  [DQS_WIDTH-1:0]             ddr_dqs_in_lo,
   input  [DQ_WIDTH-1:0]              ddr_dq_in_hi,
   input  [DQ_WIDTH-1:0]              ddr_dq_in_lo,
   
   output [DQS_WIDTH-1:0]             ddr_dqs_oe,
   output [DQS_WIDTH-1:0]             ddr_dqs_oe_n,
   output [DQ_WIDTH-1:0]              ddr_dq_oe,  
   output [DQS_WIDTH-1:0]             ddr_dqs_out_hi,
   output [DQS_WIDTH-1:0]             ddr_dqs_out_lo,
   output [DQ_WIDTH-1:0]              ddr_dq_out_hi,
   output [DQ_WIDTH-1:0]              ddr_dq_out_lo,
   output [DM_WIDTH-1:0]              ddr_dm_hi,
   output [DM_WIDTH-1:0]              ddr_dm_lo,
   output [ODT_WIDTH-1:0]             ddr_odt

   );


      
//Parameter Define
parameter FREQ = 100;			// default is 100 MHz.  Redefine as needed.
`ifndef SIM
    localparam CNT_INIT = 1.5*FREQ*1000;
`else
    localparam CNT_INIT = 10;
`endif    
  localparam   AIW               = AXI_ID_WIDTH      ;
  localparam   ADW               = AXI_DATA_WIDTH    ;
  localparam   ABN               = AXI_DATA_WIDTH/8   ;
  /////////////////////////////////////////////////////////
  // Wire declarations
  reg  [19:0]                       cnt;    
  wire                              clk;
  wire                              rst;
  wire                              mmcm_locked;
  reg                               aresetn;
  wire                              app_sr_active;
  wire                              app_ref_ack;
  wire                              app_zq_ack;
  wire                              axi_clk;

  wire                              cal_done;

  wire                  io_systemReset;
  wire                  io_memoryClk;
  wire                  io_peripheralReset;
//MIPI RX Camera
wire  [7:0]             w_cam_d0_HS_IN;
wire  [7:0]             w_cam_d1_HS_IN;

wire                    w_cam_ck_HS_ENA_0;
wire                    w_cam_ck_HS_TERM_0;
wire  [1:0]             w_cam_d_HS_ENA_0;
wire                    i_mipi_rx_pclk;
wire  [5:0]             w_mipi_rx_dt;
wire                    w_mipi_rx_vs;
wire                    w_mipi_rx_hs;
wire                    w_mipi_rx_de;
wire  [63:0]            w_mipi_rx_data;

reg   [10:0]            r_rx_x_mipi;
reg   [10:0]            r_rx_y_mipi;
reg                     r_rx_hs;
reg                     r_rx_vs;  

(* async_reg = "true" *)reg   [1:0]    r_mipi_rx_data_LP_P_IN_0_1P;
(* async_reg = "true" *)reg   [1:0]    r_mipi_rx_data_LP_N_IN_0_1P;
(* async_reg = "true" *)reg   [15:0]   r_mipi_rx_data_HS_IN_0_1P;
(* async_reg = "true" *)reg   [1:0]    r_mipi_rx_data_LP_P_IN_0_2P;
(* async_reg = "true" *)reg   [1:0]    r_mipi_rx_data_LP_N_IN_0_2P;
(* async_reg = "true" *)reg   [15:0]   r_mipi_rx_data_HS_IN_0_2P;



wire                    r_rstn_video;

wire                    dp_vs;
wire                    dp_hs;
wire                    dp_data_valid;
wire  [15:0]            dp_r_data;
wire  [15:0]            dp_g_data;
wire  [15:0]            dp_b_data;
wire  [8:0]             dp_frame_cnt;

wire            hdmi_vs ;
wire            hdmi_hs ;
wire            hdmi_de ;
wire    [23:0]  hdmi_data;

////////////////////////////////////////////////////////////////
// DMA controller
wire [63:0]             display_dma_rdata;
wire                    display_dma_rvalid;
wire [7:0]              display_dma_rkeep;
wire                    display_dma_rready;
wire                    debug_display_dma_fifo_overflow;
wire                    debug_display_dma_fifo_underflow;
wire [31:0]             debug_display_dma_fifo_rcount;
wire [31:0]             debug_display_dma_fifo_wcount;
wire                    set_red_green;
wire [31:0] set_offset_display_rgb = 32'h0;


wire                    cam_dma_wready;
wire                    cam_dma_wvalid;
wire                    cam_dma_wlast;
wire [63:0]             cam_dma_wdata;
wire                    debug_cam_dma_fifo_overflow;
wire                    debug_cam_dma_fifo_underflow;
wire [31:0]             debug_cam_dma_fifo_rcount;
wire [31:0]             debug_cam_dma_fifo_wcount;
wire [31:0]             debug_cam_dma_status;

wire                    debug_dma_hw_accel_in_fifo_underflow;
wire                    debug_dma_hw_accel_in_fifo_overflow;
wire                    debug_dma_hw_accel_out_fifo_underflow;
wire                    debug_dma_hw_accel_out_fifo_overflow;
wire  [31:0]            debug_dma_hw_accel_in_fifo_wcount;
wire  [31:0]            debug_dma_hw_accel_out_fifo_rcount;

wire  [3:0]             dma_interrupts;

wire  [15:0]            io_apbSlave_0_PADDR;
wire                    io_apbSlave_0_PSEL;
wire                    io_apbSlave_0_PENABLE;
wire                    io_apbSlave_0_PREADY;
wire                    io_apbSlave_0_PWRITE;
wire  [31:0]            io_apbSlave_0_PWDATA;
wire  [31:0]            io_apbSlave_0_PRDATA;
wire                    io_apbSlave_0_PSLVERROR;

(* keep , syn_keep *) wire [3:0] dma_awregion /* synthesis syn_keep = 1 */;
(* keep , syn_keep *) wire [3:0] dma_arregion /* synthesis syn_keep = 1 */;

wire 			w_pll_lock = pll_locked & user_pll_locked;
//	Synchronize System Resets. 
reg 			rstn_100m = 0; 
wire 			rst_100m = ~rstn_100m; 

always @(posedge core_clk or negedge w_pll_lock) begin if(~w_pll_lock) rstn_100m <= 0; else rstn_100m <= 1; end


////////////////////////////////////////////////////////////////
// MIPI CSI RX Channel - Camera
localparam 	CLOCK_MAIN 	= 100000000; 	//	System clock using 96MHz. 
	  
    ////////////////////////////////////////////////////////////////
    //    I2C Config (SC130GS)
    
    //  i2c timing controller module of 16Bit
    wire            [ 7:0]          sc130_i2c_config_index;
    wire            [23:0]          sc130_i2c_config_data;
    wire            [ 7:0]          sc130_i2c_config_size;
    wire                            sc130_i2c_config_done;
    
    // AEC增益控制信号
    wire                            aec_gain_update_en;
    wire [7:0]                      aec_gain_reg_data;

    assign w_csi_rx_clk = core_clk; 
  // =========================================================================================================================================
// I2C时序控制模块连接（使用改进后的模块）
// =========================================================================================================================================

i2c_timing_ctrl_16bit
#(
    .CLK_FREQ           (CLOCK_MAIN),                              //  96 MHz
    .I2C_FREQ           (10_000    )                               //  10 KHz(<= 400KHz)
) u_i2c_timing_ctrl_16bit (
    //  global clock
    .clk                (core_clk                ),                          //  96MHz
    .rst_n              (rstn_100m               ),                          //  system reset

    //  i2c interface
    .i2c_sclk           (csi_scl_o               ),                          //  i2c clock
    .i2c_sdat_IN        (csi_sda_i               ),
    .i2c_sdat_OUT       (csi_sda_o               ),
    .i2c_sdat_OE        (csi_sda_oe              ),

    //  i2c config data
    .i2c_config_index   (sc130_i2c_config_index        ),                          //  i2c config reg index
    .i2c_config_data    ({8'h6a, sc130_i2c_config_data}),                     //  i2c config data
    .i2c_config_size    (sc130_i2c_config_size         ),                          //  i2c config data counte
    .i2c_config_done    (sc130_i2c_config_done         ),                          //  i2c config timing complete

    .config_clk                        (w_csi_rx_clk                ),
    .config_data                       (24'b0               ),
    .config_data_valid                 (1'b0         ),
    
    // 动态增益控制接口 - 连接改进后的AEC模块
    .gain_update_en                    (aec_gain_update_en)
);

    assign csi_scl_oe = 1; 

// =========================================================================================================================================
// I2C配置模块连接（使用改进后的模块）
// =========================================================================================================================================

//  I2C Configure Data of SC130GS - 使用改进后的配置模块
I2C_AD2020_1280960_FPS60_1Lane_Config u_I2C_AD2020_1280960_FPS60_1Lane_Config 
(
    .I_clk              (w_csi_rx_clk),           // 使用相同的时钟域
    .I_rst_n            (rstn_100m),
    .I_gain_update_en   (aec_gain_update_en),     // 连接AEC增益更新使能
    .I_gain_data        (aec_gain_reg_data),      // 连接AEC增益数据
    .LUT_INDEX          (sc130_i2c_config_index   ),
    .LUT_DATA           (sc130_i2c_config_data    ),
    .LUT_SIZE           (sc130_i2c_config_size    )
);
	


	
	
	assign csi_ctl0_oe = 0; 
	assign csi_ctl1_oe = 0; 
	

	////////////////////////////////////////////////////////////////
	//	MIPI CSI RX
	wire                                    empty_o                    ;
	wire                                    wr_en                      ;
	wire                   [  31:0]         wr_data                    ;
	wire                   [   7:0]         rd_data                    ;
	wire                                    prepare_vsync              ;
	wire                                    prepare_valid              ;
	wire                   [   7:0]         prepare_data               ;
	wire                   [  10:0]         rd_count                   ;
	reg                                     rd_en                      ;
	reg                    [  10:0]         pixel_cnt                  ;
		
	//	The CSI RXC shall not be inverted. Data can be inverted with swapped LP data and flipped HS data. 
	// localparam 	CSI_RXD_INV 	= 4'b1111; 
	// localparam 	CSI_RXD_INV 	= 4'b0000; 
	localparam 	CSI_RXD_INV 	= 4'b0000; 
	// localparam 	CSI_RXD_INV 	= 4'b0001; 
	localparam 	CSI_DATA_WIDTH 	= 8; 			
	localparam 	CSI_STRB_WIDTH 	= CSI_DATA_WIDTH / 8; 

	//	Current implementation supports RAW8 only. 
	wire 			w_csi_rx_clk; 

	wire 			w_csi_rx_vsync0, w_csi_rx_hsync0, w_csi_rx_dvalid; 
	wire 	[63:0] 	w_csi_rx_data; 
	wire 	[47:0] 	w_csi_rx_data_rel_raw; 

	
	wire [7:0] data_typer;
	//	Reset pixel 16 cycles after ~vsync. 
	reg 			r_reset_pixen_n = 0; 
	reg 	[1:0] 	r_csi_rx_vsync0_i = 0; 
	reg 	[3:0] 	rc_csi_rx_vsync0_f = 0; 
	always @(posedge w_csi_rx_clk or negedge rstn_100m) begin
		if(~rstn_100m) begin
			r_reset_pixen_n <= 0; 
			r_csi_rx_vsync0_i <= 0; 
			rc_csi_rx_vsync0_f <= 0; 
		end else begin
			r_csi_rx_vsync0_i <= {r_csi_rx_vsync0_i, w_csi_rx_vsync0}; 
			if(r_csi_rx_vsync0_i == 2'b10) 
				rc_csi_rx_vsync0_f <= 1; 
			else
				rc_csi_rx_vsync0_f <= rc_csi_rx_vsync0_f + (|rc_csi_rx_vsync0_f); 
			r_reset_pixen_n <= (&rc_csi_rx_vsync0_f) ? 0 : 1; 
		end
	end


	
	

    csi_rx mipi_rx_0(
    .reset_n                           (rstn_100m                 ),
    .clk                               (w_csi_rx_clk              ),
    .reset_byte_HS_n                   (rstn_100m                 ),
    .clk_byte_HS                       (csi_rxc_i                 ),
    .reset_pixel_n                     (r_reset_pixen_n           ),//rstn_100m), 
    .clk_pixel                         (w_csi_rx_clk              ),
    // .Rx_LP_CLK_P                       (    csi_rxc_lp_n_i        ),
    // .Rx_LP_CLK_N                       (    csi_rxc_lp_p_i        ),
    .Rx_LP_CLK_P                       (csi_rxc_lp_p_i         ),
    .Rx_LP_CLK_N                       (csi_rxc_lp_n_i         ),

    .Rx_HS_enable_C                    (csi_rxc_hs_en_o           ),
    .LVDS_termen_C                     (csi_rxc_hs_term_en_o      ),
		
		//	Lane inversion affects HS & LP data only. 
    .Rx_LP_D_P                         ({CSI_RXD_INV[3] ? csi_rxd3_lp_n_i : csi_rxd3_lp_p_i, CSI_RXD_INV[2] ? csi_rxd2_lp_n_i : csi_rxd2_lp_p_i, CSI_RXD_INV[1] ? csi_rxd1_lp_n_i : csi_rxd1_lp_p_i, CSI_RXD_INV[0] ? csi_rxd0_lp_n_i : csi_rxd0_lp_p_i}),
    .Rx_LP_D_N                         ({CSI_RXD_INV[3] ? csi_rxd3_lp_p_i : csi_rxd3_lp_n_i, CSI_RXD_INV[2] ? csi_rxd2_lp_p_i : csi_rxd2_lp_n_i, CSI_RXD_INV[1] ? csi_rxd1_lp_p_i : csi_rxd1_lp_n_i, CSI_RXD_INV[0] ? csi_rxd0_lp_p_i : csi_rxd0_lp_n_i}),
    .Rx_HS_D_0                         ((CSI_RXD_INV[0] ? 8'hFF : 8'h00) ^ csi_rxd0_hs_i),
    .Rx_HS_D_1                         ((CSI_RXD_INV[1] ? 8'hFF : 8'h00) ^ csi_rxd1_hs_i),
    .Rx_HS_D_2                         ((CSI_RXD_INV[2] ? 8'hFF : 8'h00) ^ csi_rxd2_hs_i),
    .Rx_HS_D_3                         ((CSI_RXD_INV[3] ? 8'hFF : 8'h00) ^ csi_rxd3_hs_i),
    .Rx_HS_D_4                         (                          ),
    .Rx_HS_D_5                         (                          ),
    .Rx_HS_D_6                         (                          ),
    .Rx_HS_D_7                         (                          ),
		
    .Rx_HS_enable_D                    ({csi_rxd3_hs_en_o, csi_rxd2_hs_en_o, csi_rxd1_hs_en_o, csi_rxd0_hs_en_o}),
    .LVDS_termen_D                     ({csi_rxd3_hs_term_en_o, csi_rxd2_hs_term_en_o, csi_rxd1_hs_term_en_o, csi_rxd0_hs_term_en_o}),
    .fifo_rd_enable                    ({csi_rxd3_fifo_rd_o, csi_rxd2_fifo_rd_o, csi_rxd1_fifo_rd_o, csi_rxd0_fifo_rd_o}),
    .fifo_rd_empty                     ({csi_rxd3_fifo_empty_i, csi_rxd2_fifo_empty_i, csi_rxd1_fifo_empty_i, csi_rxd0_fifo_empty_i}),
    .DLY_enable_D                      (                          ),
    .DLY_inc_D                         (                          ),
    .u_dly_enable_D                    (0                         ),
    .u_dly_inc_D                       (                          ),
		
    .vsync_vc1                         (                          ),
    .vsync_vc15                        (                          ),
    .vsync_vc12                        (                          ),
    .vsync_vc9                         (                          ),
    .vsync_vc7                         (                          ),
    .vsync_vc14                        (                          ),
    .vsync_vc13                        (                          ),
    .vsync_vc11                        (                          ),
    .vsync_vc10                        (                          ),
    .vsync_vc8                         (                          ),
    .vsync_vc6                         (                          ),
    .vsync_vc4                         (                          ),
    .vsync_vc0                         (w_csi_rx_vsync0           ),
    .vsync_vc5                         (                          ),
    .vsync_vc3                         (                          ),
    .vsync_vc2                         (                          ),
	
    .irq                               (                          ),
		
    .pixel_data_valid                  (w_csi_rx_dvalid           ),
    .pixel_data                        (w_csi_rx_data             ),
    .pixel_per_clk                     (                          ),
    .datatype                          (data_typer                ),
    .shortpkt_data_field               (                          ),
    .word_count                        (                          ),
    .vcx                               (                          ),
    .vc                                (                          ),
    .hsync_vc3                         (                          ),
    .hsync_vc2                         (                          ),
    .hsync_vc8                         (                          ),
    .hsync_vc12                        (                          ),
    .hsync_vc7                         (                          ),
    .hsync_vc10                        (                          ),
    .hsync_vc1                         (                          ),
    .hsync_vc0                         (w_csi_rx_hsync0           ),
    .hsync_vc13                        (                          ),
    .hsync_vc4                         (                          ),
    .hsync_vc11                        (                          ),
    .hsync_vc6                         (                          ),
    .hsync_vc9                         (                          ),
    .hsync_vc15                        (                          ),
    .hsync_vc14                        (                          ),
    .hsync_vc5                         (                          )
		
    );
assign wr_data = {w_csi_rx_data[39:32], w_csi_rx_data[29:22],w_csi_rx_data[19:12], w_csi_rx_data[9:2]} ;

	assign csi_rxd0_rst_o = rst_100m; 
	assign csi_rxd1_rst_o = rst_100m; 
	assign csi_rxd2_rst_o = rst_100m; 
	assign csi_rxd3_rst_o = rst_100m; 
	
	
	//	Output LED
	reg 	[5:0]		r_csi_fv_o = 0; 
	reg 	[1:0] 	r_csi_rx_vsync0_in = 0; 
	always @(posedge w_csi_rx_clk) begin
		r_csi_rx_vsync0_in <= {r_csi_rx_vsync0_in, w_csi_rx_vsync0}; 
		r_csi_fv_o <= r_csi_fv_o + ((r_csi_rx_vsync0_in == 2'b01) ? 1 : 0); 
	end
	//assign led_o[4] = r_csi_fv_o[5]; 



wire [10:0] cnt_pixel;
wire [10:0] cnt_row;

Row_Line_Counter  u_Row_Line_Counter (
    .Data_clk                          (w_csi_rx_clk               ),
    .Data_rst_n                        (rstn_100m             ),
    .Data_vsync                        (w_csi_rx_vsync0         ),
    .Data_hsync                        (w_csi_rx_hsync0         ),//用于统计行
    .Data_valid                        (w_csi_rx_dvalid         ),//用于统计每一行的像素

    .cnt_pixel                         (cnt_pixel   [10:0]),
    .cnt_row                           (cnt_row     [10:0]) 
);
// =========================================================================================================================================
// data 32 to 8
// ========================================================================================================================================= 

//c1
// assign wr_data = {w_csi_rx_data[9:2], w_csi_rx_data[19:12], w_csi_rx_data[29:22], w_csi_rx_data[39:32]} ;
assign wr_en = w_csi_rx_hsync0 && w_csi_rx_dvalid;

always@(posedge w_csi_rx_clk or negedge rstn_100m)
begin
	if(!rstn_100m)
		begin
			rd_en   <=  'd0 ;
		end
	else if(pixel_cnt == 1279)
		begin
			rd_en   <=  'd0 ;
		end
	else if(rd_count >=1280)
		begin
			rd_en   <=  1;
		end
	else
		begin
			rd_en   <=  rd_en ;
		end
end
always@(posedge w_csi_rx_clk or negedge rstn_100m)
begin
	if(!rstn_100m)
		begin
			pixel_cnt   <=  'd0 ;
		end
	else if(pixel_cnt == 1279)
		begin
			pixel_cnt   <=  'd0 ;
		end
	else if(rd_en)
		begin
			pixel_cnt   <=  pixel_cnt + 1 ;
		end
	else
		begin
			pixel_cnt   <=  'd0 ;
		end
end
//c2
afifo_w32r8_reshape u_afifo_w32r8_reshape
(
	.full_o                            (                          ),
    .rst_busy                          (                          ),
	.empty_o                           (empty_o                   ),
    .a_rst_i                           (~rstn_100m              ),
   
    .wr_clk_i                          (w_csi_rx_clk                ),
    .wdata                             (wr_data                   ),
    .wr_en_i                           (wr_en                     ),
    .wr_datacount_o                    (                          ),
    
    .rd_clk_i                          (w_csi_rx_clk                ),
    .rd_en_i                           (rd_en                     ),
    .rdata                             (rd_data                   ),
    .rd_datacount_o                    (rd_count                  ) 
);
//c3
wire                                    delay_vsync                ;
delay_reg #(.delay_level(1280),.reg_width(1)) DR0(
    .clk                               (w_csi_rx_clk                ),
    .rst                               (~rstn_100m              ),
    .din                               (w_csi_rx_vsync0      ),

    .dout                              (delay_vsync               ) 
);
assign prepare_vsync = delay_vsync;
assign prepare_valid = rd_en;
assign prepare_data = rd_data;
// =========================================================================================================================================
// XYCrop
// ========================================================================================================================================= 
	wire			XYCrop_frame_vsync; 
	wire			XYCrop_frame_href;
	wire			XYCrop_frame_de;
	wire	[7:0]	XYCrop_frame_Gray;

    Sensor_Image_XYCrop
    #(
    .IMAGE_HSIZE_SOURCE                (1280 / CSI_STRB_WIDTH     ),
    .IMAGE_VSIZE_SOURCE                (960                       ),
    .IMAGE_HSIZE_TARGET                (1280 / CSI_STRB_WIDTH     ),
    .IMAGE_YSIZE_TARGET                (720                       ),
    .PIXEL_DATA_WIDTH                  (8                        ) //	32		 )
    )
    u_Sensor_Image_XYCrop
    (
		//	globel clock
    .clk                               (w_csi_rx_clk              ),//	image pixel clock
    .rst_n                             (rstn_100m                  ),//	system reset
		
		//CMOS Sensor interface
    .image_in_vsync                    (prepare_vsync           ),//H : Data Valid; L : Frame Sync(Set it by register)
    .image_in_href                     (prepare_valid       ),//H : Data vaild, L : Line Sync
    .image_in_de                       (prepare_valid            ),//H : Data Enable, L : Line Sync
    .image_in_data                     (prepare_data),//8 bits cmos data input
    // .image_in_vsync                    (post_frame_vsync           ),//H : Data Valid; L : Frame Sync(Set it by register)
    // .image_in_href                     (post_frame_href &&    post_frame_hsync        ),//H : Data vaild, L : Line Sync
    // .image_in_de                       (post_frame_href &&    post_frame_hsync             ),//H : Data Enable, L : Line Sync
    // .image_in_data                     (final_data),//8 bits cmos data input
		
    .image_out_vsync                   (XYCrop_frame_vsync        ),//H : Data Valid; L : Frame Sync(Set it by register)
    .image_out_href                    (XYCrop_frame_href         ),//H : Data vaild, L : Line Sync
    .image_out_de                      (XYCrop_frame_de           ),//H : Data Enable, L : Line Sync
    .image_out_data                    (XYCrop_frame_Gray         ) //8 bits cmos data input	
    );

	reg			r_XYCrop_frame_vsync = 0; 
	reg			r_XYCrop_frame_href = 0;
	reg			r_XYCrop_frame_de = 0;
	reg	[63:0]	r_XYCrop_frame_Gray = 0;
	
	always @(posedge w_csi_rx_clk) begin
		r_XYCrop_frame_vsync <= XYCrop_frame_vsync; 
		r_XYCrop_frame_href <= XYCrop_frame_href;
		r_XYCrop_frame_de <= XYCrop_frame_de;
		r_XYCrop_frame_Gray <= XYCrop_frame_Gray;
	end
	
	//	Data Write Assignment
	wire			cmos_frame_vsync = r_XYCrop_frame_vsync;                     //  cmos frame data vsync valid signal
	wire			cmos_frame_href = r_XYCrop_frame_href && r_XYCrop_frame_de;	 //  cmos frame data href vaild  signal
	wire	[7:0]	cmos_frame_Gray = r_XYCrop_frame_Gray; 

	//c1 crop data
wire                                    crop_vsync                 ;
wire                                    crop_valid                 ;
wire                   [   7:0]         crop_data                  ;
assign crop_vsync = r_XYCrop_frame_vsync;
assign crop_valid = cmos_frame_href ;
assign crop_data = cmos_frame_Gray;

// =========================================================================================================================================
// P1_Bayer2rgb
// ========================================================================================================================================= 
wire 			w_rgb_vsync, w_rgb_hsync, w_rgb_href; 
wire 	[7:0] 	w_rgb_r, w_rgb_g, w_rgb_b; 
wire [11:0] cnt_bayer_pixel;
wire [11:0] cnt_bayer_row  ;
VIP_RAW8_RGB888 #(.IMG_HDISP(1280), .IMG_VDISP(720)) ori_bayer2rgb (
    .clk                               (w_csi_rx_clk                ),//cmos video pixel clock
    .rst_n                             (rstn_100m               ),//global reset
	
    .mirror                            (2'b11                     ),

		//CMOS YCbCr444 data output
    .per_frame_vsync                   (crop_vsync                ),//Prepared Image data vsync valid signal. Reset on falling edge. 
    .per_frame_hsync                   (crop_valid                ),//Prepared Image data href vaild  signal
    .per_frame_href                    (crop_valid                ),//Prepared Image data href vaild  signal
    .per_img_RAW                       (crop_data                ),//Prepared Image data 8 Bit RAW Data

    .post_frame_vsync                  (w_rgb_vsync               ),//Processed Image data vsync valid signal
    .post_frame_hsync                  (w_rgb_hsync               ),//Processed Image data href vaild  signal
    .post_frame_href                   (w_rgb_href                ),//Processed Image data href vaild  signal
    .post_img_red                      (w_rgb_r                   ),//Prepared Image green data to be processed 
    .post_img_green                    (w_rgb_g                   ),//Prepared Image green data to be processed
    .post_img_blue                     (w_rgb_b                   ) //Prepared Image blue data to be processed
);
// =========================================================================================================================================
//P2_MWB
// ========================================================================================================================================= 
//c1
wire                                    rgb_vsync                  ;
wire                                    rgb_valid                  ;
wire                   [  23:0]         rgb_data                   ;
wire                   [   7:0]         w_mwb_rgb_r                ;
wire                   [   7:0]         w_mwb_rgb_g                ;
wire                   [   7:0]         w_mwb_rgb_b                ;
wire     [17:0]     w_rgb_r_mult = w_rgb_r * 419; 
wire     [17:0]     w_rgb_b_mult = w_rgb_b * 360; 
assign w_mwb_rgb_r = w_rgb_r_mult[17:16] ? 8'hFF : w_rgb_r_mult[15: 8]; 
assign w_mwb_rgb_g = w_rgb_g; 
assign w_mwb_rgb_b = w_rgb_b_mult[17:16] ? 8'hFF : w_rgb_b_mult[15: 8]; 

// =========================================================================================================================================
// RGB2YUV
// ========================================================================================================================================= 
wire                   [   7:0]         rgb2yuv_y                ;
wire                   [   7:0]         rgb2yuv_u                ;
wire                   [   7:0]         rgb2yuv_v                ;
wire                                    rgb2yuv_vsync                  ;
wire                                    rgb2yuv_valid                  ;
VIP_RGB888_YCbCr444 rgb2yuv(
	.clk(w_csi_rx_clk),
	.rst_n(rstn_100m),

	.per_img_vsync(w_rgb_vsync),
	.per_img_href(w_rgb_href),
	.per_img_red(w_mwb_rgb_r),
	.per_img_green(w_mwb_rgb_g),
	.per_img_blue(w_mwb_rgb_b),

	.post_img_vsync(rgb2yuv_vsync),
	.post_img_href(rgb2yuv_valid),
	.post_img_Y(rgb2yuv_y),
	.post_img_Cb(rgb2yuv_u),
	.post_img_Cr(rgb2yuv_v)

);

// =========================================================================================================================================
// AEC - 自动曝光控制（增益）
// ========================================================================================================================================= 
wire        aec_vsync, aec_href;
wire [7:0]  aec_y_out;

AEC_Serial u_aec (
    .I_clk              (w_csi_rx_clk),
    .I_rst_n            (rstn_100m),
    .I_vsync            (rgb2yuv_vsync),
    .I_href             (rgb2yuv_valid),
    .I_y_data           (rgb2yuv_y),
    .O_vsync            (aec_vsync),
    .O_href             (aec_href),
    .O_y_data           (aec_y_out),
    .O_gain_update_en   (aec_gain_update_en),
    .O_gain_reg_data    (aec_gain_reg_data),
	.I_switch(~system_gpio_0_io_write[1]),
	.I_increase(~system_gpio_0_io_write[2]),
	.I_decrease(~system_gpio_0_io_write[3])
);

// =========================================================================================================================================
// gamma
// ========================================================================================================================================= 
wire                   [   7:0]         gamma_y                ;
Curve_Gamma_2P2 cruve_gamma(
	.Pre_Data(aec_y_out),
	.Post_Data(gamma_y)
);
//assign gamma_y = rgb2yuv_y;
// =========================================================================================================================================
// YUV2RGB
// ========================================================================================================================================= 
wire                   [   7:0]         yuv2rgb_r                ;
wire                   [   7:0]         yuv2rgb_g                ;
wire                   [   7:0]         yuv2rgb_b                ;
wire                                    yuv2rgb_vsync                  ;
wire                                    yuv2rgb_valid                  ;
wire [15:0] y_gained_temp;
wire [7:0]  y_gained;
assign y_gained_temp = gamma_y * 8'd179;
assign y_gained = y_gained_temp[15:8];  // 右移8位，恢复到 0-255 范围
VIP_YCbCr444_RGB888 yuv2rgb(
	.clk(w_csi_rx_clk),
	.rst_n(rstn_100m),

	.per_img_vsync(aec_vsync),
	.per_img_href(aec_href),
	.per_img_Y(y_gained),
	.per_img_Cb(rgb2yuv_u),
	.per_img_Cr(rgb2yuv_v),

	.post_img_vsync(yuv2rgb_vsync),
	.post_img_href(yuv2rgb_valid),
	.post_img_red(yuv2rgb_r),
	.post_img_green(yuv2rgb_g),
	.post_img_blue(yuv2rgb_b)

);


assign rgb_vsync = yuv2rgb_vsync;
assign rgb_valid = yuv2rgb_valid;
assign rgb_data = {yuv2rgb_r,yuv2rgb_g,yuv2rgb_b};





//Custom instruction
wire                    cpu_customInstruction_cmd_valid;
wire                    cpu_customInstruction_cmd_ready;
wire  [9:0]             cpu_customInstruction_function_id;
wire  [31:0]            cpu_customInstruction_inputs_0;
wire  [31:0]            cpu_customInstruction_inputs_1;
wire                    cpu_customInstruction_rsp_valid;
wire                    cpu_customInstruction_rsp_ready;
wire  [31:0]            cpu_customInstruction_outputs_0;
wire                    cpu_customInstruction_cmd_int;
wire                    userInterruptA;

localparam AXI_TINYML_DATA_WIDTH = 128;

wire [7:0]              axi_inter_s0_awid;
wire [31:0]             axi_inter_s0_awaddr;
wire [7:0]              axi_inter_s0_awlen;
wire [2:0]              axi_inter_s0_awsize;
wire [1:0]              axi_inter_s0_awburst;
wire                    axi_inter_s0_awlock;
wire [3:0]              axi_inter_s0_awcache;
wire [2:0]              axi_inter_s0_awprot;
wire [3:0]              axi_inter_s0_awqos;
wire                    axi_inter_s0_awvalid;
wire                    axi_inter_s0_awready;
wire [127:0]            axi_inter_s0_wdata;
wire [15:0]             axi_inter_s0_wstrb;
wire                    axi_inter_s0_wlast;
wire                    axi_inter_s0_wvalid;
wire                    axi_inter_s0_wready;
wire [7:0]              axi_inter_s0_bid;
wire [1:0]              axi_inter_s0_bresp;
wire                    axi_inter_s0_bvalid;
wire                    axi_inter_s0_bready;
wire [7:0]              axi_inter_s0_arid;
wire [31:0]             axi_inter_s0_araddr;
wire [7:0]              axi_inter_s0_arlen;
wire [2:0]              axi_inter_s0_arsize;
wire [1:0]              axi_inter_s0_arburst;
wire                    axi_inter_s0_arlock;
wire [3:0]              axi_inter_s0_arcache;
wire [2:0]              axi_inter_s0_arprot;
wire [3:0]              axi_inter_s0_arqos;
wire                    axi_inter_s0_arvalid;
wire                    axi_inter_s0_arready;
wire [7:0]              axi_inter_s0_rid;
wire [127:0]            axi_inter_s0_rdata;
wire [1:0]              axi_inter_s0_rresp;
wire                    axi_inter_s0_rlast;
wire                    axi_inter_s0_rvalid;
wire                    axi_inter_s0_rready;

wire [7:0]              axi_inter_s1_awid;
wire [31:0]             axi_inter_s1_awaddr;
wire [7:0]              axi_inter_s1_awlen;
wire [2:0]              axi_inter_s1_awsize;
wire [1:0]              axi_inter_s1_awburst;
wire                    axi_inter_s1_awlock;
wire [3:0]              axi_inter_s1_awcache;
wire [2:0]              axi_inter_s1_awprot;
wire [3:0]              axi_inter_s1_awqos;
wire                    axi_inter_s1_awvalid;
wire                    axi_inter_s1_awready;
wire [127:0]            axi_inter_s1_wdata;
wire [15:0]             axi_inter_s1_wstrb;
wire                    axi_inter_s1_wlast;
wire                    axi_inter_s1_wvalid;
wire                    axi_inter_s1_wready;
wire [7:0]              axi_inter_s1_bid;
wire [1:0]              axi_inter_s1_bresp;
wire                    axi_inter_s1_bvalid;
wire                    axi_inter_s1_bready;
wire [7:0]              axi_inter_s1_arid;
wire [31:0]             axi_inter_s1_araddr;
wire [7:0]              axi_inter_s1_arlen;
wire [2:0]              axi_inter_s1_arsize;
wire [1:0]              axi_inter_s1_arburst;
wire                    axi_inter_s1_arlock;
wire [3:0]              axi_inter_s1_arcache;
wire [2:0]              axi_inter_s1_arprot;
wire [3:0]              axi_inter_s1_arqos;
wire                    axi_inter_s1_arvalid;
wire                    axi_inter_s1_arready;
wire [7:0]              axi_inter_s1_rid;
wire [127:0]            axi_inter_s1_rdata;
wire [1:0]              axi_inter_s1_rresp;
wire                    axi_inter_s1_rlast;
wire                    axi_inter_s1_rvalid;
wire                    axi_inter_s1_rready;

wire [7:0]              axi_inter_s2_awid;
wire [31:0]             axi_inter_s2_awaddr;
wire [7:0]              axi_inter_s2_awlen;
wire [2:0]              axi_inter_s2_awsize;
wire [1:0]              axi_inter_s2_awburst;
wire                    axi_inter_s2_awlock;
wire [3:0]              axi_inter_s2_awcache;
wire [2:0]              axi_inter_s2_awprot;
wire [3:0]              axi_inter_s2_awqos;
wire                    axi_inter_s2_awvalid;
wire                    axi_inter_s2_awready;
wire [AXI_TINYML_DATA_WIDTH-1:0]            axi_inter_s2_wdata;
wire [AXI_TINYML_DATA_WIDTH/8-1:0]             axi_inter_s2_wstrb;
wire                    axi_inter_s2_wlast;
wire                    axi_inter_s2_wvalid;
wire                    axi_inter_s2_wready;
wire [7:0]              axi_inter_s2_bid;
wire [1:0]              axi_inter_s2_bresp;
wire                    axi_inter_s2_bvalid;
wire                    axi_inter_s2_bready;
wire [7:0]              axi_inter_s2_arid;
wire [31:0]             axi_inter_s2_araddr;
wire [7:0]              axi_inter_s2_arlen;
wire [2:0]              axi_inter_s2_arsize;
wire [1:0]              axi_inter_s2_arburst;
wire                    axi_inter_s2_arlock;
wire [3:0]              axi_inter_s2_arcache;
wire [2:0]              axi_inter_s2_arprot;
wire [3:0]              axi_inter_s2_arqos;
wire                    axi_inter_s2_arvalid;
wire                    axi_inter_s2_arready;
wire [7:0]              axi_inter_s2_rid;
wire [AXI_TINYML_DATA_WIDTH-1:0]            axi_inter_s2_rdata;
wire [1:0]              axi_inter_s2_rresp;
wire                    axi_inter_s2_rlast;
wire                    axi_inter_s2_rvalid;
wire                    axi_inter_s2_rready;

wire [7:0]              axi_inter_m_awid;
wire [31:0]             axi_inter_m_awaddr;
wire [7:0]              axi_inter_m_awlen;
wire [2:0]              axi_inter_m_awsize;
wire [1:0]              axi_inter_m_awburst;
wire                    axi_inter_m_awlock;
wire [3:0]              axi_inter_m_awcache;
wire [2:0]              axi_inter_m_awprot;
wire [3:0]              axi_inter_m_awqos;
wire [3:0]              axi_inter_m_awregion;
wire                    axi_inter_m_awvalid;
wire                    axi_inter_m_awready;
wire [127:0]            axi_inter_m_wdata;
wire [15:0]             axi_inter_m_wstrb;
wire                    axi_inter_m_wlast;
wire                    axi_inter_m_wvalid;
wire                    axi_inter_m_wready;
wire [7:0]              axi_inter_m_bid;
wire [1:0]              axi_inter_m_bresp;
wire                    axi_inter_m_bvalid;
wire                    axi_inter_m_bready;
wire [7:0]              axi_inter_m_arid;
wire [31:0]             axi_inter_m_araddr;
wire [7:0]              axi_inter_m_arlen;
wire [2:0]              axi_inter_m_arsize;
wire [1:0]              axi_inter_m_arburst;
wire                    axi_inter_m_arlock;
wire [3:0]              axi_inter_m_arcache;
wire [2:0]              axi_inter_m_arprot;
wire [3:0]              axi_inter_m_arqos;
wire [3:0]              axi_inter_m_arregion;
wire                    axi_inter_m_arvalid;
wire                    axi_inter_m_arready;
wire [7:0]              axi_inter_m_rid;
wire [127:0]            axi_inter_m_rdata;
wire [1:0]              axi_inter_m_rresp;
wire                    axi_inter_m_rlast;
wire                    axi_inter_m_rvalid;
wire                    axi_inter_m_rready;

  wire                              ddr_reset; 
  wire                              sys_rst;
  wire  [2:0]                       phy_wr_pll_shift;
  wire                              idelay_ld       ;
  wire                              mpr_rdlvl_dly   ;
  wire  [7:0]                       wrlvl_dq_check  ;
  wire  [7:0]                       rd_level_dqs_check;  
  wire  [2:0]                       rdlvl_shift;  
  wire  [2:0]                       wrlvl_shift;  
  wire  [15:0]                      debug_fifo;  
  wire  [15:0]                      overflow_fifo;  
  wire  [6:0]                       init_cur_state;  
  wire  [35:0]                      ddr_debug_port;  
  wire                              app_rdy;  
  wire                              user_clk;  
  wire                              ddr_rstn;  

wire [7:0] system_gpio_0_io_write;


//assign led_o[0] = system_gpio_0_io_write[0];
//assign led_o[1] = system_gpio_0_io_write[1];
//assign led_o[2] = system_gpio_0_io_write[2];
//assign led_o[3] = system_gpio_0_io_write[3];

// Start of User Design top instance
//***************************************************************************
// The User design is instantiated below. The memory interface ports are
// connected to the top-level and the application interface ports are
// connected to the traffic generator module. This provides a reference
// for connecting the memory controller to system.
//***************************************************************************
always @(posedge user_clk or negedge sys_rst) begin
	if (!sys_rst)
		cnt <= 0;
    else if (cnt != CNT_INIT) 
        cnt <= cnt + 20'd1;
	else 
        cnt <= cnt;
end
assign ddr_rstn = (cnt == CNT_INIT);


generate
if (ASYN_AXI_CLK) begin
assign user_clk = axi_clk;

end else begin
assign user_clk = core_clk;
end
endgenerate
//***************************************************************************
// The traffic generation module instantiated below drives traffic (patterns)
// on the application interface of the memory controller
//***************************************************************************
//***************************************************************************

assign sys_rst       = pll_locked & user_pll_locked;
//***************************************************************************
ddr3_top                 u_ddr3_top
      (
      
    .axi_clk                (user_clk            ),
    .core_clk               (core_clk            ),
    .sdram_clk              (sdram_clk           ),  
    .rx_cal_clk             (rx_cal_clk          ),
    .tx_cal_clk             (tx_cal_clk          ),
    .tx_cal_clk_90edge      (tx_cal_clk_90edge   ),
    .rstn                   (ddr_rstn            ),      
    .pll_shift              (pll_shift           ),
    .pll_shift_sel          (pll_shift_sel       ),
    .pll_shift_ena          (pll_shift_ena       ), 
///////////////DDR BUS
    .ddr_ck_hi              (ddr_ck_hi           ),
    .ddr_ck_lo              (ddr_ck_lo           ),
    .ddr_cke                (ddr_cke             ),    
    .ddr_reset_n            (ddr_reset_n         ),
    .ddr_cs_n               (ddr_cs_n            ),
    .ddr_ras_n              (ddr_ras_n           ),
    .ddr_cas_n              (ddr_cas_n           ),
    .ddr_we_n               (ddr_we_n            ),     
    .ddr_addr               (ddr_addr            ),
    .ddr_ba                 (ddr_ba              ),

    .ddr_dqs_oe             (ddr_dqs_oe          ),
    .ddr_dqs_oe_n           (ddr_dqs_oe_n        ),
    .ddr_dq_oe              (ddr_dq_oe           ),
    .ddr_dqs_in_hi          (ddr_dqs_in_hi       ),
    .ddr_dqs_in_lo          (ddr_dqs_in_lo       ),
    .ddr_dq_in_hi           (ddr_dq_in_hi        ),
    .ddr_dq_in_lo           (ddr_dq_in_lo        ),

    .ddr_dqs_out_hi         (ddr_dqs_out_hi      ),
    .ddr_dqs_out_lo         (ddr_dqs_out_lo      ),
    .ddr_dq_out_hi          (ddr_dq_out_hi       ),
    .ddr_dq_out_lo          (ddr_dq_out_lo       ),
    
    .ddr_dm_hi              (ddr_dm_hi           ),
    .ddr_dm_lo              (ddr_dm_lo           ),
    .ddr_odt                (ddr_odt             ),

// Application interface ports
       .app_sr_req                     (1'b0),
       .app_ref_req                    (1'b0),
       .app_zq_req                     (1'b0),
       .app_sr_active                  (app_sr_active),
       .app_ref_ack                    (app_ref_ack),
       .app_zq_ack                     (app_zq_ack),

// Slave Interface Write Address Ports
       .s_axi_awid                     (axi_inter_m_awid        ),
       .s_axi_awaddr                   (axi_inter_m_awaddr      ),
       .s_axi_awlen                    (axi_inter_m_awlen       ),
       .s_axi_awsize                   (axi_inter_m_awsize      ),
       .s_axi_awburst                  (axi_inter_m_awburst     ),
       .s_axi_awlock                   (axi_inter_m_awlock      ),
       .s_axi_awcache                  (axi_inter_m_awcache     ),
       .s_axi_awprot                   (axi_inter_m_awprot      ),
       .s_axi_awqos                    (axi_inter_m_awqos       ),
       .s_axi_awvalid                  (axi_inter_m_awvalid     ),
       .s_axi_awready                  (axi_inter_m_awready     ),
// Slave Interface Write Data Ports
       .s_axi_wdata                    (axi_inter_m_wdata       ),
       .s_axi_wstrb                    (axi_inter_m_wstrb       ),
       .s_axi_wlast                    (axi_inter_m_wlast       ),
       .s_axi_wvalid                   (axi_inter_m_wvalid      ),
       .s_axi_wready                   (axi_inter_m_wready      ),
// Slave Interface Write Response Ports
       .s_axi_bid                      (axi_inter_m_bid         ),
       .s_axi_bresp                    (axi_inter_m_bresp       ),
       .s_axi_bvalid                   (axi_inter_m_bvalid      ),
       .s_axi_bready                   (axi_inter_m_bready      ),
// Slave Interface Read Address Ports
       .s_axi_arid                     (axi_inter_m_arid        ),
       .s_axi_araddr                   (axi_inter_m_araddr      ),
       .s_axi_arlen                    (axi_inter_m_arlen       ),
       .s_axi_arsize                   (axi_inter_m_arsize      ),
       .s_axi_arburst                  (axi_inter_m_arburst     ),
       .s_axi_arlock                   (axi_inter_m_arlock      ),
       .s_axi_arcache                  (axi_inter_m_arcache     ),
       .s_axi_arprot                   (axi_inter_m_arprot      ),
       .s_axi_arqos                    (axi_inter_m_arqos              ),
       .s_axi_arvalid                  (axi_inter_m_arvalid     ),
       .s_axi_arready                  (axi_inter_m_arready     ),
// Slave Interface Read Data Ports
       .s_axi_rid                      (axi_inter_m_rid         ),
       .s_axi_rdata                    (axi_inter_m_rdata       ),
       .s_axi_rresp                    (axi_inter_m_rresp       ),
       .s_axi_rlast                    (axi_inter_m_rlast       ),
       .s_axi_rvalid                   (axi_inter_m_rvalid      ),
       .s_axi_rready                   (axi_inter_m_rready      ),
//DEBUG       
       .wrlvl_dq_check                 (wrlvl_dq_check    ) ,
       .rd_level_dqs_check             (rd_level_dqs_check) ,
       .rdlvl_shift                    (rdlvl_shift) ,
       .wrlvl_shift                    (wrlvl_shift) ,
       .init_cur_state                 (init_cur_state    ) ,
       .idelay_ld                      (idelay_ld         ) ,
       .mpr_rdlvl_dly                  (mpr_rdlvl_dly     ) ,
       .ddr_debug_port                 (ddr_debug_port    ) ,
       .cal_done                       (cal_done          ) 
       );
// End of User Design top instance

//***************************************************************************

//***************************************************************************

assign led_o[3] = sc130_i2c_config_done;  // I2C config done indicator

// DDR debug LEDs
// led_o[4] = DDR3 calibration done (ON = DDR ready)
assign led_o[4] = cal_done;

// led_o[5] = DDR AXI activity (stretched pulse on any read/write transaction)
reg [23:0] ddr_act_cnt;
wire ddr_act_trig;
assign ddr_act_trig = (axi_inter_m_awvalid && axi_inter_m_awready)
                   || (axi_inter_m_wvalid  && axi_inter_m_wready  && axi_inter_m_wlast)
                   || (axi_inter_m_arvalid && axi_inter_m_arready)
                   || (axi_inter_m_rvalid  && axi_inter_m_rready  && axi_inter_m_rlast);

always @(posedge user_clk or negedge sys_rst) begin
    if (!sys_rst)
        ddr_act_cnt <= 24'd0;
    else if (ddr_act_trig)
        ddr_act_cnt <= 24'hFFFFFF;
    else if (|ddr_act_cnt)
        ddr_act_cnt <= ddr_act_cnt - 1'b1;
end
assign led_o[5] = |ddr_act_cnt;



touch_soc u_touch_soc
(
    .io_systemClk ( i_peripheralClk ),
    .io_asyncReset ( !cal_done ),

    .system_gpio_0_io_writeEnable (  ),
    .system_gpio_0_io_write ( system_gpio_0_io_write ),
    .system_gpio_0_io_read ( ),

    .system_gpio_1_io_write ( system_gpio_1_io_write ),
    .system_gpio_1_io_read ( system_gpio_1_io_read ),
    .system_gpio_1_io_writeEnable ( system_gpio_1_io_writeEnable )
    
);

assign io_memoryClk = user_clk;
assign userInterruptA = cpu_customInstruction_cmd_int;
assign userInterruptB = |dma_interrupts;

sapphire_soc u_sapphire_soc(
    .io_asyncReset                      (!cal_done                        ),
    .io_systemClk                       (i_sysclk                           ),

    //uart
	 .system_uart_0_io_txd               ( uart_tx_o ),
    .system_uart_0_io_rxd               ( uart_rx_i ),

    .io_memoryClk                       (io_memoryClk                       ),
    .io_systemReset                     (io_systemReset                     ),
    .io_memoryReset                     (                                   ),
    .io_peripheralClk                   (i_peripheralClk                    ),
    .io_peripheralReset                 (io_peripheralReset                  ),   


    //SPI 0
    .system_spi_0_io_sclk_write         (system_spi_0_io_sclk_write         ),
    .system_spi_0_io_data_0_writeEnable (system_spi_0_io_data_0_writeEnable ),
    .system_spi_0_io_data_0_read        (system_spi_0_io_data_0_read        ),
    .system_spi_0_io_data_0_write       (system_spi_0_io_data_0_write       ),
    .system_spi_0_io_data_1_writeEnable (system_spi_0_io_data_1_writeEnable ),
    .system_spi_0_io_data_1_read        (system_spi_0_io_data_1_read        ),
    .system_spi_0_io_data_1_write       (system_spi_0_io_data_1_write       ),
    .system_spi_0_io_data_2_writeEnable (                                   ),
    .system_spi_0_io_data_2_read        (                                   ),
    .system_spi_0_io_data_2_write       (                                   ),
    .system_spi_0_io_data_3_writeEnable (                                   ),
    .system_spi_0_io_data_3_read        (                                   ),
    .system_spi_0_io_data_3_write       (                                   ),
    .system_spi_0_io_ss                 (system_spi_0_io_ss                 ),

    //External Memory AXI4 Interface
    .io_ddrA_aw_payload_prot            (                                  ),
    .io_ddrA_aw_payload_qos             (                                  ),
    .io_ddrA_aw_payload_cache           (                                  ),
    .io_ddrA_aw_payload_lock            (axi_inter_s0_awlock                     ),
    .io_ddrA_aw_payload_burst           (axi_inter_s0_awburst                    ),
    .io_ddrA_aw_payload_size            (axi_inter_s0_awsize                     ),
    .io_ddrA_aw_payload_len             (axi_inter_s0_awlen                      ),
    .io_ddrA_aw_payload_region          (                                  ),
    .io_ddrA_aw_payload_id              (axi_inter_s0_awid                       ),
    .io_ddrA_aw_payload_addr            (axi_inter_s0_awaddr                     ),
    .io_ddrA_aw_ready                   (axi_inter_s0_awready                    ),
    .io_ddrA_aw_valid                   (axi_inter_s0_awvalid                    ),

    .io_ddrA_w_payload_last             (axi_inter_s0_wlast                      ),
    .io_ddrA_w_ready                    (axi_inter_s0_wready                     ),
    .io_ddrA_w_valid                    (axi_inter_s0_wvalid                     ),    
    .io_ddrA_w_payload_strb             (axi_inter_s0_wstrb                      ),
    .io_ddrA_w_payload_data             (axi_inter_s0_wdata                      ),

    .io_ddrA_b_payload_resp             (                                  ),
    .io_ddrA_b_payload_id               (axi_inter_s0_bid                        ),
    .io_ddrA_b_ready                    (axi_inter_s0_bready                     ),
    .io_ddrA_b_valid                    (axi_inter_s0_bvalid                     ),

    .io_ddrA_ar_payload_prot            (                                  ),
    .io_ddrA_ar_payload_qos             (                                  ),
    .io_ddrA_ar_payload_cache           (                                  ),
    .io_ddrA_ar_payload_region          (                                  ),
    .io_ddrA_ar_payload_lock            (axi_inter_s0_arlock                     ),
    .io_ddrA_ar_payload_burst           (axi_inter_s0_arburst                    ),
    .io_ddrA_ar_payload_size            (axi_inter_s0_arsize                     ),
    .io_ddrA_ar_payload_len             (axi_inter_s0_arlen                      ),
    .io_ddrA_ar_payload_id              (axi_inter_s0_arid                       ),
    .io_ddrA_ar_payload_addr            (axi_inter_s0_araddr                     ),
    .io_ddrA_ar_ready                   (axi_inter_s0_arready                    ),
    .io_ddrA_ar_valid                   (axi_inter_s0_arvalid                    ),

    .io_ddrA_r_payload_last             (axi_inter_s0_rlast                      ),
    .io_ddrA_r_payload_resp             (axi_inter_s0_rresp                      ),
    .io_ddrA_r_payload_id               (axi_inter_s0_rid                        ),
    .io_ddrA_r_payload_data             (axi_inter_s0_rdata                      ),
    .io_ddrA_r_ready                    (axi_inter_s0_rready                     ),
    .io_ddrA_r_valid                    (axi_inter_s0_rvalid                     ),
    
    //custom instruction
    .cpu0_customInstruction_cmd_valid   (cpu_customInstruction_cmd_valid),
    .cpu0_customInstruction_cmd_ready   (cpu_customInstruction_cmd_ready),
    .cpu0_customInstruction_function_id (cpu_customInstruction_function_id),
    .cpu0_customInstruction_inputs_0    (cpu_customInstruction_inputs_0),
    .cpu0_customInstruction_inputs_1    (cpu_customInstruction_inputs_1),
    .cpu0_customInstruction_rsp_valid   (cpu_customInstruction_rsp_valid),
    .cpu0_customInstruction_rsp_ready   (cpu_customInstruction_rsp_ready),
    .cpu0_customInstruction_outputs_0   (cpu_customInstruction_outputs_0),
     
    
    .userInterruptA                     (userInterruptA),
    .userInterruptB                     (userInterruptB),

    //Hard Jtag Tap
    .jtagCtrl_tck                       (jtag_inst1_TCK                     ),
    .jtagCtrl_tdi                       (jtag_inst1_TDI                     ),
    .jtagCtrl_tdo                       (jtag_inst1_TDO                     ),
    .jtagCtrl_enable                    (jtag_inst1_SEL                     ),
    .jtagCtrl_capture                   (jtag_inst1_CAPTURE                 ),
    .jtagCtrl_shift                     (jtag_inst1_SHIFT                   ),
    .jtagCtrl_update                    (jtag_inst1_UPDATE                  ),
    .jtagCtrl_reset                     (jtag_inst1_RESET                   )
);


//////////////////////////////////////////////////////////////////////////////
// TinyML accelerator

tinyml_top#(
  .AXI_DW             (AXI_TINYML_DATA_WIDTH)
) u_tinyml_top(
   .clk              (i_sysclk),
   .reset            (io_systemReset),
   .cmd_valid        (cpu_customInstruction_cmd_valid),
   .cmd_ready        (cpu_customInstruction_cmd_ready),
   .cmd_function_id  (cpu_customInstruction_function_id),
   .cmd_inputs_0     (cpu_customInstruction_inputs_0),
   .cmd_inputs_1     (cpu_customInstruction_inputs_1),
   .cmd_int          (cpu_customInstruction_cmd_int),
   .rsp_valid        (cpu_customInstruction_rsp_valid),
   .rsp_ready        (cpu_customInstruction_rsp_ready),
   .rsp_outputs_0    (cpu_customInstruction_outputs_0),
   .m_axi_clk        (io_memoryClk),
   .m_axi_rstn       (!io_systemReset),
   .m_axi_awvalid    (axi_inter_s2_awvalid),
   .m_axi_awaddr     (axi_inter_s2_awaddr),
   .m_axi_awlen      (axi_inter_s2_awlen),
   .m_axi_awsize     (axi_inter_s2_awsize),
   .m_axi_awburst    (axi_inter_s2_awburst),
   .m_axi_awprot     (axi_inter_s2_awprot),
   .m_axi_awlock     (axi_inter_s2_awlock),
   .m_axi_awcache    (axi_inter_s2_awcache),
   .m_axi_awready    (axi_inter_s2_awready),
   .m_axi_wdata      (axi_inter_s2_wdata),
   .m_axi_wstrb      (axi_inter_s2_wstrb),
   .m_axi_wlast      (axi_inter_s2_wlast),
   .m_axi_wvalid     (axi_inter_s2_wvalid),
   .m_axi_wready     (axi_inter_s2_wready),
   .m_axi_bresp      (axi_inter_s2_bresp),
   .m_axi_bvalid     (axi_inter_s2_bvalid),
   .m_axi_bready     (axi_inter_s2_bready),
   .m_axi_arvalid    (axi_inter_s2_arvalid),
   .m_axi_araddr     (axi_inter_s2_araddr),
   .m_axi_arlen      (axi_inter_s2_arlen),
   .m_axi_arsize     (axi_inter_s2_arsize),
   .m_axi_arburst    (axi_inter_s2_arburst),
   .m_axi_arprot     (axi_inter_s2_arprot),
   .m_axi_arlock     (axi_inter_s2_arlock),
   .m_axi_arcache    (axi_inter_s2_arcache),
   .m_axi_arready    (axi_inter_s2_arready),
   .m_axi_rvalid     (axi_inter_s2_rvalid),
   .m_axi_rdata      (axi_inter_s2_rdata),
   .m_axi_rlast      (axi_inter_s2_rlast),
   .m_axi_rresp      (axi_inter_s2_rresp),
   .m_axi_rready     (axi_inter_s2_rready)
);
//s0-soc s1-dma s2-tinyml
axi_interconnect #(
   .S_COUNT    (3),
   .M_COUNT    (1),
   .DATA_WIDTH (AXI_DATA_WIDTH),
   .ADDR_WIDTH (32),
   .ID_WIDTH   (8)
) u_axi_interconnect (
   .clk              (io_memoryClk),
   .rst              (io_systemReset),
   .s_axi_awid       ({axi_inter_s2_awid   , axi_inter_s1_awid   , axi_inter_s0_awid   }),
   .s_axi_awaddr     ({axi_inter_s2_awaddr , axi_inter_s1_awaddr , axi_inter_s0_awaddr }),
   .s_axi_awlen      ({axi_inter_s2_awlen  , axi_inter_s1_awlen  , axi_inter_s0_awlen  }),
   .s_axi_awvalid    ({axi_inter_s2_awvalid, axi_inter_s1_awvalid, axi_inter_s0_awvalid}),
   .s_axi_awready    ({axi_inter_s2_awready, axi_inter_s1_awready, axi_inter_s0_awready}),
   .s_axi_wdata      ({axi_inter_s2_wdata  , axi_inter_s1_wdata  , axi_inter_s0_wdata  }),
   .s_axi_wstrb      ({axi_inter_s2_wstrb  , axi_inter_s1_wstrb  , axi_inter_s0_wstrb  }),
   .s_axi_wlast      ({axi_inter_s2_wlast  , axi_inter_s1_wlast  , axi_inter_s0_wlast  }),
   .s_axi_wvalid     ({axi_inter_s2_wvalid , axi_inter_s1_wvalid , axi_inter_s0_wvalid }),
   .s_axi_wready     ({axi_inter_s2_wready , axi_inter_s1_wready , axi_inter_s0_wready }),
   .s_axi_bid        ({axi_inter_s2_bid    , axi_inter_s1_bid    , axi_inter_s0_bid    }),
   .s_axi_bresp      ({axi_inter_s2_bresp  , axi_inter_s1_bresp  , axi_inter_s0_bresp  }),
   .s_axi_bvalid     ({axi_inter_s2_bvalid , axi_inter_s1_bvalid , axi_inter_s0_bvalid }),
   .s_axi_bready     ({axi_inter_s2_bready , axi_inter_s1_bready , axi_inter_s0_bready }),
   .s_axi_arid       ({axi_inter_s2_arid   , axi_inter_s1_arid   , axi_inter_s0_arid   }),
   .s_axi_araddr     ({axi_inter_s2_araddr , axi_inter_s1_araddr , axi_inter_s0_araddr }),
   .s_axi_arlen      ({axi_inter_s2_arlen  , axi_inter_s1_arlen  , axi_inter_s0_arlen  }),
   .s_axi_arvalid    ({axi_inter_s2_arvalid, axi_inter_s1_arvalid, axi_inter_s0_arvalid}),
   .s_axi_arready    ({axi_inter_s2_arready, axi_inter_s1_arready, axi_inter_s0_arready}),
   .s_axi_rid        ({axi_inter_s2_rid    , axi_inter_s1_rid    , axi_inter_s0_rid    }),
   .s_axi_rdata      ({axi_inter_s2_rdata  , axi_inter_s1_rdata  , axi_inter_s0_rdata  }),
   .s_axi_rresp      ({axi_inter_s2_rresp  , axi_inter_s1_rresp  , axi_inter_s0_rresp  }),
   .s_axi_rlast      ({axi_inter_s2_rlast  , axi_inter_s1_rlast  , axi_inter_s0_rlast  }),
   .s_axi_rvalid     ({axi_inter_s2_rvalid , axi_inter_s1_rvalid , axi_inter_s0_rvalid }),
   .s_axi_rready     ({axi_inter_s2_rready , axi_inter_s1_rready , axi_inter_s0_rready }),

	   // AXI protocol signals (were floating, causing burst=FIXED which DDR3 rejects)
	   .s_axi_awuser     (3'b000),
	   .s_axi_awsize     ({axi_inter_s2_awsize , axi_inter_s1_awsize , axi_inter_s0_awsize }),
	   .s_axi_awburst    ({axi_inter_s2_awburst, axi_inter_s1_awburst, axi_inter_s0_awburst}),
	   .s_axi_awlock     ({axi_inter_s2_awlock , axi_inter_s1_awlock , axi_inter_s0_awlock }),
	   .s_axi_awcache    ({axi_inter_s2_awcache, axi_inter_s1_awcache, axi_inter_s0_awcache}),
	   .s_axi_awprot     ({axi_inter_s2_awprot , axi_inter_s1_awprot , axi_inter_s0_awprot }),
	   .s_axi_awqos      ({axi_inter_s2_awqos  , axi_inter_s1_awqos  , axi_inter_s0_awqos  }),
	   .s_axi_aruser     (3'b000),
	   .s_axi_arsize     ({axi_inter_s2_arsize , axi_inter_s1_arsize , axi_inter_s0_arsize }),
	   .s_axi_arburst    ({axi_inter_s2_arburst, axi_inter_s1_arburst, axi_inter_s0_arburst}),
	   .s_axi_arlock     ({axi_inter_s2_arlock , axi_inter_s1_arlock , axi_inter_s0_arlock }),
	   .s_axi_arcache    ({axi_inter_s2_arcache, axi_inter_s1_arcache, axi_inter_s0_arcache}),
	   .s_axi_arprot     ({axi_inter_s2_arprot , axi_inter_s1_arprot , axi_inter_s0_arprot }),
	   .s_axi_arqos      ({axi_inter_s2_arqos  , axi_inter_s1_arqos  , axi_inter_s0_arqos  }),

   .m_axi_awid       (axi_inter_m_awid),
   .m_axi_awaddr     (axi_inter_m_awaddr),
   .m_axi_awlen      (axi_inter_m_awlen),
   .m_axi_awsize     (axi_inter_m_awsize),
   .m_axi_awburst    (axi_inter_m_awburst),
   .m_axi_awlock     (axi_inter_m_awlock),
   .m_axi_awcache    (axi_inter_m_awcache),
   .m_axi_awprot     (axi_inter_m_awprot),
   .m_axi_awvalid    (axi_inter_m_awvalid),
   .m_axi_awready    (axi_inter_m_awready),
   .m_axi_wdata      (axi_inter_m_wdata),
   .m_axi_wstrb      (axi_inter_m_wstrb),
   .m_axi_wlast      (axi_inter_m_wlast),
   .m_axi_wvalid     (axi_inter_m_wvalid),
   .m_axi_wready     (axi_inter_m_wready),
   .m_axi_bresp      (axi_inter_m_bresp),
   .m_axi_bvalid     (axi_inter_m_bvalid),
   .m_axi_bready     (axi_inter_m_bready),
   .m_axi_arid       (axi_inter_m_arid),
   .m_axi_araddr     (axi_inter_m_araddr),
   .m_axi_arlen      (axi_inter_m_arlen),
   .m_axi_arsize     (axi_inter_m_arsize),
   .m_axi_arburst    (axi_inter_m_arburst),
   .m_axi_arlock     (axi_inter_m_arlock),
   .m_axi_arcache    (axi_inter_m_arcache),
   .m_axi_arprot     (axi_inter_m_arprot),
   .m_axi_arvalid    (axi_inter_m_arvalid),
   .m_axi_arready    (axi_inter_m_arready),
   .m_axi_rdata      (axi_inter_m_rdata),
   .m_axi_rresp      (axi_inter_m_rresp),
   .m_axi_rlast      (axi_inter_m_rlast),
   .m_axi_rvalid     (axi_inter_m_rvalid),
   .m_axi_rready     (axi_inter_m_rready)
);





// =========================================================================================================================================
// DDR Ctrl
// ========================================================================================================================================= 
	wire                            lcd_de;
	wire                            lcd_hs;      
	wire                            lcd_vs;
	wire 					  lcd_request; 
	wire            [7:0]           lcd_red, lcd_red2;
	wire            [7:0]           lcd_green, lcd_green2;
	wire            [7:0]           lcd_blue, lcd_blue2;
	wire            [31:0]          lcd_data;


		// axi4_ctrl direct to AXI Interconnect S1 (no intermediate wires)
	wire rstn_pixel = ~io_systemReset;

	wire 			w_wframe_vsync;
	wire 	[7:0] 	w_axi_tp;

	axi4_ctrl #(.C_RD_END_ADDR(1280 * 720 *4), .C_W_WIDTH(32), .C_R_WIDTH(32), .C_ID_LEN(4),
	.C_BASE_ADDR(32'h00001000)) u_axi4_ctrl (
		.axi_clk        (io_memoryClk            ),
		.axi_reset      (io_systemReset          ),
		.enable         (~system_gpio_0_io_write[0] ),

		.axi_awid       (axi_inter_s1_awid       ),
		.axi_awaddr     (axi_inter_s1_awaddr     ),
		.axi_awlen      (axi_inter_s1_awlen      ),
		.axi_awsize     (axi_inter_s1_awsize     ),
		.axi_awburst    (axi_inter_s1_awburst    ),
		.axi_awlock     (axi_inter_s1_awlock     ),
		.axi_awcache    (axi_inter_s1_awcache    ),
		.axi_awprot     (axi_inter_s1_awprot     ),
		.axi_awqos      (axi_inter_s1_awqos      ),
		.axi_awvalid    (axi_inter_s1_awvalid    ),
		.axi_awready    (axi_inter_s1_awready    ),

		.axi_wdata      (axi_inter_s1_wdata      ),
		.axi_wstrb      (axi_inter_s1_wstrb      ),
		.axi_wlast      (axi_inter_s1_wlast      ),
		.axi_wvalid     (axi_inter_s1_wvalid     ),
		.axi_wready     (axi_inter_s1_wready     ),

		.axi_bid        (axi_inter_s1_bid        ),
		.axi_bresp      (axi_inter_s1_bresp      ),
		.axi_bvalid     (axi_inter_s1_bvalid     ),
		.axi_bready     (axi_inter_s1_bready     ),

		.axi_arid       (axi_inter_s1_arid       ),
		.axi_araddr     (axi_inter_s1_araddr     ),
		.axi_arlen      (axi_inter_s1_arlen      ),
		.axi_arsize     (axi_inter_s1_arsize     ),
		.axi_arburst    (axi_inter_s1_arburst    ),
		.axi_arlock     (axi_inter_s1_arlock     ),
		.axi_arcache    (axi_inter_s1_arcache    ),
		.axi_arprot     (axi_inter_s1_arprot     ),
		.axi_arqos      (axi_inter_s1_arqos      ),
		.axi_arvalid    (axi_inter_s1_arvalid    ),
		.axi_arready    (axi_inter_s1_arready    ),

		.axi_rid        (axi_inter_s1_rid        ),
		.axi_rdata      (axi_inter_s1_rdata      ),
		.axi_rresp      (axi_inter_s1_rresp      ),
		.axi_rlast      (axi_inter_s1_rlast      ),
		.axi_rvalid     (axi_inter_s1_rvalid     ),
		.axi_rready     (axi_inter_s1_rready     ),

		.wframe_pclk    (w_csi_rx_clk            ),
		.wframe_vsync   (rgb_vsync               ),
		.wframe_data_en (rgb_valid               ),
		.wframe_data    ({8'b0, rgb_data}        ),

		.rframe_pclk    (clk_pixel               ),
		.rframe_vsync   (~lcd_vs  ), // gated by GPIO: no DDR read until SoC boots
		.rframe_data_en (lcd_request             ),
		.rframe_data    (lcd_data                ),

		.tp_o 			(w_axi_tp                )
	);

 
// =========================================================================================================================================
// lcd_driver
// ========================================================================================================================================= 
	
wire [11:0] x_pos;
wire [11:0] y_pos;
wire [23:0] char_data;
wire data_enable;
wire data_enable2;


    lcd_driver u_lcd_driver
    (
	    //  global clock
    .clk                               (clk_pixel                 ),
    .rst_n                             (rstn_pixel                ),
	    
	    //  lcd interface
    .lcd_dclk                          (                          ),
    .lcd_blank                         (                          ),
    .lcd_sync                          (                          ),
    .lcd_request                       (lcd_request               ),//	Request data 1 cycle ahead. 
    .lcd_hs                            (lcd_hs                    ),
    .lcd_vs                            (lcd_vs                    ),
    .lcd_en                            (lcd_de                    ),
    .lcd_rgb                           ({lcd_red2,lcd_green2,lcd_blue2, lcd_red,lcd_green,lcd_blue}),
	    
	    //  user interface
    .lcd_data                          ({lcd_data[23:0] ,lcd_data[23:0]}),
    .lcd_xpos                          (x_pos                     ),
    .lcd_ypos                          (y_pos                     )
    );

	// ---- BBox Overlay ----
	wire        box_wr;
	wire [3:0]  box_addr;
	wire [31:0] box_data;
	wire [7:0]  ol_r, ol_g, ol_b;

	// ---- OSD Overlay (combined shadow + foreground) ----
	wire        bbox_hs, bbox_vs, bbox_de;
	wire [7:0]  osd_r, osd_g, osd_b;
	wire        osd_hs, osd_vs, osd_de;
	wire        osd_ae_me;

	assign osd_ae_me = ~system_gpio_0_io_write[1];

	uart_bbox #(.CLK_HZ(74250000)) u_uart_bbox (
	    .clk        (clk_pixel),
	    .rst_n      (rstn_pixel),
	    .uart_rx    (uart_tx_o),
	    .box_wr     (box_wr),
	    .box_addr   (box_addr),
	    .box_data   (box_data)
	);

	bbox_overlay u_bbox_overlay (
	    .clk        (clk_pixel),
	    .rst_n      (rstn_pixel),
	    .i_hs       (lcd_hs),
	    .i_vs       (lcd_vs),
	    .i_de       (lcd_de),
	    .i_r        (lcd_red),
	    .i_g        (lcd_green),
	    .i_b        (lcd_blue),
	    .i_x        (x_pos),
	    .i_y        (y_pos),
	    .o_hs       (bbox_hs),
	    .o_vs       (bbox_vs),
	    .o_de       (bbox_de),
	    .o_r        (ol_r),
	    .o_g        (ol_g),
	    .o_b        (ol_b),
	    .reg_wr     (box_wr),
	    .reg_addr   (box_addr),
	    .reg_wdata  (box_data),
	    .reg_rdata  (),
	    .box_count  ()
	);

	// OSD overlay (shadow + foreground in one pass)
	osd_overlay u_osd_overlay (
	    .clk        (clk_pixel),
	    .rst_n      (rstn_pixel),
	    .ae_me      (osd_ae_me),
	    .i_hs       (bbox_hs),
	    .i_vs       (bbox_vs),
	    .i_de       (bbox_de),
	    .i_r        (ol_r),
	    .i_g        (ol_g),
	    .i_b        (ol_b),
	    .o_hs       (osd_hs),
	    .o_vs       (osd_vs),
	    .o_de       (osd_de),
	    .o_r        (osd_r),
	    .o_g        (osd_g),
	    .o_b        (osd_b)
	);

	assign hdmi_data =  {osd_r, osd_g, osd_b};
	assign hdmi_vs   = osd_vs;
	assign hdmi_hs   = osd_hs;
	assign hdmi_de   = osd_de;
// =========================================================================================================================================
// BoundCrop
// ========================================================================================================================================= 

wire                                    w_rgb_vs_o, w_rgb_hs_o, w_rgb_de_o;
wire                   [  23:0]         w_rgb_data_o               ;
FrameBoundCrop #(.SKIP_ROWS(4),.SKIP_COLS(2),.TOTAL_ROWS(720),.TOTAL_COLS(1280)) inst_FrameCrop(
    .clk_i                             (clk_pixel                 ),
    .rst_i                             (~rstn_pixel                ),

    .hs_i                              (osd_hs              ),
    .vs_i                              (osd_vs              ),
    .de_i                              (osd_de              ),
    .data_i                            (hdmi_data            ),
	
    .vs_o                              (w_rgb_vs_o                ),
    .hs_o                              (w_rgb_hs_o                ),
    .de_o                              (w_rgb_de_o                ),
    .data_o                            (w_rgb_data_o              ) 
);
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//	LVDS Output 
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//	HDMI requires specific timing, thus is not compatible with LCD & LVDS & DSI. Must implement standalone. 
	
  assign hdmi_txd0_rst_o = io_systemReset; 
  assign hdmi_txd1_rst_o = io_systemReset; 
  assign hdmi_txd2_rst_o = io_systemReset; 
  assign hdmi_txc_rst_o  = io_systemReset; 

  assign hdmi_txd0_oe = 1'b1; 
  assign hdmi_txd1_oe = 1'b1; 
  assign hdmi_txd2_oe = 1'b1; 
  assign hdmi_txc_oe = 1'b1; 

   rgb2dvi #(.ENABLE_OSERDES(0)) u_rgb2dvi 
	(
		.oe_i 		(1                   ), 			//	Always enable output
		.bitflip_i  (4'b0000             ), 		//	Reverse clock & data lanes. 
		
		.aRst	    (1'b0                ), 
		.aRst_n		(1'b1                ), 
		
		.PixelClk	(clk_pixel           ),//pixel clk = 74.25M
		.SerialClk  (                    ),//pixel clk *5 = 371.25M
		
		.vid_pVSync                        (w_rgb_vs_o                    ),
    .vid_pHSync                        (w_rgb_hs_o                    ),
    .vid_pVDE                          (w_rgb_de_o                    ),
    .vid_pData                         (w_rgb_data_o),
		
		.txc_o		(hdmi_txc_o           ), 
		.txd0_o		(hdmi_txd0_o          ), 
		.txd1_o		(hdmi_txd1_o          ), 
		.txd2_o		(hdmi_txd2_o          )
	); 
endmodule
