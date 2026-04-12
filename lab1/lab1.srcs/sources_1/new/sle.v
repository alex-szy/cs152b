`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2026 07:17:26 PM
// Design Name: 
// Module Name: sle
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


module sle(
    output [15:0] S,
    input [15:0] A,
    input [15:0] B
    );
    
    wire [15:0] subtracted;
    wire overflow;
    
    subtractor_16bit sub (
        .S(subtracted),
        .A(B),
        .B(A),
        .overflow(overflow)
    );
    
    not s_zero_pad [14:0] (S[15:1], 15'h7FFF);
    xnor (S[0], overflow, subtracted[15]);
endmodule
