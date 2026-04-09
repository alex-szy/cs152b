`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2026 10:35:14 PM
// Design Name: 
// Module Name: increment
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


module increment(
    output [15:0] S,
    output overflow,
    input [15:0] A
    );
    
    adder_16bit increment (
        .S(S),
        .overflow(overflow),
        .A(A),
        .B(16'b1)
    );
endmodule
