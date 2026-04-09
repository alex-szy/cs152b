`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2026 10:38:00 PM
// Design Name: 
// Module Name: decrement
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


module decrement(
    output [15:0] S,
    output overflow,
    input [15:0] A
    );
    
    adder_16bit decrement (
        .S(S),
        .overflow(overflow),
        .A(A),
        .B(16'hFFFF)
    );
endmodule
