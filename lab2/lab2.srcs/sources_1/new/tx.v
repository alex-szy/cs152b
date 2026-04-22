`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2026 11:14:53 AM
// Design Name: 
// Module Name: tx
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


module tx(
    input wire clk,
    input wire rst,
    input wire send,
    input wire [7:0] data,
    output reg tx_line = 0
    );
    
    reg [7:0] data_buf = 0;
    reg [3:0] sending = 0;
    reg send_prev = 0;
    
    // Clocked send
    always @ (posedge clk) begin
        if (sending == 0) begin
            tx_line <= 1; // tx line high when idle
            if (send && !send_prev) begin // posedge send
                // Read data into buffer
                data_buf <= data;
                // Set the sending bit so the transmission can start
                sending <= 1;
            end
        end else if (sending == 10) begin
            // last bit
            tx_line <= 1;
            sending <= 0;
        end else begin
            sending <= sending + 1;
            case (sending)
                1: tx_line <= 0;
                2: tx_line <= data_buf[0];
                3: tx_line <= data_buf[1];
                4: tx_line <= data_buf[2];
                5: tx_line <= data_buf[3];
                6: tx_line <= data_buf[4];
                7: tx_line <= data_buf[5];
                8: tx_line <= data_buf[6];
                9: tx_line <= data_buf[7];
            endcase
        end
    end
endmodule
