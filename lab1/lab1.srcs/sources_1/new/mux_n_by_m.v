`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2026 12:53:20 PM
// Design Name: 
// Module Name: mux_n_by_m
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


module mux_n_by_m #(M=16, N=4) (
    input [M*(2**N)-1:0] inputs,
    input [N-1:0] select,
    output [M-1:0] out
    );

    genvar i;
    // Recursive mux implementation
    generate
        // Base case, select line is 1 bit, we choose between 2 inputs
        if (N == 1) begin
            wire select_b;
            wire [M*2-1:0] masked_input;
            
            not (select_b, select[0]);
            and mask_upper [M-1:0] (masked_input[M*2-1:M], inputs[M*2-1:M], select[0]);
            and mask_lower [M-1:0] (masked_input[M-1:0], inputs[M-1:0], select_b);
            
            or output_or [M-1:0] (out, masked_input[M*2-1:M], masked_input[M-1:0]);
        end else begin
        // Recursively instantiates 2 muxes with N-1 select bits, uses MSB of select to mux between the 2 muxes
            wire select_msb_b;
            wire [M*2-1:0] res;
            wire [M*2-1:0] masked_res;
            
            not (select_msb_b, select[N-1]);
            
            mux_n_by_m #(.N(N-1), .M(M)) upper_mux (
                .inputs(inputs[M*(2**N)-1:M*(2**(N-1))]),
                .select(select[N-2:0]),
                .out(res[M*2-1:M])
            );
            
            mux_n_by_m #(.N(N-1), .M(M)) lower_mux (
                .inputs(inputs[M*(2**(N-1))-1:0]),
                .select(select[N-2:0]),
                .out(res[M-1:0])
            );
            
            and mask_upper [M-1:0] (masked_res[M*2-1:M], res[M*2-1:M], select[N-1]);
            and mask_lower [M-1:0] (masked_res[M-1:0], res[M-1:0], select_msb_b);
            or output_or [M-1:0] (out, masked_res[M*2-1:M], masked_res[M-1:0]);
        end
    endgenerate
endmodule
