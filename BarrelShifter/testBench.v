`timescale 1ns/1ps
module tb;
    reg [7:0]Input_data;
    reg [2:0]Shift_amt;
    reg [1:0]Shift_mode;
    reg dir;
    wire [7:0]output_data;

    barrelShifter dut(.Input_data(Input_data),.Shift_amt(Shift_amt),.Shift_mode(Shift_mode),
                        .dir(dir),.output_data(output_data));
    
    initial begin
        $monitor("T=%0t|Input_data=%b|Shift_amt=%b|Shift_mode=%b|dir=%b|output_data=%b",
        $time,Input_data,Shift_amt,Shift_mode,dir,output_data);

        Input_data = 8'b10101011;Shift_amt=3'b101;
        dir=1'b1;
        Shift_mode=2'b00;#10;
        Shift_mode=2'b10;#10;
        Shift_mode=2'b01;#10;
        dir=1'b0;
        Shift_mode=2'b00;#10;
        Shift_mode=2'b10;#10;
        Shift_mode=2'b01;#10;

        Input_data = 8'b01010101;Shift_amt=3'b001;
        dir=1'b1;
        Shift_mode=2'b00;#10;
        Shift_mode=2'b10;#10;
        Shift_mode=2'b01;#10;
        dir=1'b0;
        Shift_mode=2'b00;#10;
        Shift_mode=2'b10;#10;
        Shift_mode=2'b01;#10;

        Input_data = 8'hA5;Shift_amt = 3'b000;
        dir = 0;
        Shift_mode = 2'b00; #10;
        if (output_data !== 8'hA5) $display("ERROR: Shift by 0 failed!");

        Input_data = 8'hA5;Shift_amt = 3'b111;
        dir = 1;
        Shift_mode = 2'b10; #10;
        if (output_data !== 8'h4B) begin
            $display("ERROR: Shift by 7 failed in rotate!");
        end
        $stop;
    end
endmodule