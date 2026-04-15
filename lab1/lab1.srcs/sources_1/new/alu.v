//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2026 01:41:51 PM
// Design Name: 
// Module Name: alu
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

module alu (
    input [15:0] A,
    input [15:0] B,
    input [3:0] ALUCtrl,
    output [15:0] S,
    output zero,
    output overflow
    );
    
    // Collect the results from each functional unit into a bus
    wire [16*16-1:0] results_concat;
    
    // We also need to mux the overflow bits
    wire [15:0] overflow_bits;
    
    // TODO: Connect all the functional units to A, B, results_concat and overflow_bits
    
    // 0000 subtraction
    subtractor_16bit sub (
        .A(A),
        .B(B),
        .S(results_concat[15:0]),
        .overflow(overflow_bits[0])
    );
    
    // 0001 addition
    adder_16bit add (
        .A(A),
        .B(B),
        .S(results_concat[31:16]),
        .overflow(overflow_bits[1])
    );
    
    // 0100 decrement
    decrement dec (
        .A(A),
        .S(results_concat[79:64]),
        .overflow(overflow_bits[4])
    );
    
    // 0101 increment
    increment inc (
        .A(A),
        .S(results_concat[95:80]),
        .overflow(overflow_bits[5])
    );
    
    // 0110 invert
    inversion inv (
        .A(A),
        .S(results_concat[111:96]),
        .overflow(overflow_bits[6])
    );
    
    // 1100 arithmetic lshift
    shift_16bit #(
        .lr(0)
    ) arith_lshift (
        .A(A),
        .B(B),
        .S(results_concat[207:192])
    );
    buf (overflow_bits[12], 0);
    
    // 1110 arithmetic rshift
    shift_16bit #(
        .lr(1),
        .arith(1)
    ) arith_rshift (
        .A(A),
        .B(B),
        .S(results_concat[239:224])
    );
    buf (overflow_bits[14], 0);
    
    // 1001 set less than or equal
    sle sle (
        .A(A),
        .B(B),
        .S(results_concat[159:144])
    );
    buf (overflow_bits[9], 0);
    
    // 0010 bitwise or
    or bitwise_or [15:0] (results_concat[47:32], A, B);
    buf (overflow_bits[2], 0);
    
    // 0011 bitwise and
    and bitwise_and [15:0] (results_concat[63:48], A, B);
    buf (overflow_bits[3], 0);
    
    // 1000 logical lshift
    shift_16bit #(
        .lr(0)
    ) log_lshift (
        .A(A),
        .B(B),
        .S(results_concat[143:128])
    );
    buf (overflow_bits[8], 0);
    
    // 1010 logical rshift
    shift_16bit #(
        .lr(1)
    ) log_rshift (
        .A(A),
        .B(B),
        .S(results_concat[175:160])
    );
    buf (overflow_bits[10], 0);
    
    // Output mux
    mux_n_by_m #(
        .N(4),
        .M(16)
    ) output_mux (
        .inputs(results_concat),
        .select(ALUCtrl),
        .out(S)
    );
    
    // Overflow mux
    mux_n_by_m #(
        .N(4),
        .M(1)
    ) overflow_mux (
        .inputs(overflow_bits),
        .select(ALUCtrl),
        .out(overflow)
    );
    
    // Compute the zero bit
    nor (zero, S[0], S[1], S[2], S[3], S[4], S[5], S[6], S[7], S[8], S[9], S[10], S[11], S[12], S[13], S[14], S[15]);
endmodule
