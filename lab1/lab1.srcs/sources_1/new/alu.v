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
    // Since verilog does not support multidimensional wires, we concatenate the outputs together
    // Each mux then takes the first bit of every output and selects the correct bit to pass to the output S
    // The output bits from the 16 muxes are then concatenated to give the final output
    wire [255:0] scatter_inputs;
    wire [255:0] gather_outputs;
    
    // We also need to mux the overflow bits
    wire [15:0] overflow_bits;
    

    genvar i, j;
    
    // The ith mux takes the ith bit of every output
    generate
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                assign gather_outputs[i*16 + j] = scatter_inputs[j*16 + i];
            end
        end
    endgenerate
    
    // Initiate the muxes and concatenate the outputs onto S
    generate
        for (i = 0; i < 16; i = i + 1) begin
            mux_4bit mux (
                .inputs(gather_outputs[i*16+15:i*16]),
                .select(ALUCtrl),
                .out(S[i])
            );
        end
    endgenerate
    
    // Overflow mux
    mux_4bit overflow_mux (
        .inputs(overflow_bits),
        .select(ALUCtrl),
        .out(overflow)
    );
    
    // Compute the zero bit
    nor (zero, S[0], S[1], S[2], S[3], S[4], S[5], S[6], S[7], S[8], S[9], S[10], S[11], S[12], S[13], S[14], S[15]);
endmodule
