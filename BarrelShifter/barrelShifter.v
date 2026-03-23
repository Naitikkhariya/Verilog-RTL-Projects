module barrelShifter(
    input wire[7:0] Input_data,
    input wire[2:0] Shift_amt,
    input wire[1:0] Shift_mode,//00 for Logical , 01 for Arithmetic and 10 means Rotate
    input wire dir, // 0 for left Shift and 1 for right Shift
    output reg[7:0] output_data
);

reg [7:0]Stage0_out,Stage1_out;
//Shift mode States
localparam Logical = 2'b00,
            Arithmetic = 2'b01,
            Rotate = 2'b10;
always @(*) begin
    Stage0_out = 8'd0;
    Stage1_out = 8'd0;
    output_data = 8'd0;
    if(dir)begin
        case(Shift_mode)
            Logical:begin
                Stage0_out = (Shift_amt[0])? {1'b0,Input_data[7:1]}:Input_data;
                Stage1_out = (Shift_amt[1])? {2'b00,Stage0_out[7:2]}:Stage0_out;
                output_data = (Shift_amt[2])? {4'b0000,Stage1_out[7:4]}:Stage1_out;
            end
            Arithmetic:begin
                Stage0_out = (Shift_amt[0])?{Input_data[7],Input_data[7:1]}:Input_data;
                Stage1_out = (Shift_amt[1])?{{2{Input_data[7]}},Stage0_out[7:2]}:Stage0_out;
                output_data = (Shift_amt[2])?{{4{Input_data[7]}},Stage1_out[7:4]}:Stage1_out;
            end
            Rotate:begin
                Stage0_out = (Shift_amt[0])?{Input_data[0],Input_data[7:1]}:Input_data;
                Stage1_out = (Shift_amt[1])?{Stage0_out[1:0],Stage0_out[7:2]}:Stage0_out;
                output_data = (Shift_amt[2])?{Stage1_out[3:0],Stage1_out[7:4]}:Stage1_out;
            end
            default:begin
                Stage0_out=8'd0;
                Stage1_out=8'd0;
                output_data = 8'd0;
            end
        endcase
    end else begin
        case(Shift_mode)
            Logical,Arithmetic:begin
                Stage0_out = (Shift_amt[0])? {Input_data[6:0],1'b0}:Input_data;
                Stage1_out = (Shift_amt[1])? {Stage0_out[5:0],2'b00}:Stage0_out;
                output_data = (Shift_amt[2])? {Stage1_out[3:0],4'b0000}:Stage1_out;
            end
            Rotate:begin
                Stage0_out = (Shift_amt[0])?{Input_data[6:0],Input_data[7]}:Input_data;
                Stage1_out = (Shift_amt[1])?{Stage0_out[5:0],Stage0_out[7:6]}:Stage0_out;
                output_data = (Shift_amt[2])?{Stage1_out[3:0],Stage1_out[7:4]}:Stage1_out;
            end
            default:begin
                Stage0_out=8'd0;
                Stage1_out=8'd0;
                output_data = 8'd0;
            end
        endcase
    end
end
endmodule