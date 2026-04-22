`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2026 10:50:27 AM
// Design Name: 
// Module Name: rx_tb
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
        $display("ASSERTION FAILED in %m: signal (%h) != value (%h)", signal, value); \
        $finish; \
    end

module rx_tb();
    reg clk;
    reg rst;
    reg rx_line = 1;
    wire [7:0] data;
    
    rx dut (
        .clk(clk),
        .rst(rst),
        .rx_line(rx_line),
        .data(data)
    );
    
    initial begin
        clk = 1'b0;
        forever #1 clk = ~clk;
    end
    
    initial begin        
        // Valid transmission of byte 0x55
        #10 rx_line <= 0; // start bit
        #2
        rx_line <= 1; // bit 0
        #2
        rx_line <= 0; // bit 1
        #2
        rx_line <= 1; // bit 2
        #2
        rx_line <= 0; // bit 3
        #2
        rx_line <= 1; // bit 4
        #2
        rx_line <= 0; // bit 5
        #2
        rx_line <= 1; // bit 6
        #2
        rx_line <= 0; // bit 7
        #2
        rx_line <= 1; // Pulled high (valid)
        #2
        `assert(data, 8'b01010101);
        
        // Invalid end byte
        #10
        rx_line <= 0; // start bit
        #2
        rx_line <= 1; // bit 0
        #2
        rx_line <= 1; // bit 1
        #2
        rx_line <= 1; // bit 2
        #2
        rx_line <= 0; // bit 3
        #2
        rx_line <= 1; // bit 4
        #2
        rx_line <= 1; // bit 5
        #2
        rx_line <= 1; // bit 6
        #2
        rx_line <= 0; // bit 7
        #2
        rx_line <= 0; // Should be pulled high, but is not
        `assert(data, 8'b01010101); // Data remains same as before
        
    end   
endmodule
