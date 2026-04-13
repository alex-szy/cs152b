`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2026 10:33:38 AM
// Design Name: 
// Module Name: shift_n_fixed
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


module shift_n_fixed #(
    shamt = 0,
    lr = 0, // 0 for left shift, 1 for right
    arith = 0 // 0 for logical, 1 for arithmetic
    )(
    input [15:0] in,
    output [15:0] out
    );
    
    genvar i;
    generate
        if (lr == 0) begin
            // left shift
            for (i = 0; i < 16; i = i + 1) begin
                if (i < shamt) begin
                    // output zeros until the Nth position
                    buf (out[i], 0);
                end else begin
                    buf (out[i], in[i - shamt]);
                end
            end
        end else begin
            // right shift
            for (i = 0; i < 16; i = i + 1) begin
                if (i >= 16 - shamt) begin
                    if (arith == 0) begin
                        // output zeros from MSB till shift position if logical, sign bit if arithmetic
                        buf (out[i], 0);
                    end else begin
                        buf (out[i], in[15]);
                    end
                end else begin
                    buf (out[i], in[i + shamt]);
                end
            end
        end
    endgenerate
endmodule
