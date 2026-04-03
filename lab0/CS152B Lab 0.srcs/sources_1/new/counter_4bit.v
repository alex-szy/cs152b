`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2026 10:45:39 AM
// Design Name: 
// Module Name: counter_4bit
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


module counter_4bit(
    input clk_1hz,
    input rst,
    output [3:0] count
    );
    
    reg [3:0] count_reg = 0;
    
    // increment
    always @ (posedge clk_1hz or posedge rst) begin
        if (rst) begin
            count_reg <= 0;
        end else begin
            count_reg <= count_reg + 1;
        end
    end
    
    assign count = count_reg;
endmodule
