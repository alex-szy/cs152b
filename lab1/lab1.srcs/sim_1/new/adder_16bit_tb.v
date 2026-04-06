`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2026 11:17:55 AM
// Design Name: 
// Module Name: adder_16bit_tb
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

`timescale 1ns / 1ps

module adder_16bit_tb;
    reg clk;
    reg [15:0] A;
    reg [15:0] B;
    reg [15:0] S;
    reg overflow;
    reg zero;
    
    always #10 clk <= ~clk;
    
    adder_16bit adder {
        .
    };
    
endmodule
