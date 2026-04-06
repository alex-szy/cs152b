`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2026 11:01:51 PM
// Design Name: 
// Module Name: mux_4bit
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

module mux_4bit (
    input [15:0] inputs,
    input [3:0] select,
    output out
    );

    wire [16:0] select_one_hot;
    wire [3:0] select_b;
    wire [16:0] input_one_hot;

    not (select_b, select);

    and (select_one_hot[0], select_b[3], select_b[2], select_b[1], select_b[0]);
    and (select_one_hot[1], select_b[3], select_b[2], select_b[1], select[0]);
    and (select_one_hot[2], select_b[3], select_b[2], select[1], select_b[0]);
    and (select_one_hot[3], select_b[3], select_b[2], select[1], select[0]);
    and (select_one_hot[4], select_b[3], select[2], select_b[1], select_b[0]);
    and (select_one_hot[5], select_b[3], select[2], select_b[1], select[0]);
    and (select_one_hot[6], select_b[3], select[2], select[1], select_b[0]);
    and (select_one_hot[7], select_b[3], select[2], select[1], select[0]);
    and (select_one_hot[8], select[3], select_b[2], select_b[1], select_b[0]);
    and (select_one_hot[9], select[3], select_b[2], select_b[1], select[0]);
    and (select_one_hot[10], select[3], select_b[2], select[1], select_b[0]);
    and (select_one_hot[11], select[3], select_b[2], select[1], select[0]);
    and (select_one_hot[12], select[3], select[2], select_b[1], select_b[0]);
    and (select_one_hot[13], select[3], select[2], select_b[1], select[0]);
    and (select_one_hot[14], select[3], select[2], select[1], select_b[0]);
    and (select_one_hot[15], select[3], select[2], select[1], select[0]);

    and (input_one_hot, inputs, select_one_hot);

    or (out, input_one_hot[0], input_one_hot[1], input_one_hot[2], input_one_hot[3], input_one_hot[4], input_one_hot[5], input_one_hot[6], input_one_hot[7], input_one_hot[8], input_one_hot[9], input_one_hot[10], input_one_hot[11], input_one_hot[12], input_one_hot[13], input_one_hot[14], input_one_hot[15]);
endmodule