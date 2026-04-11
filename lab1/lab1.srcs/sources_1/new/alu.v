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
