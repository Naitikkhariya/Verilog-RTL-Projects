module barrelShifter(
    input wire[7:0] Input_data,
    input wire[2:0] Shift_amt,
    input wire[1:0] Shift_mode,//00 for Logical , 01 for Arithmetic and 10 means Rotate
    input wire dir, // 0 for left Shift and 1 for right Shift
    output reg[7:0] output_data
);
reg [7:0]Stage0,Stage1;
//Shift mode States
localparam Logical = 2'b00,
            Arithmetic = 2'b01,
            Rotate = 2'b10;
always @(*) begin
    Stage0 = Input_data;
    Stage1 = Input_data;
    output_data = Input_data;
    if(dir)begin
        case(Shift_mode)
            Logical:begin
                Stage0 = (Shift_amt[0])? {1'b0,Input_data[7:1]}:Input_data;
                Stage1 = (Shift_amt[1])? {2'b00,Stage0[7:2]}:Stage0;
                output_data = (Shift_amt[2])? {4'b0000,Stage1[7:4]}:Stage1;
            end
            Arithmetic:begin
                Stage0 = (Shift_amt[0])?{Input_data[7],Input_data[7:1]}:Input_data;
                Stage1 = (Shift_amt[1])?{{2{Stage0[7]}},Stage0[7:2]}:Stage0;
                output_data = (Shift_amt[2])?{{4{Stage1[7]}},Stage1[7:4]}:Stage1;
            end
            Rotate:begin
                Stage0 = (Shift_amt[0])?{Input_data[0],Input_data[7:1]}:Input_data;
                Stage1 = (Shift_amt[1])?{Stage0[1:0],Stage0[7:2]}:Stage0;
                output_data = (Shift_amt[2])?{Stage1[3:0],Stage1[7:4]}:Stage1;
            end
            default:begin
                output_data = Input_data;
            end
        endcase
    end else begin
        case(Shift_mode)
            Logical,Arithmetic:begin
                Stage0 = (Shift_amt[0])? {Input_data[6:0],1'b0}:Input_data;
                Stage1 = (Shift_amt[1])? {Stage0[5:0],2'b00}:Stage0;
                output_data = (Shift_amt[2])? {Stage1[3:0],4'b0000}:Stage1;
            end
            Rotate:begin
                Stage0 = (Shift_amt[0])?{Input_data[6:0],Input_data[7]}:Input_data;
                Stage1 = (Shift_amt[1])?{Stage0[5:0],Stage0[7:6]}:Stage0;
                output_data = (Shift_amt[2])?{Stage1[3:0],Stage1[7:4]}:Stage1;
            end
            default:begin
                output_data = Input_data;
            end
        endcase
    end
end
endmodule