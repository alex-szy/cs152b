`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2026 12:53:20 PM
// Design Name: 
// Module Name: mux_nbit
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


module mux_nbit #(N=4) (
    input [2**N-1:0] inputs,
    input [N-1:0] select,
    output out
    );

    // Recursive mux implementation
    generate
        // Base case, select line is 1 bit, we choose between 2 inputs
        if (N == 1) begin
            wire select_b;
            wire [1:0] masked_input;
            
            not (select_b, select[0]);
            and (masked_input[1], inputs[1], select[0]);
            and (masked_input[0], inputs[0], select_b);
            or (out, masked_input[1], masked_input[0]);
        end else begin
        // Recursively instantiates 2 muxes with N-1 select bits, uses MSB of select to mux between the 2 muxes
            wire select_msb_b;
            wire [1:0] res;
            wire [1:0] masked_res;
            
            not (select_msb_b, select[N-1]);
            
            mux_nbit #(.N(N-1)) upper_mux (
                .inputs(inputs[2**N-1:2**(N-1)]),
                .select(select[N-2:0]),
                .out(res[1])
            );
            
            mux_nbit #(.N(N-1)) lower_mux (
                .inputs(inputs[2**(N-1)-1:0]),
                .select(select[N-2:0]),
                .out(res[0])
            );
            
            and (masked_res[1], res[1], select[N-1]);
            and (masked_res[0], res[0], select_msb_b);
            or (out, masked_res[1], masked_res[0]);
        end
    endgenerate
endmodule
