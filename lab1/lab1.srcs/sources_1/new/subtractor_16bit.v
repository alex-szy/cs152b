`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2026 07:20:35 PM
// Design Name: 
// Module Name: subtractor_16bit
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


module subtractor_16bit(
    output [15:0] S,
    input [15:0] A,
    input [15:0] B,
    output overflow
    );
    
    wire [15:0] B_neg;
    
    inversion inv (
        .A(B),
        .S(B_neg)
    );
    
    adder_16bit add (
        .S(S),
        .A(A),
        .B(B_neg),
        .overflow(overflow)
    );
endmodule
