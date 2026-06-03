//***************************************************************/
//   ______   _   _   _                  _            _
//  |  ____| | | (_) | |                | |          | |
//  | |__    | |  _  | |_    ___   ___  | |_    ___  | | __
//  |  __|   | | | | | __|  / _ \ / __| | __|  / _ \ | |/ /
//  | |____  | | | | | |_  |  __/ \__ \ | |_  |  __/ |   <  
//  |______| |_| |_|  \__|  \___| |___/  \__|  \___| |_|\_\
//
// Moudel Name    : phy_ctl.v
// Version        : 1.2
// Date Created   : 2023-02-23 10:37:59
// Last Modified  : 2023-02-23 10:37:59
// Abstract       : ---
//
//Copyright (c) 2020-2023 Elitestek,Inc. All Rights Reserved.
//
//***************************************************************/
//Modification History
//1.initial
//***************************************************************/
`timescale 1 ps / 1 ps

module phy_ctl # (

parameter                       DEBUG_WIDTH     = 25,
parameter                       TCQ             = 100,     
parameter                       AL              = "0",     
parameter                       BANK_WIDTH      = 3,       
parameter                       BURST_MODE      = "8",     
parameter                       CK_WIDTH        = 1,       
parameter                       CL              = 5,
parameter                       COL_WIDTH       = 12,      
parameter                       CS_WIDTH        = 1,       
parameter                       CKE_WIDTH       = 1,       
parameter                       CWL             = 5,
parameter                       DM_WIDTH        = 8,       
parameter                       DQ_WIDTH        = 64,      
parameter                       DQS_CNT_WIDTH   = 3,       
parameter                       DQS_WIDTH       = 8,       
parameter                       DRAM_WIDTH      = 8,       
parameter                       RX_CLK_SEL        = 5'b00100, //rx_cal_clk  PLL out sel
parameter                       TX_CLK_SEL        = 5'b01000, //tx_cal_clk  PLL out sel
parameter                       TX_CLK_90EDGE_SEL = 5'b00001, //tx_cal_clk_90edge  PLL out sel
parameter                       CK_RATIO        = 4,       
parameter                       RANK_RATIO      = 1,       
parameter                       RTT_NOM         = "60",    
parameter                       RTT_WR          = "120",   
parameter                       tCK             = 2500,    
parameter                       tRFC            = 110000,  
parameter                       tREFI           = 7800000, 
parameter                       RANKS           = 4,
parameter                       ODT_WIDTH       = 1,
parameter                       ROW_WIDTH       = 16      
)
(
input                           core_clk,            // CORE CLK @ 100MHz
input                           sdram_clk,           // SDRAM CK @ 400MHz
input                           rx_cal_clk,          // SDRAM CK @ 400MHz
input                           tx_cal_clk,          // SDRAM CK @ 400MHz
input                           tx_cal_clk_90edge,   // SDRAM CK @ 400MHz
input                           sdram_rst,
input                           rx_clk_rst,
input                           tx_data_rst,
input                           rst,
input                           tx_clk_rst,
// PLL status flags  
output  reg [2:0]               pll_shift,  
output  reg [4:0]               pll_shift_sel,
output                          pll_shift_ena,   
// debug port 
output      [2:0]               rdlvl_shift, 
output      [2:0]               wrlvl_shift, 
output      [DEBUG_WIDTH-1:0]   ddr_phy_debug, 
output                          phy_mc_ctl_full,
output                          phy_mc_cmd_full,
output                          phy_mc_data_full,
output                          init_calib_complete,
output                          phy_rddata_valid,
output      [2*CK_RATIO*DQ_WIDTH-1:0]           
                                phy_rd_data,
input       [CK_RATIO-1:0]      mc_ras_n,
input       [CK_RATIO-1:0]      mc_cas_n,
input       [CK_RATIO-1:0]      mc_we_n,
input       [CK_RATIO*ROW_WIDTH-1:0]             
                                mc_address,
input       [CK_RATIO*BANK_WIDTH-1:0]            
                                mc_bank,
input       [CS_WIDTH*RANK_RATIO*CK_RATIO-1:0] 
                                mc_cs_n,
input                           mc_reset_n,
input       [1:0]               mc_odt,
input       [CK_RATIO*CKE_WIDTH-1:0]      
                                mc_cke,

input       [3:0]               mc_aux_out0,
input       [3:0]               mc_aux_out1,
input                           mc_cmd_wren,
input                           mc_ctl_wren,
input       [2:0]               mc_cmd,
input       [1:0]               mc_cas_slot,
input       [5:0]               mc_data_offset,
input       [5:0]               mc_data_offset_1,
input       [5:0]               mc_data_offset_2,
input       [1:0]               mc_rank_cnt,
input                           mc_wrdata_en,
input       [2*CK_RATIO*DQ_WIDTH-1:0]     
                                mc_wrdata,
input       [2*CK_RATIO*(DQ_WIDTH/8)-1:0] 
                                mc_wrdata_mask,
// DDR bus signals
output                          ddr3_ck_hi,
output                          ddr3_ck_lo,
output      [CKE_WIDTH-1:0]     ddr3_cke,
output                          ddr3_reset_n,
output      [CS_WIDTH*RANK_RATIO-1:0]
                                ddr3_cs_n,
output                          ddr3_ras_n,
output                          ddr3_cas_n,
output                          ddr3_we_n,
output      [BANK_WIDTH-1:0]    ddr3_ba,
output      [ROW_WIDTH-1:0]     ddr3_addr,

output                          ddr3_dqs_oe,
output                          ddr3_dq_oe,
input       [DQS_WIDTH-1:0]     ddr3_dqs_in_hi,
input       [DQS_WIDTH-1:0]     ddr3_dqs_in_lo,
input       [DQ_WIDTH-1:0]      ddr3_dq_in_hi,
input       [DQ_WIDTH-1:0]      ddr3_dq_in_lo,
        
output      [DQS_WIDTH-1:0]     ddr3_dqs_out_hi,
output      [DQS_WIDTH-1:0]     ddr3_dqs_out_lo,
output      [DQ_WIDTH-1:0]      ddr3_dq_out_hi,
output      [DQ_WIDTH-1:0]      ddr3_dq_out_lo,
output      [DM_WIDTH-1:0]      ddr3_dm_hi,
output      [DM_WIDTH-1:0]      ddr3_dm_lo,
output      [ODT_WIDTH-1:0]     ddr3_odt  
  
  );
//Parameter Define
localparam              CLK_PERIOD = tCK * CK_RATIO;

//Register Define

//Wire Define 
wire    [2*CK_RATIO*DQ_WIDTH-1:0]phy_wrdata;
wire    [CK_RATIO*ROW_WIDTH-1:0] phy_address;
wire    [CK_RATIO*BANK_WIDTH-1:0]phy_bank;
wire    [CS_WIDTH*RANK_RATIO*CK_RATIO-1:0] 
                                phy_cs_n;
wire    [CK_RATIO-1:0]          phy_ras_n;
wire    [CK_RATIO-1:0]          phy_cas_n;
wire    [CK_RATIO-1:0]          phy_we_n;
wire                            phy_reset_n;
wire    [3:0]                   calib_aux_out;
wire    [CK_RATIO-1:0]          calib_cke;
wire    [1:0]                   calib_odt;
wire                            write_calib;
wire                            wl_sm_start;
wire                            wl_sm_start_dly;
wire                            calib_ctl_wren;
wire                            calib_cmd_wren;
wire                            calib_wrdata_en;
wire    [2:0]                   calib_cmd;
wire    [1:0]                   calib_seq;
wire    [5:0]                   calib_data_offset_0;
wire    [5:0]                   calib_data_offset_1;
wire    [5:0]                   calib_data_offset_2;
wire    [1:0]                   calib_rank_cnt;
wire    [1:0]                   calib_cas_slot;
wire    [CK_RATIO*ROW_WIDTH-1:0]mux_address;
wire    [3:0]                   mux_aux_out;
wire    [3:0]                   aux_out_map;
wire    [CK_RATIO*BANK_WIDTH-1:0]
                                mux_bank;
wire    [2:0]                   mux_cmd;
wire                            mux_cmd_wren;
wire    [CS_WIDTH*RANK_RATIO*CK_RATIO-1:0]   
                                mux_cs_n;
wire                            mux_ctl_wren;
wire    [1:0]                   mux_cas_slot;
wire    [5:0]                   mux_data_offset;
wire    [5:0]                   mux_data_offset_1;
wire    [5:0]                   mux_data_offset_2;
wire    [CK_RATIO-1:0]          mux_ras_n;
wire    [CK_RATIO-1:0]          mux_cas_n;
wire    [1:0]                   mux_rank_cnt;
wire                            mux_reset_n;
wire    [CK_RATIO-1:0]          mux_we_n;
wire    [2*CK_RATIO*DQ_WIDTH-1:0]              
                                mux_wrdata;
wire    [2*CK_RATIO*(DQ_WIDTH/8)-1:0]          
                                mux_wrdata_mask;
wire                            mux_wrdata_en;
wire    [CK_RATIO-1:0]          mux_cke ;
wire    [1:0]                   mux_odt ;  
    
wire                            dqs_locked_start;
wire                            dqs_locked_done;
wire                            rdlvl_all_dqs_done;
wire    [1:0]                   dqs_bit_sample_err;
wire                            rdlvl_dqs_check_ena;
wire    [DQS_WIDTH-1:0]         wrlvl_dqs_hi;
wire    [DQS_WIDTH-1:0]         wrlvl_dqs_lo;
wire    [DQS_WIDTH-1:0]         ddr_dqs_out_hi;
wire    [DQS_WIDTH-1:0]         ddr_dqs_out_lo;
wire                            wr_level_start;  
wire                            wrlvl_dqs_oe;  
wire                            calib_dq_oe;  
wire                            calib_dqs_oe;  
wire                            wr_level_done;  
wire                            wrlvl_rank_done; 
wire                            wr_level_delay; 
wire                            dqs_invert; 
wire                            dq_check_en; 
wire                            dq_bit_sample_ok; 
wire                            rdlvl_dqs_shift_ena;
wire                            wrlvl_shift_ena;
wire    [2:0]                   rdlvl_dqs_phise_shift;
wire    [2:0]                   wrlvl_phise_shift;
wire    [DM_WIDTH-1:0]          ddr_dm_hi;
wire    [DM_WIDTH-1:0]          ddr_dm_lo;
wire                            phy_rddata_valid_w;
wire    [2*CK_RATIO*DQ_WIDTH-1:0]              
                                phy_rd_data_w;
wire                            mpr_rddata_valid;
wire    [2*CK_RATIO*DQ_WIDTH-1:0]              
                                mpr_rd_data;
wire                            wrcal_rddata_valid;
wire    [2*CK_RATIO*DQ_WIDTH-1:0]
                                wrcal_rd_data;
wire                            mpr_rdlvl_dly;
wire                            idelay_ld;
wire                            wrcal_resume;
wire                            wrcal_pat_resume;
wire    [31:0]                  phy_ctl_wd;  
wire                            phy_dqs_oe;
wire                            phy_dq_oe;
wire                            phy_ctl_full;
wire                            phy_cmd_full;
wire                            phy_data_full;
wire    [2:0]                   shift;  
wire    [4:0]                   shift_sel;
wire                            shift_ena; 
wire                            phy_rst; 
wire    [6:0]                   init_cur_state;
wire    [7:0]                   rd_level_dqs_check;
wire    [7:0]                   wrlvl_dq_check;
reg                             pll_shift_wl_sel;
wire    [16-1:0]                debug_fifo;
wire    [16-1:0]                overflow_fifo;
//Encryption begin
`pragma protect begin_protected
`pragma protect version=1
`pragma protect encrypt_agent="ipecrypt"
`pragma protect encrypt_agent_info="http://ipencrypter.com Version: 20.0.8"
`pragma protect author="author-a"
`pragma protect author_info="author-a-details"

`pragma protect key_keyowner="Efinix Inc."
`pragma protect key_keyname="EFX_K01"
`pragma protect key_method="rsa"
`pragma protect encoding=(enctype="base64", line_length=64, bytes=256)
`pragma protect key_block
hFW/wvSR4+xDG3Y35MCEPF+6Mw28pVGJZposq0HWAifA0pfJDcF9DqDfldgWDfQI
mWcptTtTxp4AlwoBI+FpItMcHAsqX4u3TyNhGYaFazvZRtw1Qs5TJgg76cav5ejN
J2J4lEKksS6uYhNGvHwl7GqiIxUIye+6+604wsojGCoLbRMXa2eHLuJQzRG3xFjh
wyCpdVNqCVnOJuw4ZwQ8LhM1dWVQfUTWu48OCL2WQU636ftQJuVjxW7Vb+jvEhLv
h+E/u63vkv9HQvEwc5kikHRdlaP1MvPOqhM/KA/6tjZy/WE4jwDQbCP8oZuuY2bF
tuyF27cmrFrEV6PUGlISAA==
`pragma protect key_keyowner="Mentor Graphics Corporation"
`pragma protect key_keyname="MGC-VERIF-SIM-RSA-1"
`pragma protect key_method="rsa"
`pragma protect encoding=(enctype="base64", line_length=64, bytes=128)
`pragma protect key_block
Hk9jlzdJbFBGgxlJKqQ5Da7I4ct2RW+onh9VxB1p+rMd9+PGIfOvkr2p+XQYSGx0
jtw7WbvtGKTrJBRekt5mCCeOMApGOxFU9mfqrHW5lAaDFsKScxZ+fenqkCScr5G7
Qn1WpnkGXlh8aEihnY4qsjG7mPrBzih6vuXTWXy8cpI=
`pragma protect data_method="aes256-cbc"
`pragma protect encoding=(enctype="base64", line_length=64, bytes=22672)
`pragma protect data_block
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
Rxv55a27W7DKrUqet5N0Pw==
`pragma protect end_protected
endmodule
