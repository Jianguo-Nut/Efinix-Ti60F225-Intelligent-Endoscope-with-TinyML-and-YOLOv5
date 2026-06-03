//***************************************************************/
//   ______   _   _   _                  _            _
//  |  ____| | | (_) | |                | |          | |
//  | |__    | |  _  | |_    ___   ___  | |_    ___  | | __
//  |  __|   | | | | | __|  / _ \ / __| | __|  / _ \ | |/ /
//  | |____  | | | | | |_  |  __/ \__ \ | |_  |  __/ |   <  
//  |______| |_| |_|  \__|  \___| |___/  \__|  \___| |_|\_\
//
// Moudel Name    : ui_wrapper.v
// Version        : 1.1
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

module local_bus_ctl #(
parameter                       TCQ        = 100,
parameter                       CK_RATIO   = 2, 
parameter                       USER_DW    = 256,
parameter                       USER_MW    = 32,
parameter                       BANK_WIDTH = 3,
parameter                       COL_WIDTH  = 12,
parameter                       CWL        = 5,
parameter                       BUF_AW     = 5,
parameter                       RANKS      = 4,
parameter                       RANK_WIDTH = 2,
parameter                       ROW_WIDTH  = 16,
parameter                       ADDR_WIDTH = RANK_WIDTH + BANK_WIDTH + ROW_WIDTH + COL_WIDTH,
parameter                       MEM_ADDR_ORDER = "BANK_ROW_COLUMN"
)
(

input                           clk, 
input                           rst,   
input                           mc_user_en,  
input           [2:0]           mc_user_cmd,
input           [ADDR_WIDTH-1:0]mc_user_addr, 
output                          mc_user_ready, 

input                           mc_user_wren,   
input           [USER_DW-1:0]   mc_user_wdata,
input           [USER_MW-1:0]   mc_user_mask,
input                           mc_user_end,                                 
output                          mc_user_wrdy,  
   
output reg      [USER_DW-1:0]   mc_user_rd_data,      
output reg                      mc_user_rd_end,       
output reg                      mc_user_rd_valid,      

input           [BUF_AW-1:0]    wr_data_addr, 
input                           wr_data_en,             
input                           wr_data_offset,           
output reg      [USER_DW-1:0]   wr_data,          
output reg      [USER_MW-1:0]   wr_data_mask,     
input           [USER_DW-1:0]   rd_data,           
input           [BUF_AW-1:0]    rd_data_addr, 
input                           rd_data_en,             
input                           rd_data_end,            
input                           rd_data_offset,  

output          [BANK_WIDTH-1:0]mc_bank,                 
output          [2:0]           mc_cmd,                    
output          [COL_WIDTH-1:0] mc_col,                   
output          [BUF_AW-1:0]    mc_data_buf_addr,

output          [RANK_WIDTH-1:0]mc_rank,                           
output          [ROW_WIDTH-1:0] mc_row,                                   
output                          mc_use_addr,  
input                           accept_ns             

  );
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
LWOhEPrS52Njlulcf+oWv9CnVGBo2/9EM4CV900rDxrVNC0w8n/BLuQfMxHbpfir
Lai4uVrrJp4nOB39LbnG82s84A/BMFaifHYXbdUqIgjB5SAgUUiy04AbOrlxIgPN
KDzVfDASnwgYMZvy8wUzKLRhxQGPVhsSRqASQ9RPRV1BId76TMXlj4z9XSXCMsDp
o/Pd13gFQfnFBx+mA2HLu9Jhz135oG73KAL3mdOBcUtb6LYKsqqLeNucVsULpGFI
Yj6XtTn0YdO0k4P/aLBx6eGUxij+xyfYjv7/bmh6hcsH0iCUHm5LHetllxOdPGi6
Y6uGYSwu0azx0eHJVdU2BA==
`pragma protect key_keyowner="Mentor Graphics Corporation"
`pragma protect key_keyname="MGC-VERIF-SIM-RSA-1"
`pragma protect key_method="rsa"
`pragma protect encoding=(enctype="base64", line_length=64, bytes=128)
`pragma protect key_block
P1/93oz47T3S8egJFmckQw3iP7tI5AKgbVC1y8BKRohwqEGTUIlSfaynOOkFjtwo
4E1Myb85kYoQKst2tElUGqxAqGrYZCiDJhiVjIDGfMilLC+J8UaCw3TxRwozWVj/
IgivtW3385ZgCC8ZyMAgD+EvCG/pQOcN/daSACDCU+Y=
`pragma protect data_method="aes256-cbc"
`pragma protect encoding=(enctype="base64", line_length=64, bytes=8736)
`pragma protect data_block
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
`pragma protect end_protected
endmodule
