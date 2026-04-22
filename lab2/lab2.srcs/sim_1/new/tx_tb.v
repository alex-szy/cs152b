`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: tx_tb
// Description: Testbench for the UART transmitter module (tx.v).
//              Tests start bit, data bits (LSB first), and stop bit.
//////////////////////////////////////////////////////////////////////////////////

module tx_tb();

    // Inputs
    reg clk;
    reg rst;
    reg send;
    reg [7:0] data;

    // Outputs
    wire tx_line;

    // Instantiate the Unit Under Test (UUT)
    tx uut (
        .clk(clk), 
        .rst(rst), 
        .send(send), 
        .data(data), 
        .tx_line(tx_line)
    );

    // Clock generation (100 MHz -> 10ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // Initialize Inputs
        rst = 1;
        send = 0;
        data = 0;

        // Wait 100 ns for global reset
        #100;
        rst = 0;
        #20;

        // Test Case 1: Send 0x55 (8'b01010101)
        // Expected: Start(0), 1, 0, 1, 0, 1, 0, 1, 0, Stop(1)
        data = 8'h55;
        send = 1;
        #20
        send = 0;
        
        // Wait for transmission to complete (approx 11 cycles)
        #110

        // Test Case 2: Send 0xAA (8'b10101010)
        // Expected: Start(0), 0, 1, 0, 1, 0, 1, 0, 1, Stop(1)
        data = 8'hAA;
        send = 1;
        #20
        send = 0;
        
        #110

        // Test Case 3: Send 0x 00
        data = 8'h00;
        send = 1;
        #20
        send = 0;
        
        #110
        
        // Test Case 4: Send 0xFF
        data = 8'hFF;
        send = 1;
        #20
        send = 0;
        
        #110

        $display("Simulation complete.");
        $finish;
    end
    
    // Monitor output in the console
    initial begin
        $display("Time\t\t send\t data\t tx_line\t state(sending)");
        $monitor("%t\t %b\t %h\t %b\t\t %d", $time, send, data, tx_line, uut.sending);
    end

endmodule
