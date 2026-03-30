`timescale 1ns/1ps
module stackTb;
    reg clk, reset, push, pop;
    reg [7:0] inputData;
    wire [7:0] outputData;
    wire stackFull, stackEmpty;

    initial clk = 0;
    always #5 clk = ~clk; 

    stack #(
        .stackSize(8),
        .dataSize(8)
    ) dut (
        .clk(clk),
        .reset(reset),
        .push(push),
        .pop(pop),
        .inputData(inputData),
        .outputData(outputData),
        .stackFull(stackFull),
        .stackEmpty(stackEmpty)
    );

    task testStack(
        input i_reset, 
        input i_push, 
        input i_pop, 
        input [7:0] i_data
    );
    begin
        @(negedge clk); //change inputs at negative edge
        reset = i_reset;
        push = i_push;
        pop = i_pop;
        inputData = i_data;
        
        @(posedge clk);
        #1;
        $display("Time:%0t | Push:%b Pop:%b DataIn:%h | DataOut:%h | Empty:%b Full:%b", 
                  $time, push, pop, inputData, outputData, stackEmpty, stackFull);
    end
    endtask

    initial begin
        reset = 1; push = 0; pop = 0; inputData = 0;
        #20 reset = 0;

        //push = 1 and pop = 0
        testStack(0,1,0,8'h12); // Push 12
        testStack(0,1,0,8'h21); // Push 21
        testStack(0,1,0,8'h34); // Push 34

        //push = 0 and pop = 1
        testStack(0,0,1,8'h00); // Should output 34
        testStack(0,0,1,8'h00); // Should output 21

        //pop = 1 and push = 1 
        testStack(0,1,1,8'h99); // 12 pop out and  99 push and  sp will remain same.

        //push 8 time to check stackFull = 1
        repeat(8) testStack(0,1,0,$random);

        //reset = 1
        testStack(1,0,0,8'h11); //gives stackEmpty = 1

        //push = 1 and pop = 1 when sp = 0
        testStack(0,1,1,8'h21);//not pop but push 21

        #50;
        $display("Test Finished");
        $stop;
    end
endmodule