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
    
    task send_byte(input [7:0] b);
        integer i;
        begin
            // Start bit
            rx_line <= 0;
            #2;
            // Data bits (LSB first)
            for (i = 0; i < 8; i = i + 1) begin
                rx_line <= b[i];
                #2;
            end
            // Stop bit
            rx_line <= 1;
            #2;
        end
    endtask

    initial begin
        clk = 1'b0;
        forever #1 clk = ~clk;
    end
    
    initial begin
        rst = 1;
        #4 rst = 0;
        #2;
        
        // Test 1: Valid transmission of byte 0x55
        $display("Test 1: Sending 0x55");
        send_byte(8'h55);
        #2;
        `assert(data, 8'h55);
        
        // Test 2: Invalid stop bit (should not update data)
        $display("Test 2: Invalid stop bit with 0xAA");
        // Manual send with invalid stop bit
        rx_line <= 0; #2; // start
        send_data_bits(8'hAA);
        rx_line <= 0; #2; // INVALID stop bit
        #2;
        `assert(data, 8'h55); // Should still be 0x55
        
        // Test 3: Back-to-back valid transmissions
        $display("Test 3: Back-to-back 0x12, 0x34");
        send_byte(8'h12);
        send_byte(8'h34);
        #2;
        `assert(data, 8'h34);
        
        // Test 4: All zeros
        $display("Test 4: Sending 0x00");
        send_byte(8'h00);
        #2;
        `assert(data, 8'h00);
        
        // Test 5: All ones
        $display("Test 5: Sending 0xFF");
        send_byte(8'hFF);
        #2;
        `assert(data, 8'hFF);

        // Test 6: Reset during transmission
        $display("Test 6: Reset during transmission");
        rx_line <= 0; #2; // start
        rx_line <= 1; #2; // bit 0
        rst <= 1; #2; rst <= 0;
        send_byte(8'hCC);
        #2;
        `assert(data, 8'hCC);
        
        $display("All tests passed!");
        $finish;
    end

    task send_data_bits(input [7:0] b);
        integer i;
        begin
            for (i = 0; i < 8; i = i + 1) begin
                rx_line <= b[i];
                #2;
            end
        end
    endtask
endmodule
