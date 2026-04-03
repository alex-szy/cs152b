`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2026 10:26:04 AM
// Design Name: 
// Module Name: counter_tb
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

`timescale 1ns / 1ps

module counter_tb;
    reg clk;
    reg rst;
    wire [3:0] count;
    
    always #10 clk <= ~clk;
    
    counter_4bit cnt (
        .clk_1hz(clk),
        .rst(rst),
        .count(count)
        );
    
    initial begin
        clk = 0;
        rst = 0;
        #105
        rst = 1;
        #10
        rst = 0;
        #50
        rst = 1;
        #100000
        $finish;
    end
endmodule


