`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2026 12:21:51 PM
// Design Name: 
// Module Name: debounce
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


module debounce(
    input clk,
    input noisy_input,
    output out
    );
    
    reg [9:0] debounce_ff = 0;
    
    always @ (posedge clk) begin
        debounce_ff <= {debounce_ff[8:0], noisy_input};
    end
    
    assign out = &debounce_ff;
endmodule
