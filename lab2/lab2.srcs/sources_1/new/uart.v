`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2026 05:45:57 PM
// Design Name: 
// Module Name: uart
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


module uart(
    input [7:0] sw,
    output [7:0] led,
    input clk,
    input btnU,
    input btnC,
    input JA,
    output JB
    );
    
    wire rst, send, clk_9600;
    
    debounce dbc_1 (
        .clk(clk_9600),
        .in(btnU),
        .out(rst)
    );
    
    debounce dbc_2 (
        .clk(clk_9600),
        .in(btnC),
        .out(send)
    );
    
    clk_div_9600hz (
        .clk(clk),
        .clk_out(clk_9600)
    );
    
    rx rcv (
        .clk(clk_9600),
        .rst(rst),
        .rx_line(JA),
        .data(led)
    );
    
    tx snd (
        .clk(clk_9600),
        .rst(rst),
        .send(send),
        .data(sw),
        .tx_line(JB)
    );
endmodule
