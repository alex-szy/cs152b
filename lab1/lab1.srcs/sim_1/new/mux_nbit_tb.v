`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2026 08:46:38 PM
// Design Name: 
// Module Name: mux_nbit_tb
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


`define assert(signal, value) \
        if (signal !== value) begin \
            $display("ASSERTION FAILED in %m: signal != value"); \
            $finish; \
        end

module mux_nbit_tb;
    reg [16*4-1:0] inputs = 64'hFEDCBA9876543210;
    reg [3:0] select = 0;
    wire [3:0] out;
    
    integer i;
    
    mux_n_by_m #(.N(4), .M(4)) mux (
        .inputs(inputs),
        .select(select),
        .out(out)
    );
    
    initial begin
        for (i = 0; i < 15; i = i + 1) begin
            #1
            select = select + 1;
        end
    end
endmodule
