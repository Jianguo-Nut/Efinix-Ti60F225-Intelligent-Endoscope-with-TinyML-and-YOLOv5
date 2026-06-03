//***************************************************************/
//   ______   _   _   _                  _            _
//  |  ____| | | (_) | |                | |          | |
//  | |__    | |  _  | |_    ___   ___  | |_    ___  | | __
//  |  __|   | | | | | __|  / _ \ / __| | __|  / _ \ | |/ /
//  | |____  | | | | | |_  |  __/ \__ \ | |_  |  __/ |   <  
//  |______| |_| |_|  \__|  \___| |___/  \__|  \___| |_|\_\
//
// Moudel Name    : ddr_phy_rdlvl_dqs.v
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

module ddr_phy_rdlvl_dqs #(
parameter                       TCQ             = 100,
parameter                       DQS_CHECK_TIME  = 512,
parameter                       DQS_CNT_WIDTH   = 3,
parameter                       DQS_WIDTH       = 2
)
(
input                           clk,
input                           rst,
input                           rd_dqs_start,
input           [1:0]           dqs_bit_sample_err,

output          [7:0]           rd_level_dqs_check,
output  reg                     rdlvl_dqs_check_ena,
output  reg                     rd_level_dqs_done,
output  reg                     rdlvl_all_dqs_done,
output  reg                     rdlvl_dqs_shift_ena,
output  reg     [2:0]           rdlvl_dqs_phise_shift,
output  reg     [2:0]           rdlvl_shift
);

//Parameter Define
localparam              PHISE_TAPS     = 8;
localparam              PLL_SHIFT_NUM  = 4;
localparam              WIAT_CNT       = 25;
localparam              PLL_BLANK_NUM  = 64;
localparam              TAP_WTH        = clogb2(PHISE_TAPS);
localparam              WIAT_WTH       = clogb2(WIAT_CNT);
localparam              DQS_CHECK_WTH  = clogb2(DQS_CHECK_TIME); 
localparam              PLL_SHIFT_WTH  = clogb2(PLL_SHIFT_NUM); 
localparam              BLANK_NUM_WTH  = clogb2(PLL_BLANK_NUM);
            
localparam              IDLE           = 3'h0;
localparam              RD_DQS_WAIT    = 3'h1;
localparam              RD_DQS_CHECK   = 3'h2;
localparam              PLL_SHIFT      = 3'h3;
localparam              RD_DQS_LOOP    = 3'h4;
localparam              PLL_BLANK      = 3'h5;
localparam              DQS_CHECK_DONE = 3'h6;

//Register Define
reg     [2:0]                   cur_state;
reg     [2:0]                   next_state;
(* async_reg = "true" *)reg     [1:0]                   dqs_bit_sample_r1;
reg     [1:0]                   dqs_bit_sample_r2;
reg     [1:0]                   dqs_bit_sample_r3;
reg     [1:0]                   dqs_bit_sample_r4;
reg     [WIAT_WTH-1:0]          wait_cnt;
reg     [DQS_CHECK_WTH-1:0]     rd_level_dqs_cnt;
reg     [PLL_SHIFT_WTH-1:0]     pll_shift_cnt;
reg     [TAP_WTH-1:0]           rd_level_shift_cnt;
reg     [BLANK_NUM_WTH-1:0]     pll_blank_cnt;
reg     [PHISE_TAPS-1:0]        dqs_dynmic_shift;
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
//Wire Define
wire    [TAP_WTH-1:0]           calibrate_1tmp;
wire    [TAP_WTH-1:0]           calibrate_2tmp;
wire    [TAP_WTH-1:0]           calibrate_3tmp;
wire                            case_1tmp;
wire                            case_2tmp;
wire                            case_3tmp;
wire    [TAP_WTH-1:0]           tap_cnt;  

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
iNBg9sfMzWIFbe/9dswn8C/l+Ix2U6ECNI9zzwcaKLcwclOkBQM1BnPVyPrCmd/7
4UmTqTok2rI/EuofRrPJ9I4XeKUePaD+nsJRfHQrUHNA+EfjEaBLb/q1sCrQSq83
WEHVL41y8pHwKzocePC26QEDNs0APgVS2Wdsz8iNPiW3rAtpNl1jmpA4lTy5BEQx
BVfvs/s/6iT0sTylnTiyhSJpoLBTPDuRjRoSYq6VCI8hWKanyTJyZc7+Qmv1tMQH
v5+HsbF+B23Eh3VdGgDeFdLm6x8K3lYmBkwu9nbl4rlJV71O21jSkEMtHSy359B2
IMFZ77ti6n01tnJ12+PTJw==
`pragma protect key_keyowner="Mentor Graphics Corporation"
`pragma protect key_keyname="MGC-VERIF-SIM-RSA-1"
`pragma protect key_method="rsa"
`pragma protect encoding=(enctype="base64", line_length=64, bytes=128)
`pragma protect key_block
B72u9vUPQjyBkfXR/WljZbDcOWXQMrhjyMyOmVzL//bcUQhnh4Z0/UY2FMdoxuV5
yLXopPEg14nCzngL1dnvbG9WoT0jnxeOY1phhN1nFrk/iq2Zi+hqcPyaYY8ZapWb
KiINxrjXJkVJPhC635FC9NNw+sEELpXecayPxi0inbY=
`pragma protect data_method="aes256-cbc"
`pragma protect encoding=(enctype="base64", line_length=64, bytes=13728)
`pragma protect data_block
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
`pragma protect end_protected
endmodule
