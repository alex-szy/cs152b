`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2026 10:52:00 AM
// Design Name: 
// Module Name: rx
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


module rx(
    input wire clk,
    input wire rst,
    input wire rx_line,
    output reg [7:0] data
    );
    
    reg [3:0] state = 0;
    reg [7:0] buf_reg = 0;
    
    always @(posedge clk) begin
        if (state == 0) begin
            if (rx_line == 0) begin
                state <= 4'b1;
            end
        end else if (state == 9) begin
            if (rx_line == 1) begin
                data <= buf_reg;
            end
            state <= 0;
        end else begin
            state <= state + 1;
            case (state)
                1: buf_reg[0] <= rx_line;
                2: buf_reg[1] <= rx_line;
                3: buf_reg[2] <= rx_line;
                4: buf_reg[3] <= rx_line;
                5: buf_reg[4] <= rx_line;
                6: buf_reg[5] <= rx_line;
                7: buf_reg[6] <= rx_line;
                8: buf_reg[7] <= rx_line;
            endcase
         end
    end
    
endmodule
