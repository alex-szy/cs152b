`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2026 07:45:39 PM
// Design Name: 
// Module Name: sle_tb
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


module sle_tb;
    reg [15:0] A, B;
    wire [15:0] S;
    
    sle sles (
        .S(S),
        .A(A),
        .B(B)
    );
    
    initial begin
        A = 0;
        B = 0;
        #1
        A = 0;
        B = 1;
        #1
        A = 1;
        B = -1;
        #1
        A = -3;
        B = -2;
        #1
        A = 16'h8000;
        B = 16'h8000;
    end
endmodule
