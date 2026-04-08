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

`define assert(signal, value) \
    if (signal !== value) begin \
        $display("ASSERTION FAILED in %m: signal != value"); \
        $finish; \
    end

module adder_16bit_tb;
    reg [15:0] A;
    reg [15:0] B;
    wire [15:0] S;
    wire overflow;
    wire zero;
        
    adder_16bit adder (
        .A(A),
        .B(B),
        .S(S),
        .overflow(overflow),
        .zero(zero)
    );
    
    initial begin
        
        // Addition of positive numbers w/o overflow
        A = 16'h3abc;
        B = 16'h2f49;
        #50
        `assert(S, 16'h6a05);
        `assert(overflow, 0);
        `assert(zero, 0);
        
        // Addition of positive numbers w/ overflow
        A = 16'h4444;
        B = 16'h5555;
        #50
        `assert(S, 16'h9999);
        `assert(overflow, 1);
        `assert(zero, 0);
        
        /* Addition of pos and neg numbers */
        // neg result
        A = 16'h3d4e;
        B = 16'h9787;
        #50
        `assert(S, 16'hd4d5);
        `assert(overflow, 0);
        `assert(zero, 0);
        
        // pos result
        A = 16'h1f39;
        B = 16'hff88;
        #50
        `assert(S, 16'h1ec1);
        `assert(overflow, 0);
        `assert(zero, 0);
        
        // zero result
        A = 16'h26af;
        B = 16'hd951;
        #50
        `assert(S, 16'h0);
        `assert(overflow, 0);
        `assert(zero, 1);
        
        // Addition of negative numbers w/o underflow
        A = 16'hc017;
        B = 16'hd4fa;
        #50
        `assert(S, 16'h9511);
        `assert(overflow, 0);
        `assert(zero, 0);
        
        // Addition of negative numbers w/ underflow
        A = 16'hb017;
        B = 16'hc4fa;
        #50
        `assert(S, 16'h7511);
        `assert(overflow, 1);
        `assert(zero, 0);
    end
    
endmodule
