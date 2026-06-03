//***************************************************************/
//   ______   _   _   _                  _            _
//  |  ____| | | (_) | |                | |          | |
//  | |__    | |  _  | |_    ___   ___  | |_    ___  | | __
//  |  __|   | | | | | __|  / _ \ / __| | __|  / _ \ | |/ /
//  | |____  | | | | | |_  |  __/ \__ \ | |_  |  __/ |   <  
//  |______| |_| |_|  \__|  \___| |___/  \__|  \___| |_|\_\
//
// Moudel Name    : lb2_axi_clk.v
// Version        : 1.1
// Date Created   : 2023-04-23 10:37:59
// Last Modified  : 2023-04-23 10:37:59
// Abstract       : ---
//
//Copyright (c) 2020-2023 Elitestek,Inc. All Rights Reserved.
//
//***************************************************************/
//Modification History
//1.initial
//***************************************************************/


module lb2_axi_clk #(
parameter                       USER_DW    = 256,
parameter                       USER_MW    = 32,
parameter                       BANK_WIDTH = 3,
parameter                       COL_WIDTH  = 12,
parameter                       RANK_WIDTH = 2,
parameter                       ROW_WIDTH  = 16,
parameter                       ADDR_WIDTH = RANK_WIDTH + BANK_WIDTH + ROW_WIDTH + COL_WIDTH
)
(
input                           axi_clk, 
input                           core_clk, 
input                           rstn,   
input                           axi_rstn,   
input                           axi_user_en,  
input           [2:0]           axi_user_cmd,
input           [ADDR_WIDTH-1:0]axi_user_addr, 
output                          axi_user_ready, 

input                           axi_user_wren,   
input           [USER_DW-1:0]   axi_user_wdata,
input           [USER_MW-1:0]   axi_user_mask,
input                           axi_user_end,                                 
output                          axi_user_wrdy,  
   
output          [USER_DW-1:0]   axi_user_rd_data,      
output                          axi_user_rd_end,       
output                          axi_user_rd_valid, 

//----------------local bus----------------//
output                          lb_user_en,  
output          [2:0]           lb_user_cmd,
output          [ADDR_WIDTH-1:0]lb_user_addr, 
input                           lb_user_ready, 

output                          lb_user_wren,   
output          [USER_DW-1:0]   lb_user_wdata,
output          [USER_MW-1:0]   lb_user_mask,
output                          lb_user_end,                                 
input                           lb_user_wrdy,  
   
input           [USER_DW-1:0]   lb_user_rd_data,      
input                           lb_user_rd_end,       
input                           lb_user_rd_valid

);
//Parameter Define

//Register Define


//Wire Define
wire                            u1_wrreq;
wire    [ADDR_WIDTH+2:0]        u1_data;
wire                            u1_almfull;
wire                            u1_full;
wire                            u1_progfull;
wire                            u1_empty;
wire                            u1_rdreq;
wire    [ADDR_WIDTH+2:0]        u1_q;

wire                            u2_wrreq;
wire    [USER_DW+USER_MW:0]     u2_data;
wire    [USER_DW+USER_MW:0]     u2_q;
wire                            u2_almfull;
wire                            u2_full;
wire                            u2_empty;
wire                            u2_rdreq;

wire                            u3_wrreq;
wire    [USER_DW:0]             u3_data;
wire    [USER_DW:0]             u3_q;
wire                            u3_almfull;
wire                            u3_full;
wire                            u3_empty;
wire                            u3_rdreq;
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
lhn6ntLUyvTmmoDO3R/dIlE6Kdts1Lz0rZBrSZ/WcpZwRYXH1mnbb1xyksrsc9F0
s2hfu7KvdPGjEQKkpqxnUVv/9BP3Q+ZiUhhdLm71xsVSp3AhjvNwP70Ntf/RxMpc
fOvahN6R21HbQWCsh0O7PGUoiSAX3QOXlv9Gn6Cv3ev8dmbRw7v29T6Z3fvQlkQC
gjc4VwUVIMnXAfZeMVPVvs4P70347TlSIFYvdRssQjDvFUmiDAtijE+wS0z/DwYB
ezcwDo+ChYMY8QP0x/In1VbKDqNy3DXUsfrO+SoZZb7iVmNPKnTf2ae/ZdkFo4HS
jpMs+mOd8C7MT/R8aCY2iA==
`pragma protect key_keyowner="Mentor Graphics Corporation"
`pragma protect key_keyname="MGC-VERIF-SIM-RSA-1"
`pragma protect key_method="rsa"
`pragma protect encoding=(enctype="base64", line_length=64, bytes=128)
`pragma protect key_block
NPmOAqw9nP/EbrneGLFyBHadui4Li5krYikD4Ga3u0RhJxJCOkOKjL02TOFvKhCv
c5CuXOWDXqzrEFzlMbRc4xVuV6B4Fl/Yc63k+SQBr7j4DaXtERnJFN8eLF476tbb
B+yfg5mIEZfI6NgYtOFRo8G39EM4oZJUfx5Ts/AKTqI=
`pragma protect data_method="aes256-cbc"
`pragma protect encoding=(enctype="base64", line_length=64, bytes=8032)
`pragma protect data_block
+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
IOYKuO9WBRDCcN5louF4yg==
`pragma protect end_protected
endmodule



