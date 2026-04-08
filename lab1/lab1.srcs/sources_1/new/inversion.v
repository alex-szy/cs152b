`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2026 06:27:53 PM
// Design Name: 
// Module Name: inversion
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


module inversion(
    output [15:0] S,
    output overflow,
    input [15:0] A
    );
    
    wire [15:0] A_bar;
    
    not (A_bar, A);
    
    adder_16bit add1 (
        .A(A),
        .B(16'b1),
        .S(S),
        .overflow(overflow)
    );
endmodule
