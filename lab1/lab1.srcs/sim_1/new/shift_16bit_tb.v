`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2026 11:09:41 AM
// Design Name: 
// Module Name: shift_16bit_tb
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

`define assert(signal, value) \
        if (signal !== value) begin \
            $display("ASSERTION FAILED in %m: signal != value"); \
            $finish; \
        end

module shift_16bit_tb;
    reg [15:0] A;
    reg [15:0] B;
    wire [15:0] S_lshift, S_rshift_log, S_rshift_arith;
    
    shift_16bit #(.lr(0)) lshifter (
        .A(A),
        .B(B),
        .S(S_lshift)
    );
    
    shift_16bit #(.lr(1), .arith(0)) rshifter_logical(
        .A(A),
        .B(B),
        .S(S_rshift_log)
    );
    
    shift_16bit #(.lr(1), .arith(1)) rshifter_arith(
        .A(A),
        .B(B),
        .S(S_rshift_arith)
    );

    initial begin
        // B >= 16
        A = 16'h3abc;
        B = 16'h10;
        #1
        `assert(S_lshift, 16'h0);
        `assert(S_rshift_log, 16'h0);
        `assert(S_rshift_arith, 16'h0);
        
        A = 16'h8abc;
        B = 16'h10;
        #1
        `assert(S_lshift, 16'h0);
        `assert(S_rshift_log, 16'h0);
        `assert(S_rshift_arith, 16'hffff);
        
        // B = 8
        A = 16'h8abc;
        B = 16'h8;
        #1
        `assert(S_lshift, 16'hbc00);
        `assert(S_rshift_log, 16'h008a);
        `assert(S_rshift_arith, 16'hff8a);
        
        // B = 5
        A = 16'h8abc;
        B = 16'h5;
        #1
        `assert(S_lshift, 16'h5780);
        `assert(S_rshift_log, 16'h0455);
        `assert(S_rshift_arith, 16'hfc55);
        $finish;
    end
endmodule
