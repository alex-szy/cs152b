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


module clk_div_1hz(
    input clk,
    output reg clk_1hz = 0
    ); 
    reg [25:0] clk_div_reg = 0;
    localparam clk_count = 50_000_000;
    
    //clock divider
    always @ (posedge clk) begin
        if (clk_div_reg > clk_count) begin
            clk_1hz <= ~clk_1hz;
            clk_div_reg <= 0;
        end else begin
            clk_div_reg <= clk_div_reg + 1;
        end
    end
endmodule
