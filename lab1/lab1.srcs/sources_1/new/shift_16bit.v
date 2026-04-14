`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2026 12:20:59 PM
// Design Name: 
// Module Name: shift_16bit
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


module shift_16bit #(
    lr = 0, // 0 for left, 1 for right
    arith = 0 // 0 for logical, 1 for arithmetic
    )(
    input [15:0] A,
    input [15:0] B,
    output [15:0] S
    );
    
    // Intermediate shift results
    wire [79:0] int;
    // Assign the initial value of the input
    buf initial_a [15:0] (int[79:64], A);
    
    // Output of the 16-shifter
    // Shift 16 bits if B >= 16
    wire [15:0] overshift_out;
    wire overshift;
    or (overshift, B[4], B[5], B[6], B[7], B[8], B[9], B[10], B[11], B[12], B[13], B[14], B[15]);
    shift_n_fixed #(
        .shamt(16),
        .lr(lr),
        .arith(arith)
    ) over_shift (
        .in(int[79:64]),
        .out(overshift_out)
    );
    
    
    genvar i;
    generate
        // Cascaded shifter. First shifter shifts 8 bits, 2nd shifts 4, 3rd shifts 2 and 4th shifts 1.
        // Each stage is selected or bypassed depending on whether the corresponding bit in B is turned on.
        for (i = 3; i >= 0; i = i - 1) begin
            // Mux chooses between shifter output and unshifted input
            wire [31:0] shifter_mux_input;
            
            // Shifter input taken from muxed result of previous shift
            wire [15:0] shifter_input;
            buf sh_in [15:0] (shifter_input, int[(i+1)*16+15:(i+1)*16]);
            
            // Shifter output passed to top mux input
            shift_n_fixed #(
                .shamt(2**i),
                .lr(lr),
                .arith(arith)
            ) fixed_shift (
                .in(shifter_input),
                .out(shifter_mux_input[31:16])
            );
            
            // Unshifted passed to bottom mux input
            buf passthrough [15:0] (shifter_mux_input[15:0], shifter_input);
            
            mux_n_by_m #(
                .N(1),
                .M(16)
            ) mux (
                .inputs(shifter_mux_input),
                .select(B[i]),
                .out(int[i*16+15:i*16]) // Mux output
            );
        end
    endgenerate
    
    // Final mux selects the overshifter or the cascaded shifter output
    mux_n_by_m #(
        .N(1),
        .M(16)
    ) output_mux (
        .inputs({overshift_out, int[15:0]}),
        .select(overshift),
        .out(S)
    );
    
endmodule
