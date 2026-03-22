module ALU(
    input wire [7:0]A,
    input wire [7:0]B,
    input wire [3:0]opcode,
    output reg [7:0]result,
    output reg carry,
    output reg borrow,
    output reg zero,
    output reg negative,
    output reg overflow
);
localparam result_add = 4'b0000,
            result_sub = 4'b0001,
            result_and = 4'b0010,
            result_or = 4'b0011,
            result_xor = 4'b0100,
            result_not = 4'b0101,
            shift_left = 4'b0110,
            shift_right = 4'b0111;
reg [8:0]temp;
    always@(*)begin
        temp = 9'h000;
        result=8'h00;
        carry = 1'b0;
        overflow = 1'b0;
        borrow = 1'b0;
        case(opcode)
            result_add:begin
                temp = A+B;
                result=temp[7:0];
                carry = temp[8];
                overflow = (A[7]==B[7]) && (result[7]!=A[7]);
            end
            result_sub:begin
                temp = A-B;
                result=temp[7:0];
                borrow = A<B;
                overflow = (A[7]!=B[7]) && (result[7]!=A[7]);
            end
            result_and:result=A&B;
            result_or:result=A|B;
            result_xor:result=A^B;
            result_not:result=~A;
            shift_left:begin
                result = A<<1;
                carry = A[7];
            end
            shift_right:begin
                result = A>>1;
                carry = A[0];
            end
            default: begin
                result = 8'h00;
            end
        endcase
        zero = (result == 8'h00);
            negative = result[7];
    end
endmodule