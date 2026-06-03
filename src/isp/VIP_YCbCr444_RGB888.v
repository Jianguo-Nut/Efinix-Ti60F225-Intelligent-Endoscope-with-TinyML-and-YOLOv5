/*-----------------------------------------------------------------------
                                 \\\|///
                               \\  - -  //
                                (  @ @  )
+-----------------------------oOOo-(_)-oOOo-----------------------------+
CONFIDENTIAL IN CONFIDENCE
This confidential and proprietary software may be only used as authorized
by a licensing agreement from CrazyBingo (Thereturnofbingo).
In the event of publication, the following notice is applicable:
Copyright (C) 2011-20xx CrazyBingo Corporation
The entire notice above must be reproduced on all authorized copies.
Author              :       CrazyBingo
Technology blogs    :       www.crazyfpga.com
Email Address       :       crazyfpga@qq.com
Filename            :       RGB2YCbCr_Convert.v
Date                :       2013-05-26
Description         :       Convert the RGB888 format to YCbCr444 format.
Modification History    :
Date            By          Version         Change Description
=========================================================================
13/05/26        CrazyBingo  1.0             Original
14/03/16        CrazyBingo  2.0             Modification
-------------------------------------------------------------------------
|                                     Oooo                              |
+-------------------------------oooO--(   )-----------------------------+
                               (   )   ) /
                                \ (   (_/
                                 \_)
-----------------------------------------------------------------------*/ 

`timescale 1ns/1ns
module VIP_YCbCr444_RGB888
(
    //global clock
    input               clk,                //cmos video pixel clock
    input               rst_n,              //global reset
        //Image data has been processed
    input              per_img_vsync,     //Processed Image data vsync valid signal
    input              per_img_href,      //Processed Image data href vaild signal
    input      [7:0]   per_img_Y,         //Processed Image brightness output
    input      [7:0]   per_img_Cb,        //Processed Image blue shading output
    input      [7:0]   per_img_Cr,         //Processed Image red shading output


    //Image data prepred to be processed
    output               post_img_vsync,      //Prepared Image data vsync valid signal
    output               post_img_href,       //Prepared Image data href vaild signal
    output       [7:0]   post_img_red,        //Prepared Image red data to be processed
    output       [7:0]   post_img_green,      //Prepared Image green data to be processed
    output       [7:0]   post_img_blue       //Prepared Image blue data to be processed
    

);

//--------------------------------------------
/*********************************************
//Refer to full/pc range YCbCr to RGB conversion
    Alternatively, we can precompute the offset terms:
    Let Cb_offset = Cb - 128
    Let Cr_offset = Cr - 128
    
    Then:
    R = Y + (359 * Cr_offset) >> 8
    G = Y - ( (88 * Cb_offset + 183 * Cr_offset) ) >> 8
    B = Y + (454 * Cb_offset) >> 8
**********************************************/

// Step 1: Calculate Cb and Cr offsets
reg signed [8:0] Cb_offset, Cr_offset;
always@(posedge clk) begin
    Cb_offset <= {1'b0, per_img_Cb} - 9'd128;
    Cr_offset <= {1'b0, per_img_Cr} - 9'd128;
end

// Step 2: Multiply offsets with coefficients
reg signed [17:0] R_temp1, G_temp1, G_temp2, B_temp1;
always@(posedge clk) begin
    R_temp1 <= 359 * $signed({{9{Cr_offset[8]}}, Cr_offset}); // Sign extend to 18 bits
    G_temp1 <= 88 * $signed({{9{Cb_offset[8]}}, Cb_offset});
    G_temp2 <= 183 * $signed({{9{Cr_offset[8]}}, Cr_offset});
    B_temp1 <= 454 * $signed({{9{Cb_offset[8]}}, Cb_offset});
end

// Step 3: Calculate intermediate RGB values
reg signed [17:0] R_temp2, G_temp3, B_temp2;
reg [7:0] Y_delay1;
always@(posedge clk) begin
    Y_delay1 <= per_img_Y;
    R_temp2 <= (Y_delay1 << 8) + R_temp1; // Y*256 + R_temp1
    G_temp3 <= (Y_delay1 << 8) - G_temp1 - G_temp2; // Y*256 - G_temp1 - G_temp2
    B_temp2 <= (Y_delay1 << 8) + B_temp1; // Y*256 + B_temp1
end

// Step 4: Final RGB calculation with clipping
reg [7:0] R_final, G_final, B_final;
always@(posedge clk) begin
    // Clip R value to 0-255 range
    if (R_temp2[17]) // Negative
        R_final <= 8'd0;
    else if (R_temp2[16:8] > 9'd255) // Overflow
        R_final <= 8'd255;
    else
        R_final <= R_temp2[15:8];
    
    // Clip G value to 0-255 range
    if (G_temp3[17]) // Negative
        G_final <= 8'd0;
    else if (G_temp3[16:8] > 9'd255) // Overflow
        G_final <= 8'd255;
    else
        G_final <= G_temp3[15:8];
    
    // Clip B value to 0-255 range
    if (B_temp2[17]) // Negative
        B_final <= 8'd0;
    else if (B_temp2[16:8] > 9'd255) // Overflow
        B_final <= 8'd255;
    else
        B_final <= B_temp2[15:8];
end


reg [3:0] per_img_vsync_r;
reg [3:0] per_img_href_r;   
always@(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        per_img_vsync_r <= 0;
        per_img_href_r <= 0;
    end else begin
        per_img_vsync_r <= {per_img_vsync_r[2:0], per_img_vsync};
        per_img_href_r <= {per_img_href_r[2:0], per_img_href};
    end
end

assign post_img_vsync = per_img_vsync_r[3];
assign post_img_href = per_img_href_r[3];
assign post_img_red = post_img_href ? R_final : 8'd0;
assign post_img_green = post_img_href ? G_final : 8'd0;
assign post_img_blue = post_img_href ? B_final : 8'd0;

endmodule


