`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2026 12:20:59 PM
// Design Name: 
// Module Name: leftshift_16bit
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


module leftshift_16bit(
    input [15:0] A,
    input [15:0] B,
    output [15:0] S
    );
    
    wire if_out_zero;
    NOR(if_out_zero, B[4], B[5], B[6], B[7], B[8], B[9], B[10], B[11], B[12], B[13], B[14], B[15]);
    
    wire [15:0] int1, int2, int3, out;
    mux_1bit(, B[3], int2);
    
    
    and(S, if_out_zero, out);
endmodule
