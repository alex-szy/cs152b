`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2026 01:42:06 PM
// Design Name: 
// Module Name: alu_tb
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

module alu_tb();
    reg [15:0] A;
    reg [15:0] B;
    reg [3:0] ALUCtrl;
    wire [15:0] S;
    wire zero;
    wire overflow;

    // Instantiate the Unit Under Test (UUT)
    alu dut (
        .A(A),
        .B(B),
        .ALUCtrl(ALUCtrl),
        .S(S),
        .zero(zero),
        .overflow(overflow)
    );

    initial begin
        // Monitor outputs
        $monitor("Time=%0t | ALUCtrl=%b | A=%h | B=%h | S=%h | zero=%b | overflow=%b", 
                 $time, ALUCtrl, A, B, S, zero, overflow);

        // --- Test 0000: Subtraction (A - B) ---
        $display("\n--- Subtraction (0000) ---");
        ALUCtrl = 4'b0000;
        A = 16'h0005; B = 16'h0003; #10; `assert(S, 16'h0002) `assert(zero, 0) `assert(overflow, 0)
        A = 16'h0003; B = 16'h0003; #10; `assert(S, 16'h0000) `assert(zero, 1) `assert(overflow, 0)
        A = 16'h0000; B = 16'h0000; #10; `assert(S, 16'h0000) `assert(zero, 1) `assert(overflow, 0)
        A = 16'h8000; B = 16'h0001; #10; `assert(S, 16'h7FFF) `assert(zero, 0) `assert(overflow, 1)
        A = 16'h7FFF; B = 16'hFFFF; #10; `assert(S, 16'h8000) `assert(zero, 0) `assert(overflow, 1)
        // Corner case: -32768 - (-32768). 
        // In this implementation, B_neg of 8000 is 8000. 8000 + 8000 = 0 with overflow.
        A = 16'h8000; B = 16'h8000; #10; `assert(S, 16'h0000) `assert(zero, 1) `assert(overflow, 0)
        A = 16'h8000; B = 16'h7FFF; #10; `assert(S, 16'h0001) `assert(zero, 0) `assert(overflow, 1)
        A = 16'h7FFF; B = 16'h8000; #10; `assert(S, 16'hFFFF) `assert(zero, 0) `assert(overflow, 1)

        // --- Test 0001: Addition (A + B) ---
        $display("\n--- Addition (0001) ---");
        ALUCtrl = 4'b0001;
        A = 16'h0005; B = 16'h0003; #10; `assert(S, 16'h0008) `assert(zero, 0) `assert(overflow, 0)
        A = 16'h0000; B = 16'h0000; #10; `assert(S, 16'h0000) `assert(zero, 1) `assert(overflow, 0)
        A = 16'hFFFF; B = 16'h0001; #10; `assert(S, 16'h0000) `assert(zero, 1) `assert(overflow, 0)
        A = 16'h7FFF; B = 16'h0001; #10; `assert(S, 16'h8000) `assert(zero, 0) `assert(overflow, 1)
        A = 16'h8000; B = 16'hFFFF; #10; `assert(S, 16'h7FFF) `assert(zero, 0) `assert(overflow, 1)

        // --- Test 0010: Bitwise OR ---
        $display("\n--- Bitwise OR (0010) ---");
        ALUCtrl = 4'b0010;
        A = 16'hAAAA; B = 16'h5555; #10; `assert(S, 16'hFFFF) `assert(zero, 0) `assert(overflow, 0)
        A = 16'h0000; B = 16'h0000; #10; `assert(S, 16'h0000) `assert(zero, 1) `assert(overflow, 0)
        A = 16'h1234; B = 16'h0000; #10; `assert(S, 16'h1234) `assert(zero, 0) `assert(overflow, 0)

        // --- Test 0011: Bitwise AND ---
        $display("\n--- Bitwise AND (0011) ---");
        ALUCtrl = 4'b0011;
        A = 16'hFFFF; B = 16'h5555; #10; `assert(S, 16'h5555) `assert(zero, 0) `assert(overflow, 0)
        A = 16'hAAAA; B = 16'h5555; #10; `assert(S, 16'h0000) `assert(zero, 1) `assert(overflow, 0)

        // --- Test 0100: Decrement (A - 1) ---
        $display("\n--- Decrement (0100) ---");
        ALUCtrl = 4'b0100;
        A = 16'h0001; #10; `assert(S, 16'h0000) `assert(zero, 1) `assert(overflow, 0)
        A = 16'h0000; #10; `assert(S, 16'hFFFF) `assert(zero, 0) `assert(overflow, 0)
        A = 16'h8000; #10; `assert(S, 16'h7FFF) `assert(zero, 0) `assert(overflow, 1)

        // --- Test 0101: Increment (A + 1) ---
        $display("\n--- Increment (0101) ---");
        ALUCtrl = 4'b0101;
        A = 16'hFFFF; #10; `assert(S, 16'h0000) `assert(zero, 1) `assert(overflow, 0)
        A = 16'h0000; #10; `assert(S, 16'h0001) `assert(zero, 0) `assert(overflow, 0)
        A = 16'h7FFF; #10; `assert(S, 16'h8000) `assert(zero, 0) `assert(overflow, 1)

        // --- Test 0110: Inversion (-A) ---
        $display("\n--- Inversion (0110) ---");
        ALUCtrl = 4'b0110;
        A = 16'h0001; #10; `assert(S, 16'hFFFF) `assert(zero, 0) `assert(overflow, 0)
        A = 16'h0000; #10; `assert(S, 16'h0000) `assert(zero, 1) `assert(overflow, 0)
        A = 16'hFFFF; #10; `assert(S, 16'h0001) `assert(zero, 0) `assert(overflow, 0)
        A = 16'h8000; #10; `assert(S, 16'h8000) `assert(zero, 0) `assert(overflow, 1)

        // --- Test 1000: Logical LShift (A << B) ---
        $display("\n--- Logical LShift (1000) ---");
        ALUCtrl = 4'b1000;
        A = 16'h1234; B = 16'h0000; #10; `assert(S, 16'h1234) `assert(zero, 0) `assert(overflow, 0)
        A = 16'h0001; B = 16'h0004; #10; `assert(S, 16'h0010) `assert(zero, 0) `assert(overflow, 0)
        A = 16'h0001; B = 16'h000F; #10; `assert(S, 16'h8000) `assert(zero, 0) `assert(overflow, 0)
        A = 16'h8000; B = 16'h0001; #10; `assert(S, 16'h0000) `assert(zero, 1) `assert(overflow, 0)
        A = 16'hFFFF; B = 16'h0010; #10; `assert(S, 16'h0000) `assert(zero, 1) `assert(overflow, 0)
        A = 16'hFFFF; B = 16'hFFFF; #10; `assert(S, 16'h0000) `assert(zero, 1) `assert(overflow, 0)

        // --- Test 1001: SLE (A <= B) ---
        $display("\n--- SLE (1001) ---");
        ALUCtrl = 4'b1001;
        A = 16'h0001; B = 16'h0002; #10; `assert(S, 16'h0001) `assert(zero, 0) `assert(overflow, 0)
        A = 16'h0002; B = 16'h0001; #10; `assert(S, 16'h0000) `assert(zero, 1) `assert(overflow, 0)
        A = 16'h0001; B = 16'h0001; #10; `assert(S, 16'h0001) `assert(zero, 0) `assert(overflow, 0)
        A = 16'hFFFF; B = 16'h0001; #10; `assert(S, 16'h0001) `assert(zero, 0) `assert(overflow, 0)
        A = 16'h0001; B = 16'hFFFF; #10; `assert(S, 16'h0000) `assert(zero, 1) `assert(overflow, 0)
        A = 16'h7FFF; B = 16'h8000; #10; `assert(S, 16'h0000) `assert(zero, 1) `assert(overflow, 0)
        A = 16'h8000; B = 16'h7FFF; #10; `assert(S, 16'h0001) `assert(zero, 0) `assert(overflow, 0)
        A = 16'h8000; B = 16'h8000; #10; `assert(S, 16'h0001) `assert(zero, 0) `assert(overflow, 0)

        // --- Test 1010: Logical RShift (A >> B) ---
        $display("\n--- Logical RShift (1010) ---");
        ALUCtrl = 4'b1010;
        A = 16'h1234; B = 16'h0000; #10; `assert(S, 16'h1234) `assert(zero, 0) `assert(overflow, 0)
        A = 16'h0010; B = 16'h0004; #10; `assert(S, 16'h0001) `assert(zero, 0) `assert(overflow, 0)
        A = 16'h8000; B = 16'h000F; #10; `assert(S, 16'h0001) `assert(zero, 0) `assert(overflow, 0)
        A = 16'h8000; B = 16'h0001; #10; `assert(S, 16'h4000) `assert(zero, 0) `assert(overflow, 0)
        A = 16'hFFFF; B = 16'h0010; #10; `assert(S, 16'h0000) `assert(zero, 1) `assert(overflow, 0)

        // --- Test 1100: Arithmetic LShift (A <<< B) ---
        $display("\n--- Arithmetic LShift (1100) ---");
        ALUCtrl = 4'b1100;
        A = 16'h1234; B = 16'h0000; #10; `assert(S, 16'h1234) `assert(zero, 0) `assert(overflow, 0)
        A = 16'h0001; B = 16'h0004; #10; `assert(S, 16'h0010) `assert(zero, 0) `assert(overflow, 0)
        A = 16'h8000; B = 16'h0001; #10; `assert(S, 16'h0000) `assert(zero, 1) `assert(overflow, 0)

        // --- Test 1110: Arithmetic RShift (A >>> B) ---
        $display("\n--- Arithmetic RShift (1110) ---");
        ALUCtrl = 4'b1110;
        A = 16'h8000; B = 16'h0000; #10; `assert(S, 16'h8000) `assert(zero, 0) `assert(overflow, 0)
        A = 16'h8000; B = 16'h0001; #10; `assert(S, 16'hC000) `assert(zero, 0) `assert(overflow, 0)
        A = 16'h7000; B = 16'h0001; #10; `assert(S, 16'h3800) `assert(zero, 0) `assert(overflow, 0)
        A = 16'hFFFF; B = 16'h000F; #10; `assert(S, 16'hFFFF) `assert(zero, 0) `assert(overflow, 0)
        A = 16'h8000; B = 16'h000F; #10; `assert(S, 16'hFFFF) `assert(zero, 0) `assert(overflow, 0)
        A = 16'hFFFF; B = 16'h0010; #10; `assert(S, 16'hFFFF) `assert(zero, 0) `assert(overflow, 0)
        
        $display("\nALL TESTS PASSED");
        $finish;
    end
endmodule
