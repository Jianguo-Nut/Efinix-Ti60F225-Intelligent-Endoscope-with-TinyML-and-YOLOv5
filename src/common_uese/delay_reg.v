`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/23 04:31:58
// Design Name: 
// Module Name: delay_reg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

/*
delay_reg #(.delay_level(),.reg_width()) DR0(
    .dout(),
    .din(),
    .clk(),
    .rst()
);
*/

module delay_reg #(parameter delay_level = 1,reg_width = 1)(
    output[reg_width-1:0] dout,
    input[reg_width-1:0] din,
    input clk,
    input rst    
);

reg[reg_width-1:0] shift_reg[delay_level-1:0];
integer i;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        for (i = 0;i < delay_level;i = i + 1) begin
            shift_reg[i] <= 0;
        end
    end
    else begin
        shift_reg[0] <= din;
        for (i = 1;i < delay_level;i = i + 1) begin
            shift_reg[i] <= shift_reg[i - 1];
        end
     end
end

assign dout = shift_reg[delay_level - 1];

endmodule
