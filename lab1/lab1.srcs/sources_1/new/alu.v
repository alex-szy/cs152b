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

    wire [15:0] aggregated_outputs;

    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin
            and (aggregated_outputs[i], #todo);
            mux_4bit mux(aggregated_outputs[i], ALUCtrl, output[i]);
        end
    endgenerate
endmodule
