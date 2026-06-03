//***************************************************************/
//   ______   _   _   _                  _            _
//  |  ____| | | (_) | |                | |          | |
//  | |__    | |  _  | |_    ___   ___  | |_    ___  | | __
//  |  __|   | | | | | __|  / _ \ / __| | __|  / _ \ | |/ /
//  | |____  | | | | | |_  |  __/ \__ \ | |_  |  __/ |   <  
//  |______| |_| |_|  \__|  \___| |___/  \__|  \___| |_|\_\
//
// Moudel Name    : ddr_phy_wrlvl.v
// Version        : 1.0
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

module ddr_phy_wrlvl # (
parameter                       TCQ         = 100,
parameter                       DQ_WIDTH    = 64,
parameter                       DRAM_WIDTH  = 8,
parameter                       DQS_WIDTH   = 2
)
(
input                           clk,
input                           rst,
input                           wr_level_start,
input                           write_calib,
input                           wl_sm_start,
input                           dq_bit_sample_ok,

output          [7:0]           wrlvl_dq_check,
output  reg                     dqs_invert ,
output  reg                     dq_check_en ,
output  reg                     wrlvl_rank_done ,
output  reg                     wr_level_done ,
output  reg                     wrlvl_shift_ena,  
output  reg     [2:0]           wrlvl_phise_shift,
output  reg     [2:0]           wrlvl_shift
   );

//Parameter Define
localparam              PHISE_TAPS     = 8;
localparam              PLL_SHIFT_NUM  = 4;
localparam              WL_DQS_NUM     = 16;
localparam              PLL_BLANK_NUM  = 64;

localparam              PLL_SHIFT_WTH  = clogb2(PLL_SHIFT_NUM); 
localparam              WL_DQS_WTH     = clogb2(WL_DQS_NUM); 
localparam              TAP_WTH        = clogb2(PHISE_TAPS);
localparam              BLANK_NUM_WTH  = clogb2(PLL_BLANK_NUM);
 
localparam              IDLE           = 3'h0;
localparam              WLDQSEN_WAIT   = 3'h1;
localparam              DQS_WAIT       = 3'h2;
localparam              WL_EADG_CHECK  = 3'h3;
localparam              PLL_SHIFT      = 3'h4;
localparam              SEND_DQS_INC   = 3'h5;
localparam              SEND_DQS_INVERT= 3'h6;
localparam              DQ_CHECK_DONE  = 3'h7;

//Register Define
reg     [2:0]                   cur_state;
reg     [2:0]                   next_state;  
reg     [WL_DQS_WTH-1:0]        wrlvl_check_cnt;
reg     [PLL_SHIFT_WTH-1:0]     pll_shift_cnt;
reg     [2:0]                   wr_level_shift_cnt;
reg     [BLANK_NUM_WTH-1:0]     pll_blank_cnt;
(* async_reg = "true" *)reg                             dq_bit_ok_r1;
reg                             dq_bit_ok_r2;
reg                             dq_bit_ok_r3;
reg     [7:0]                   dq_dynmic_shift;
reg                             check_err;
reg                             check_err_r;
reg     [TAP_WTH-1:0]           rising_tap;
reg                             rising_tap_vld;
reg     [TAP_WTH-1:0]           next_rising_tap;
reg                             next_rising_tap_vld;
reg     [TAP_WTH-1:0]           first_rising_tap;
reg                             first_rising_tap_vld;
reg     [TAP_WTH-1:0]           failling_tap;
reg                             failling_tap_vld;
reg     [TAP_WTH-1:0]           next_failling_tap;
reg                             next_failling_tap_vld;
reg                             replace_flag;
reg     [TAP_WTH-1:0]           calibrate_tap;
reg                             last_flag;
reg                             clean_flag;
reg     [3:0]                   check_err_cnt;
reg                             dqs_invert_r1;
reg                             dqs_invert_r2;

//Wire Define
wire    [TAP_WTH-1:0]           calibrate_1tmp;
wire    [TAP_WTH-1:0]           calibrate_2tmp;
wire    [TAP_WTH-1:0]           calibrate_3tmp;
wire                            case_1tmp;
wire                            case_2tmp;
wire                            case_3tmp;
wire    [TAP_WTH-1:0]           tap_cnt;  
wire                            dqs_invert_edge;
//wire    [7:0]                 check_debug = 8'b01111111;
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
aNIPWctk2hBjVa2unCUevzEhRym0pWc6RoFllyJGy7m1ViViWP/hdhU6ZuJ9XcEY
KlZvJj1N6F4Fj0g5K+qPoEyGgSFigkjK1uVQGgElSWEpY0Gk4mwUiNjCHpBNlHri
UoEgu4QjFDvTi3BezcXQy5TxHI5+JywixtSdtfWf8+cl82zJE4WqswH71z9X3Yt9
qQgUo42RsNW1q51TL+ARfwBrAcrcdFnC1IvxdNqTg+I4pHbIE92yk9tXRT7bPH1J
1ZxFt3Ma1FFOqdlidNVk0bW+cVXIVjhc0l5Z/ja3/Muj7xAzH14k6Uln2iuAwemq
sXBi/ReRuEsPAzKF7ClLsA==
`pragma protect key_keyowner="Mentor Graphics Corporation"
`pragma protect key_keyname="MGC-VERIF-SIM-RSA-1"
`pragma protect key_method="rsa"
`pragma protect encoding=(enctype="base64", line_length=64, bytes=128)
`pragma protect key_block
ipcuHTU5SCy+J/veXAH+YDpoMaYvtlCMUPIxg5HClyv/giMGC8Zp/lLKZcvlxZS6
bwsRWZ3WO1f0HrncKrClZfp1nUXscKmmIlc5et3hTcvoq9OqrZ0jdNZKxbbdOX/1
uJBCytBexhdlJJTZFtyuWg5Uel6kyHsilNwrXc2k8Gk=
`pragma protect data_method="aes256-cbc"
`pragma protect encoding=(enctype="base64", line_length=64, bytes=15504)
`pragma protect data_block
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
`pragma protect end_protected
endmodule
