`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2026 10:58:40 AM
// Design Name: 
// Module Name: clk_div_1hz
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


module clk_div_9600hz(
    input clk,
    output reg clk_out = 0
    ); 
    reg [25:0] clk_div_reg = 0;
    localparam clk_count = 5208;
    
    //clock divider
    always @ (posedge clk) begin
        if (clk_div_reg > clk_count) begin
            clk_out <= ~clk_out;
            clk_div_reg <= 0;
        end else begin
            clk_div_reg <= clk_div_reg + 1;
        end
    end
endmodule
