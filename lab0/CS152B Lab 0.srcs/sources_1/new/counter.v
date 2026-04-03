`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2026 11:04:26 AM
// Design Name: 
// Module Name: counter
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


module counter(
    input clk,
    input btnU,
    output [3:0] led
    );
    wire clk_1hz;
    wire rst;
    
    clk_div_1hz clk_div (
        .clk(clk),
        .clk_1hz(clk_1hz)
    );
    
    counter_4bit cnt (
        .clk_1hz(clk_1hz),
        .rst(rst),
        .count(led)
    );
    
    debounce dbc (
        .clk(clk),
        .noisy_input(btnU),
        .out(rst)
    );
endmodule
