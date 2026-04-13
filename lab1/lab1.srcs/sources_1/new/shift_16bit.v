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
    
    wire if_out_zero_or_sign, if_out_zero_or_sign_b;
    or(if_out_zero_or_sign, B[4], B[5], B[6], B[7], B[8], B[9], B[10], B[11], B[12], B[13], B[14], B[15]);
    not(if_out_zero_or_sign_b, if_out_zero_or_sign);
    
    wire [15:0] sign_extd;
    assign sign_extd [15:0] = {16{A[15]}};
    
    // Intermediate shift results
    wire [79:0] int;
    // Assign the initial value of the input
    buf initial_a [15:0] (int[79:64], A);
    
    genvar i;
    generate
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
    
    generate
        if (lr == 1 && arith == 1) begin
            wire [15:0] S_1, S_2;
            and out1 [15:0] (S_1, int[15:0], if_out_zero_or_sign_b);
            and out2 [15:0] (S_2, sign_extd[15:0], if_out_zero_or_sign);
            or out [15:0] (S, S_1, S_2);
        end else begin
            and out [15:0] (S, int[15:0], if_out_zero_or_sign_b);
        end
    endgenerate
    
endmodule
