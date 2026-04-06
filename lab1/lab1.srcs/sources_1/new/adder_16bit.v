`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2026 10:52:01 AM
// Design Name: 
// Module Name: adder_4bit
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


module adder_16bit(
    input [15:0] A,
    input [15:0] B,
    output [15:0] S,
    output zero,
    output overflow
    );
    
    wire C_out[15:0];
 
    full_adder_1bit u0(A[0], B[0], 0, S[0], C_out[0]);
    genvar i;
    generate
        for (i = 1; i < 16; i = i + 1) begin
            full_adder_1bit ui(A[i], B[i], C_out[i-1], S[i], C_out[i]);
        end
    endgenerate
    
    assign overflow = C_out[15];
    and(zero, S[0], S[1], S[2], S[3], S[4], S[5], S[6], S[7], S[8], S[9], S[10], S[11], S[12], S[13], S[14], S[15]);

endmodule

module full_adder_1bit(
    input A,
    input B,
    input C_in,
    output S,
    output C_out
    );
    
    wire xor_out, and0, and1;
    xor(xor_out, A, B);
    xor(S, xor_out, C_in);
    and(and0, C_in, xor_out);
    and(and1, A, B);
    or(C_out, and0, and1);
    
endmodule
