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

    wire [2**N-1:0] select_one_hot;
    wire [N-1:0] select_b;
    wire [2**N-1:0] input_one_hot;

    not (select_b, select);
    
    genvar i, j;
    generate
        for (i=0; i<2**N; i=i+1) begin
            for (j=0; j<N; j=j+1) begin
                and(select_one_hot[i], (i & 2 ** j) == 1 ? select[j] : select_b[j]);
            end
        end
    endgenerate

    and (input_one_hot, inputs, select_one_hot);

    or (out, input_one_hot[0], input_one_hot[1], input_one_hot[2], input_one_hot[3], input_one_hot[4], input_one_hot[5], input_one_hot[6], input_one_hot[7], input_one_hot[8], input_one_hot[9], input_one_hot[10], input_one_hot[11], input_one_hot[12], input_one_hot[13], input_one_hot[14], input_one_hot[15]);
endmodule
