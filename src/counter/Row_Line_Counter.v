

`timescale 1ns/1ps
module Row_Line_Counter

(
    //global clock
    input               Data_clk,                //cmos video pixel clock
    input               Data_rst_n,              //global reset
    

    //input data
    input               Data_vsync,    //Prepared Image data vsync valid signal
    input               Data_hsync, 
    input               Data_valid,     //Prepared Image data href vaild  signal

    
    //counter out
    output reg  [10:0]   cnt_pixel,       //Prepared Image green data to be processed 
    output reg  [10:0]   cnt_row     //Prepared Image green data to be processed
);

// =========================================================================================================================================
// RC Counter
// ========================================================================================================================================= 
wire                                    w_csi_rx_clk= Data_clk     ;
wire                                    w_sys_rstn = Data_rst_n    ;
wire                                    w_csi_rx_vsync0 = Data_vsync;
wire                                    w_csi_rx_hsync0 = Data_hsync;
wire                                    w_csi_rx_dvalid = Data_valid;


reg   r_original_signal;  
always @(posedge w_csi_rx_clk) begin
    r_original_signal <= w_csi_rx_hsync0;
end
wire                             rise_edge ;
assign rise_edge = 1   ? w_csi_rx_hsync0   & ~r_original_signal : 1'b0;
wire                             fall_edge ;
assign fall_edge = 1   ? ~w_csi_rx_hsync0  &  r_original_signal : 1'b0;




always@(posedge w_csi_rx_clk or negedge w_sys_rstn)
begin
    if(!w_sys_rstn)
        begin
            cnt_pixel   <=  'd0 ;
        end
    else if((~w_csi_rx_vsync0) || (~w_csi_rx_hsync0))// when finish 1line or 1frame
        begin
            cnt_pixel   <=  'd0 ;
        end
    else if(w_csi_rx_dvalid && w_csi_rx_hsync0)
        begin
            cnt_pixel   <=  cnt_pixel + 1 ;
        end
    else
        begin
            cnt_pixel   <=  cnt_pixel ;
        end
end

always@(posedge w_csi_rx_clk or negedge w_sys_rstn)
begin
    if(!w_sys_rstn)
        begin
            cnt_row   <=  'd0 ;
        end
    else if(~w_csi_rx_vsync0)// when finish 1line
        begin
            cnt_row   <=  'd0 ;
        end
    else if(rise_edge)//count +1 every rise edge
        begin
            cnt_row   <=  cnt_row + 1 ;
        end
    else
        begin
            cnt_row   <=  cnt_row ;
        end
end
endmodule
