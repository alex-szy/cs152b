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
    reg [15:0] inputs = 16'hAAAA;
    reg [3:0] select = 0;
    wire out;
    
    integer i;

    
    mux_nbit #(.N(4)) mux (
        .inputs(inputs),
        .select(select),
        .out(out)
    );
    
    initial begin
        for (i = 0; i < 8; i = i + 1) begin
            #1
            select = select + 1;
        end
    end
endmodule
