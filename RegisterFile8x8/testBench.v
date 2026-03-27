`timescale 1ns/1ps
module tb;
    reg clk, writeEnable;
    reg [2:0] readAddr1, readAddr2, writeAddr;
    reg [7:0] writeData;
    wire [7:0] readData1, readData2;

    //clock generation
    initial clk = 0;
    always #10 clk = ~clk;

    RegisterFile dut (
        .clk(clk),
        .writeEnable(writeEnable),
        .readAddr1(readAddr1),
        .readAddr2(readAddr2),
        .writeAddr(writeAddr),
        .writeData(writeData),
        .readData1(readData1),
        .readData2(readData2)
    );

    task testRegisterFile;
        input wE;
        input [2:0] rA1,rA2,wA;
        input [7:0] wD;
        input [7:0] expData1,expData2; //expected data 1 and 2
        begin
            writeEnable=wE;
            readAddr1=rA1;readAddr2=rA2;writeAddr=wA;
            writeData=wD;
            
            @(posedge clk);
            #1;
            if(^readData1 === 1'bx) $display("Error: X detected in data 1");
            else if(readData1 == expData1)begin
                $display("Data 1 readed successfully");
            end 
            else $display("Readed data 1 is wrong");

            if(^readData2 === 1'bx) $display("Error: X detected in data 2");
            else if(readData2 == expData2)begin
                $display("Data 2 readed successfully");
            end 
            else $display("Readed data 2 is wrong");
        end
    endtask

    initial begin
        //testRegisterFile(writeEnable,rA1,rA2,wA,wD,expData1,expData2)//
        //writing
        testRegisterFile(1'b1,3'b000,3'b000,3'b111,8'h12,8'h00,8'h00);
        testRegisterFile(1'b1,3'b000,3'b000,3'b110,8'h34,8'h00,8'h00);
        testRegisterFile(1'b1,3'b000,3'b000,3'b101,8'h56,8'h00,8'h00);
        testRegisterFile(1'b1,3'b000,3'b000,3'b001,8'hDE,8'h00,8'h00);
        //writing and reading seperatly
        testRegisterFile(1'b1,3'b111,3'b000,3'b100,8'h78,8'h12,8'h00);
        testRegisterFile(1'b1,3'b110,3'b101,3'b011,8'h9A,8'h34,8'h56);
        testRegisterFile(1'b1,3'b100,3'b011,3'b010,8'hBC,8'h78,8'h9A);
        testRegisterFile(1'b1,3'b010,3'b001,3'b000,8'hF0,8'hBC,8'hDE);
        //writing and reading same time
        testRegisterFile(1'b1,3'b000,3'b000,3'b000,8'h45,8'h45,8'h45);
        //writeEnable = 0
        testRegisterFile(1'b0,3'b010,3'b110,3'b010,8'h12,8'hBC,8'h34);

        $stop;
        
    end
endmodule
    