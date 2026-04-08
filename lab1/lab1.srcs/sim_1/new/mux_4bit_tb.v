`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2026 11:31:06 AM
// Design Name: 
// Module Name: mux_4bit_tb
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

module mux_4bit_tb;
    reg clk;
    reg [15:0] inputs = 0;
    wire out;
    
    integer i;

    always #10 clk <= ~clk;
    
    mux_4bit mux (
        .inputs(inputs),
        .out(out)
    );
    
    initial begin
        clk = 0;
        
        for (i = 0; i < 10; i = i + 1) begin
            #20
            
        end
    end
endmodule
