//***************************************************************/
//   ______   _   _   _                  _            _
//  |  ____| | | (_) | |                | |          | |
//  | |__    | |  _  | |_    ___   ___  | |_    ___  | | __
//  |  __|   | | | | | __|  / _ \ / __| | __|  / _ \ | |/ /
//  | |____  | | | | | |_  |  __/ \__ \ | |_  |  __/ |   <  
//  |______| |_| |_|  \__|  \___| |___/  \__|  \___| |_|\_\
//
// Moudel Name    : ddr_phy_if.v
// Version        : 1.3
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


  `timescale 1ps/1ps
module ddr_phy_if #(
parameter                       tCK          = 1500,        
parameter                       WL           = 5,           
parameter                       nCL          = 5,                   
parameter                       CK_RATIO     = 4,           
parameter                       BANK_WIDTH   = 2,
parameter                       RANK_RATIO   = 1,           
parameter                       DQ_WIDTH     = 64,
parameter                       DQS_WIDTH    = 8,
parameter                       DM_WIDTH     = 8,
parameter                       ROW_WIDTH    = 14,
parameter                       CS_WIDTH     = 1,
parameter                       ODT_WIDTH    = 1,
parameter                       CKE_WIDTH    = 1       

)(
// clock & reset
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

input                           phy_cmd_wr_en,
input                           phy_data_wr_en,
input           [31:0]          phy_ctl_wd,
input                           phy_ctl_wr,
output                          phy_ctl_full,
output                          phy_cmd_full,
output                          phy_data_full,
output                          wl_sm_start,
output  reg     [1:0]           dqs_bit_sample_err,
output  reg                     dq_bit_sample_ok,
output  reg                     ddr_dq_vld_r,
input                           dq_check_en,
input                           rdlvl_dqs_check_ena,
input                           idelay_ld,
input                           wrlvl_rank_done,
input                           wr_level_delay,
input                           mpr_rdlvl_dly,
input                           mpr_rdlvl_en,
input                           dqs_invert,
// From/to calibration logic/soft PHY
input                           init_calib_complete,
input           [CK_RATIO-1:0]  mux_cke,
input           [CS_WIDTH*RANK_RATIO*CK_RATIO-1:0] 
                                mux_cs_n,
input           [CK_RATIO-1:0]  mux_ras_n,
input           [CK_RATIO-1:0]  mux_cas_n,
input           [CK_RATIO-1:0]  mux_we_n,
input           [CK_RATIO*BANK_WIDTH-1:0] 
                                mux_bank,
input           [CK_RATIO*ROW_WIDTH-1:0]  
                                mux_address,
input           [1:0]           mux_odt,
input           [2*CK_RATIO*DQ_WIDTH-1:0] 
                                mux_wrdata,
input           [2*CK_RATIO*DM_WIDTH-1:0] 
                                mux_wrdata_mask,
input                           mux_reset_n,
output                          phy_rddata_valid,
output           [2*CK_RATIO*DQ_WIDTH-1:0]
                                phy_rd_data,
output           [8-1:0]        debug_fifo,                                
output           [8-1:0]        overflow_fifo,                                
// DDR bus signals
output                          ddr_ck_hi,
output                          ddr_ck_lo,
output           [CKE_WIDTH-1:0]ddr_cke,
output                          ddr_reset_n,
output           [CS_WIDTH*RANK_RATIO-1:0]
                                ddr_cs_n,
output                          ddr_ras_n,
output                          ddr_cas_n,
output                          ddr_we_n,
output           [BANK_WIDTH-1:0]
                                ddr_ba,
output           [ROW_WIDTH-1:0]ddr_addr,
               
input            [DQS_WIDTH-1:0]ddr_dqs_in_hi,
input            [DQS_WIDTH-1:0]ddr_dqs_in_lo,
input            [DQ_WIDTH-1:0] ddr_dq_in_hi,
input            [DQ_WIDTH-1:0] ddr_dq_in_lo,

output  reg                     phy_dqs_oe,
output  reg                     phy_dq_oe,
output           [DQS_WIDTH-1:0]ddr_dqs_out_hi,
output           [DQS_WIDTH-1:0]ddr_dqs_out_lo,
output  reg      [DQ_WIDTH-1:0] ddr_dq_out_hi,
output  reg      [DQ_WIDTH-1:0] ddr_dq_out_lo,
output  reg      [DM_WIDTH-1:0] ddr_dm_hi,
output  reg      [DM_WIDTH-1:0] ddr_dm_lo,
output  reg      [ODT_WIDTH-1:0]ddr_odt

);

//Parameter Define
localparam CWL_M =  WL ;//+ nAL;
localparam CMD_WTH = (CKE_WIDTH+3+ (CS_WIDTH*RANK_RATIO)+BANK_WIDTH+ROW_WIDTH) *CK_RATIO;
localparam DFIFO_WTH =2*CK_RATIO*(DQ_WIDTH + DM_WIDTH);
localparam FIFO_DEPTH =16;
localparam WR  = 4'b0100;
localparam RD  = 4'b0101;
localparam POS = 2'b10;
localparam NEG = 2'b01;

//Register Define
reg                             u1_wrreq_r;
reg     [CMD_WTH+1:0]           u1_data_r;
reg                             u2_wrreq_r;
reg     [31:0]                  u2_data_r;
reg                             u4_wrreq;
reg     [2*CK_RATIO*(DQ_WIDTH)-1:0]    
                                u4_data;
reg     [CK_RATIO-1:0]          rd_data_cke  ;
reg     [CS_WIDTH*RANK_RATIO*CK_RATIO-1:0]
                                rd_data_cs_n ;
reg     [CK_RATIO-1:0]          rd_data_ras_n;
reg     [CK_RATIO-1:0]          rd_data_cas_n;
reg     [CK_RATIO-1:0]          rd_data_we_n ;
reg     [CK_RATIO*BANK_WIDTH-1:0]
                                rd_data_ba   ;
reg     [CK_RATIO*ROW_WIDTH-1:0]       
                                rd_data_addr ;
reg                             rd_data_cke_r1;
reg                             mux_odt_r1;
reg                             mux_odt_r2;
reg                             mux_odt_r3;
reg     [WL+1:0]                mux_odt_delay;
reg                             rd_data_cs_n_r1;
reg                             rd_data_ras_n_r1;
reg                             rd_data_cas_n_r1;
reg                             rd_data_we_n_r1;
reg     [BANK_WIDTH-1:0]        rd_data_ba_r1   ;
reg     [ROW_WIDTH-1:0]         rd_data_addr_r1 ;
reg                             ddr_ctl_wren;
reg                             wr_cmd_en;
reg     [1:0]                   mem_dqs_out;
reg     [2*CK_RATIO*DQ_WIDTH-1:0]
                                mem_dq_out   ;
reg     [2*DQ_WIDTH-1:0]        mem_dq_out_r1;
reg     [2*CK_RATIO*DM_WIDTH-1:0]      
                                mem_dm_out   ;
reg     [2*DM_WIDTH-1:0]        mem_dm_out_r1;
reg     [DQ_WIDTH-1:0]          ddr_dq_in_hi_r1;
reg     [DQ_WIDTH-1:0]          ddr_dq_in_hi_r2;
reg     [DQ_WIDTH-1:0]          ddr_dq_in_hi_r3;
reg     [DQ_WIDTH-1:0]          ddr_dq_in_lo_r1;
reg     [DQ_WIDTH-1:0]          ddr_dq_in_lo_r2;
reg     [DQ_WIDTH-1:0]          ddr_dq_in_lo_r3;
reg     [DQS_WIDTH-1:0]         ddr_dqs_in_hi_r1;
reg     [DQS_WIDTH-1:0]         ddr_dqs_in_hi_r2;
reg     [DQS_WIDTH-1:0]         ddr_dqs_in_hi_r3;
reg     [DQS_WIDTH-1:0]         ddr_dqs_in_lo_r1;
reg     [DQS_WIDTH-1:0]         ddr_dqs_in_lo_r2;
reg     [DQS_WIDTH-1:0]         ddr_dqs_in_lo_r3;
reg     [1:0]                   wr_data_cnt;
reg     [2*CK_RATIO-1:0]        rd_dq_ena;
reg     [WL+2:0]                wr_data_en;
reg     [WL+4:0]                wr_ctl_en;
(* async_reg = "true" *)reg     idelay_ld_r1;
(* async_reg = "true" *)reg     idelay_ld_r2;
(* async_reg = "true" *)reg     idelay_ld_r3;
reg                             wrcal_delay;
reg                             rdlvl_check_ena_r1;
reg                             rdlvl_check_ena_r2;
reg                             rdlvl_check_ena_r3;
reg                             rdlvl_check_ena;
reg                             wrlvl_check_ena;
(* async_reg = "true" *)reg     dq_check_en_r1;
(* async_reg = "true" *)reg     dq_check_en_r2;
(* async_reg = "true" *)reg     dq_check_en_r3;
reg                             dq_in_hi_r1;
reg                             dq_in_hi_r2;
reg                             dq_in_lo_r1;
reg                             dq_in_lo_r2;
reg     [1:0]                   dq_bit_sample_cnt;
reg     [DQS_WIDTH-1:0]         dqs_sample_err;
(* async_reg = "true" *)reg     ddr_rden_r1;
(* async_reg = "true" *)reg     ddr_rden_r2;
(* async_reg = "true" *)reg     ddr_rden_r3;
reg     [1:0]                   dqs_sample_reslut[DQS_WIDTH-1:0];
(* async_reg = "true" *)reg     ddr_wren_r1;
(* async_reg = "true" *)reg     ddr_wren_r2;
(* async_reg = "true" *)reg     ddr_wren_r3;
(* async_reg = "true" *)reg     ddr_wren_r4;
(* async_reg = "true" *)reg     ddr_wren_r5;
reg     [3:0]                   stable_cnt[DQS_WIDTH-1:0];
reg     [DQS_WIDTH-1:0]         dq_in_hi_or_prev;
reg     [DQS_WIDTH-1:0]         flag_ck_posedge;
reg     [DQS_WIDTH-1:0]         flag_ck_negedge;
reg     [DQS_WIDTH-1:0]         rd_data_edge_detect_r;
reg     [nCL+6:0]               rd_data_en_ctl;
reg                             rd_data_en;
reg                             wl_dqs_out_en ;
reg                             wl_dqs_en     ;
reg                             wl_dqs_en_r1  ;
reg                             wl_dqs_en_r2  ;
//Wire Define
wire                            u1_wrreq_ns;
wire    [CMD_WTH+1:0]           u1_data_ns;
wire                            u1_wrreq;
wire    [CMD_WTH+1:0]           u1_data;
wire                            u1_almfull;
wire                            u1_full;
wire                            u1_progfull;
wire                            u1_empty;
wire                            u1_rdreq;
wire    [CMD_WTH+1:0]           u1_q;
wire                            u2_wrreq_ns;
wire    [31:0]                  u2_data_ns;
wire                            u2_wrreq;
wire    [31:0]                  u2_data;
wire    [31:0]                  u2_q;
wire                            u2_almfull;
wire                            u2_full;
wire                            u2_empty;
wire                            u2_rdreq;
wire                            u3_wrreq;
wire    [2*CK_RATIO*(DQ_WIDTH/8+DQ_WIDTH)-1:0] 
                                u3_data;
wire    [2*CK_RATIO*(DQ_WIDTH/8+DQ_WIDTH)-1:0] 
                                u3_q;
wire                            u3_almfull;
wire                            u3_full;
wire                            u3_empty;
wire                            u3_rdreq;
wire    [2*CK_RATIO*(DQ_WIDTH)-1:0]    
                                u4_q;
wire                            u4_almfull;
wire                            u4_full;
wire                            u4_empty;
wire                            u4_wrreq_temp;
wire                            u4_rdreq;
wire    [2*DQ_WIDTH-1:0]        ddr_dq_data;
wire                            cmd_fifo_afull;
wire                            cmd_fifo_full;
wire                            ctl_fifo_full;
wire                            ctl_fifo_afull;
wire    [CMD_WTH+1:0]           phy_din;
wire    [3:0]                   ddr_cmd;
wire    [2:0]                   phy_cmd;
wire    [5:0]                   phy_data_offset;
wire                            wr_data_en_ns;
wire                            wr_data_en_temp;
wire                            wr_ctl_en_temp;
wire                            dqs_bit_and_hi;
wire                            dqs_bit_and_lo;
wire                            wr_dqs_en0;
wire                            wr_dqs_en1;
wire                            wr_dq_in_en;
wire    [DQ_WIDTH/8-1:0]        dq_in_hi_or;
wire    [DQ_WIDTH/8-1:0]        dq_in_lo_or;
wire    [DQ_WIDTH-1:0]          ddr_dq_out_hi_temp1;
wire    [DQ_WIDTH-1:0]          ddr_dq_out_lo_temp1;
wire    [DM_WIDTH-1:0]          ddr_dm_hi_temp1;
wire    [DM_WIDTH-1:0]          ddr_dm_lo_temp1;
wire    [DQ_WIDTH-1:0]          ddr_dq_out_hi_temp2;
wire    [DQ_WIDTH-1:0]          ddr_dq_out_lo_temp2;
wire    [DM_WIDTH-1:0]          ddr_dm_hi_temp2;
wire    [DM_WIDTH-1:0]          ddr_dm_lo_temp2;
wire    [2*DQ_WIDTH-1:0]        mem_dq_out_r0;
wire    [2*DM_WIDTH-1:0]        mem_dm_out_r0;
wire    [1:0]                   dqs_sample_edge  [DQS_WIDTH-1:0];
wire    [1:0]                   dqs_sample       [DQS_WIDTH-1:0];
wire    [DQS_WIDTH-1:0]         dqs_sample_r     [1:0]          ;
wire    [5:0]                   u1_rdata_cnt;
wire    [5:0]                   u1_wdata_cnt;
wire                            u1_rdreq_temp;
reg     [1:0]                   u2_rd_cmd_cnt;
wire                            u2_rdreq_temp;
wire    [5:0]                   u2_rdata_cnt;
wire    [5:0]                   u2_wdata_cnt;
reg                             rd_ctl_en;
reg     [1:0]                   u1_rd_cmd_cnt;
reg                             rd_cmd_en;
wire    [4:0]                   u1_rddata_count;
wire    [4:0]                   u2_rddata_count;
wire                            ddr_rden;
wire                            ddr_wren;
reg                             ddr_rden_dly;
reg                             ddr_wren_dly;
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
J7HcKAWVeWA4rN7QuvzYvKbewOKwZxsAsjjVNy4NVFivkkEJThguucoREqL1Dpxj
fZXfSkg7aq5ICXk6g+SCqFa4joH/oW8hwnecwWbmTe1cAsRD1auNLNwT/LyUKMSm
HW7Kovsvau7xXNd5/VOZhjSNFgkeM6zNtFYx/3WHP0gbha0MOjJsbtcUJwGYRRdD
KvPGpyM4UlZee2xnAup30KD7jcToQKOPrOOcyWK8yk35s5RUySLclDbMFOTt9xbO
0ikKyxqZXJCHrjcZyb7Ittr+RQBFHCpdC9dEBwFEHR6MDvamLyrgrXdawU7NgZHx
nPYRDiccRBqEr2RwVZM1tg==
`pragma protect key_keyowner="Mentor Graphics Corporation"
`pragma protect key_keyname="MGC-VERIF-SIM-RSA-1"
`pragma protect key_method="rsa"
`pragma protect encoding=(enctype="base64", line_length=64, bytes=128)
`pragma protect key_block
NdOm0VFzVIf7r9TwpXjJeFxsMwbJqzGMxwTrEqVacRuQlAt2aQN6Y+XTe9m+b5AS
GQS6FEe5G6bD8PDz3RsiexzkQg4sG/1e1NOBEv+pzYWVzfQSH3ShUBlKE0a+mqKc
xLqD5k5AKstEV31NI+1gyA4gSAru4Lpvac357Jou2hU=
`pragma protect data_method="aes256-cbc"
`pragma protect encoding=(enctype="base64", line_length=64, bytes=29648)
`pragma protect data_block
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
`pragma protect end_protected
endmodule
