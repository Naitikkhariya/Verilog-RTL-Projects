`timescale 1ns/1ps
module tb;
    reg clk,read_en,write_en;
    reg [7:0] data_in;
    reg [3:0] add;
    wire [7:0] data_out;

    initial clk = 0;
    always #5 clk = ~clk;

    RAM dut(.clk(clk),
            .read_en(read_en),
            .write_en(write_en),
            .data_in(data_in),
            .add(add),
            .data_out(data_out));

    task RamTest(
        input re_en,wr_en,
        input [7:0]da_in,
        input [3:0]ad
    );
        begin
            @(negedge clk);
            read_en=re_en;write_en=wr_en;
            data_in=da_in;
            add=ad;
    
            @(posedge clk);
            #1;
            $display("Time=%t|clk=%b|read_en=%b|write_en=%b|data_in=%b|add=%b|data_out=%b",
            $time,clk,read_en,write_en,data_in,add,data_out);
        end
    endtask

    initial begin
        //for write_en high
        RamTest(0,1,8'h12,4'h0);
        RamTest(0,1,8'h23,4'h3);
        RamTest(0,1,8'h45,4'h5);
        RamTest(0,1,8'h56,4'h8);
        RamTest(0,1,8'h67,4'hE);

        //for read_en High
        RamTest(1,0,8'h12,4'h5);//read data should be 8'h45
        RamTest(1,0,8'hAB,4'hE);//read data should be 8'h67
        RamTest(1,0,8'hCD,4'h2);//read data should be xxxxxxxx

        //for read_en and write_en High
        RamTest(1,1,8'hAD,4'h3);//read data should be 8'h23
        RamTest(1,1,8'h56,4'h3);//read data should be 8'hAD

        #20;
        $stop;
    end
endmodule