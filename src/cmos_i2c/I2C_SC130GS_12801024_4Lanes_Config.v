/*-------------------------------------------------------------------------
This confidential and proprietary software may be only used as authorized
by a licensing agreement from CrazyBingo.www.cnblogs.com/crazybingo
(C) COPYRIGHT 2012 CrazyBingo. ALL RIGHTS RESERVED
Filename            :       I2C_SC130GS_12801024_Config.v
Author              :       CrazyBingo
Date                :       2019-08-03
Version             :       1.0
Description         :       I2C Configure Data of AR0135.
Modification History    :
Date            By          Version         Change Description
===========================================================================
19/08/03        CrazyBingo  1.0             Original
--------------------------------------------------------------------------*/

`timescale 1ns/1ns
module  I2C_SC130GS_12801024_4Lanes_Config  //1280*1024@60 with AutO/Manual Exposure
(
    input       [7:0]   LUT_INDEX,
    output  reg [23:0]  LUT_DATA,
    output      [7:0]   LUT_SIZE
);
assign  LUT_SIZE = 16;
// assign  LUT_SIZE = 46;

//-----------------------------------------------------------------
/////////////////////   Config Data LUT   //////////////////////////    
always@(*)
begin
    case(LUT_INDEX)
    0	:	LUT_DATA =		{16'h358B, 8'h0A};
    1	:	LUT_DATA =		{16'h356F, 8'h03};
    2	:	LUT_DATA =		{16'h36DA, 8'h02};
    3	:	LUT_DATA =		{16'h38dc, 8'h00};
    4	:	LUT_DATA =		{16'h38ca, 8'h01};
    5	:	LUT_DATA =		{16'h36d8, 8'h06};
    6	:	LUT_DATA =		{16'h36d9, 8'h06};
    7	:	LUT_DATA =		{16'h3169, 8'h00}; 
    8	:	LUT_DATA =		{16'h38a8, 8'h03};
    9	:	LUT_DATA =		{16'h38a9, 8'h1b};
    10	:	LUT_DATA =		{16'h38ea, 8'h01};
    11	:	LUT_DATA =		{16'h3000,8'h00}; //streaming
    12	:	LUT_DATA =		{16'h304a, 8'h00};//**************
    13	:	LUT_DATA =		{16'h3049, 8'h00};// exposure control , must be Even
    14	:	LUT_DATA =		{16'h3048, 8'h08};//**************
    15	:	LUT_DATA =		{16'h3110, 8'h20};//** gain
    
// 0:	LUT_DATA = {16'h301C, 8'h98}; 
// 1:	LUT_DATA = {16'h301D, 8'h08}; 
// 2:	LUT_DATA = {16'h301E, 8'h00}; 
// 3:	LUT_DATA = {16'h3020, 8'h32}; 
// 4:	LUT_DATA = {16'h3021, 8'h03}; 
// 5:	LUT_DATA = {16'h303C, 8'h04}; 
// 6:	LUT_DATA = {16'h303D, 8'h00}; 
// 7:	LUT_DATA = {16'h303E, 8'hC8}; 
// 8:	LUT_DATA = {16'h303F, 8'h03}; 
// 9:	LUT_DATA = {16'h3060, 8'h01}; 
// 10:	LUT_DATA = {16'h3418, 8'h67}; 
// 11:	LUT_DATA = {16'h3419, 8'h00}; 
// 12:	LUT_DATA = {16'h341A, 8'h2F}; 
// 13:	LUT_DATA = {16'h341B, 8'h00}; 
// 14:	LUT_DATA = {16'h341C, 8'h27}; 
// 15:	LUT_DATA = {16'h341D, 8'h00}; 
// 16:	LUT_DATA = {16'h341E, 8'h97}; 
// 17:	LUT_DATA = {16'h341F, 8'h00}; 
// 18:	LUT_DATA = {16'h3420, 8'h2F}; 
// 19:	LUT_DATA = {16'h3421, 8'h00}; 
// 20:	LUT_DATA = {16'h3422, 8'h3F}; 
// 21:	LUT_DATA = {16'h3423, 8'h00}; 
// 22:	LUT_DATA = {16'h3424, 8'h27}; 
// 23:	LUT_DATA = {16'h3425, 8'h00}; 
// 24:	LUT_DATA = {16'h3426, 8'h3F}; 
// 25:	LUT_DATA = {16'h3427, 8'h00}; 
// 26:	LUT_DATA = {16'h3428, 8'h1F}; 
// 27:	LUT_DATA = {16'h3429, 8'h00}; 
// 28:	LUT_DATA = {16'h3442, 8'h00}; 
// 29:	LUT_DATA = {16'h366E, 8'h01}; 
// 30:	LUT_DATA = {16'h3808, 8'h2d}; 
// 31:	LUT_DATA = {16'h3826, 8'h01}; 
// 32:	LUT_DATA = {16'h358B, 8'h0A}; 
// 33:	LUT_DATA = {16'h356F, 8'h03}; 
// 34:	LUT_DATA = {16'h36DA, 8'h02}; 
// 35:	LUT_DATA = {16'h38dc, 8'h00}; 
// 36:	LUT_DATA = {16'h38ca, 8'h01}; 
// 37:	LUT_DATA = {16'h36d8, 8'h06}; 
// 38:	LUT_DATA = {16'h36d9, 8'h06}; 
// 39:	LUT_DATA = {16'h3169, 8'h00 }; 
// 40:	LUT_DATA = {16'h38a8, 8'h03}; 
// 41:	LUT_DATA = {16'h38a9, 8'h1b}; 
// 42:	LUT_DATA = {16'h38ea, 8'h01}; 
// 43:	LUT_DATA = {16'h3000 ,8'h00 };//Streaming}; 
// 44:	LUT_DATA = {16'h3049 ,8'h00 }; 
// 45:	LUT_DATA = {16'h3048, 8'h10}; 


		default:LUT_DATA    =   {16'h0000, 8'h00};
    endcase
end

endmodule
