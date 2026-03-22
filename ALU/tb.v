`timescale 1ns/1ps
module tb;
    reg [7:0]A,B;
    reg [3:0]opcode;
    wire [7:0]result;
    wire carry,borrow,zero,negative,overflow;

    ALU dut(.A(A),.B(B),.opcode(opcode),.result(result),.carry(carry),
            .borrow(borrow),.zero(zero),.negative(negative),.overflow(overflow));
            initial begin
    $monitor("T=%0t op=%b A=%h B=%h | res=%h c=%b b=%b z=%b n=%b ov=%b",
              $time, opcode, A, B, result, carry, borrow, zero, negative, overflow);

    // Basic tests
    opcode = 4'b0000; A = 8'h00; B = 8'h00; #10;
    // Overflow
    opcode = 4'b0000; A = 8'd127; B = 8'd1; #10;
    // Carry
    opcode = 4'b0000; A = 8'hFF; B = 8'h01; #10;
    // Zero
    opcode = 4'b0001; A = 8'h34; B = 8'h34; #10;
    // Negative
    opcode = 4'b0001; A = 8'h10; B = 8'h20; #10;
    $Stop;
end
endmodule