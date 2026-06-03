//***************************************************************/
//   ______   _   _   _                  _            _
//  |  ____| | | (_) | |                | |          | |
//  | |__    | |  _  | |_    ___   ___  | |_    ___  | | __
//  |  __|   | | | | | __|  / _ \ / __| | __|  / _ \ | |/ /
//  | |____  | | | | | |_  |  __/ \__ \ | |_  |  __/ |   <  
//  |______| |_| |_|  \__|  \___| |___/  \__|  \___| |_|\_\
//
// Moudel Name    : ddr_mpr_rdlvl.v
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
module ddr_mpr_rdlvl # (
parameter                       TCQ               = 100,
parameter                       DQS_CNT_WIDTH     = 3,
parameter                       CK_RATIO          = 4,
parameter                       DRAM_WIDTH        = 8,      // # of DQ per DQS
parameter                       DQ_WIDTH          = 64,
parameter                       DQS_WIDTH         = 2
)
(
input                           clk,
input                           rst,
input                           mpr_rdlvl_en,

input                           phy_rddata_valid,
input           [2*CK_RATIO*DQ_WIDTH-1:0]     
                                phy_rd_data,
output  reg                     mpr_rdlvl_dly

);
//Parameter Define

//Register Define
reg     [DRAM_WIDTH-1:0]        mux_rd_fall0_r;
reg     [DRAM_WIDTH-1:0]        mux_rd_fall1_r;
reg     [DRAM_WIDTH-1:0]        mux_rd_rise0_r;
reg     [DRAM_WIDTH-1:0]        mux_rd_rise1_r;
reg     [DRAM_WIDTH-1:0]        mux_rd_fall2_r;
reg     [DRAM_WIDTH-1:0]        mux_rd_fall3_r;
reg     [DRAM_WIDTH-1:0]        mux_rd_rise2_r;
reg     [DRAM_WIDTH-1:0]        mux_rd_rise3_r;
reg                             mpr_rd_rise0_prev_r;
reg                             mpr_rd_fall0_prev_r;
reg                             mpr_rd_rise1_prev_r;
reg                             mpr_rd_fall1_prev_r;
reg                             mpr_rd_rise2_prev_r;
reg                             mpr_rd_fall2_prev_r;
reg                             mpr_rd_rise3_prev_r;
reg                             mpr_rd_fall3_prev_r;
reg                             rd_active_r;
reg                             rd_active_r1;
reg                             rd_active_r2;
reg                             rd_active_r3;
reg                             rd_active_r4;
reg                             rd_active_r5;
reg     [3:0]                   mpr_rdlvl_cnt;
reg     [2:0]                   stable_idel_cnt;
reg                             inhibit_edge_detect_r;
reg                             idel_mpr_pat_detect_r;

//Wire Define   
wire    [DQ_WIDTH-1:0]          rd_data_rise0;
wire    [DQ_WIDTH-1:0]          rd_data_fall0;
wire    [DQ_WIDTH-1:0]          rd_data_rise1;
wire    [DQ_WIDTH-1:0]          rd_data_fall1;
wire    [DQ_WIDTH-1:0]          rd_data_rise2;
wire    [DQ_WIDTH-1:0]          rd_data_fall2;
wire    [DQ_WIDTH-1:0]          rd_data_rise3;
wire    [DQ_WIDTH-1:0]          rd_data_fall3;
wire    [DQS_CNT_WIDTH:0]       rd_mux_sel_r;

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
PUIG1DxkLUnm/ZQNIqINu486C7As0wQjoO/kdqJWvzkE8IocCpZKWFFcgPhrfYj9
ByKODVJvxnUZy6TwPDysyeN6KmEeSILnRowrebUkh2DHlYpXdRddr3HhOSch/WtD
2dDYXFCDS71JIssULv/czBK9fU1eGC4YMxPimH7YYo05uAVfQIPkBNwTEFKdS45a
Qg77axZ994Px1Kv9gLVWFwQWR/cpOVPCjlJEoYhj9OJeantljhUwCwkLZBO4P8AA
EsWjCWF/snxpCRLEpLQdGIwWHXixo4Pb3eu7zY+dyaXZNxgNd2WykWukcZUEzEcs
2dBXHfO0FVuopvfPKJVpjA==
`pragma protect key_keyowner="Mentor Graphics Corporation"
`pragma protect key_keyname="MGC-VERIF-SIM-RSA-1"
`pragma protect key_method="rsa"
`pragma protect encoding=(enctype="base64", line_length=64, bytes=128)
`pragma protect key_block
fNWUGrZVL2nEbHOSyAn0YXsadoK2I31NxNmMR0v37BQE+P9LJFHrJFQ9rygFNDHA
tLns4ZCgybNTCHIVKoSk2Y1uEaT8iwGzmxLamjgIF/LuqIZy8oexiXH8Xm5qYuAK
VwZ51Gdeq/1hvRl8KWg39xt13ZHCOoGnDZZRr603doM=
`pragma protect data_method="aes256-cbc"
`pragma protect encoding=(enctype="base64", line_length=64, bytes=9408)
`pragma protect data_block
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
`pragma protect end_protected
endmodule
