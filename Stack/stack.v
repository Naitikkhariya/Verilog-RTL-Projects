module stack #(
    parameter stackSize = 8,
    parameter dataSize = 8
)(
    input wire clk,
    input wire reset,
    input wire push,
    input wire pop,
    input wire [dataSize-1:0]inputData,
    output reg [dataSize-1:0]outputData,
    //stackFull and stackEmpty flags
    output reg stackFull,
    output reg stackEmpty
);
    reg [dataSize-1:0]stack[0:stackSize-1];
    reg [$clog2(stackSize):0]sp;//stack pointer
    // stack pointer represent the next empty slot in stack
    integer i;
    always@(posedge clk or posedge reset)begin
        if(reset)begin
            for(i=0;i<stackSize;i = i+1)begin
                stack[i] <= {dataSize{1'b0}};
            end
            sp <= {$clog2(stackSize){1'b0}};
        end else begin
            case({push,pop})
                2'b10:begin
                    if(sp<stackSize)begin
                        stack[sp]<=inputData;
                        sp <= sp+1;
                    end
                end
                2'b01:begin
                    if(!(sp == 0))begin
                        outputData <= stack[sp-1];
                        sp <= sp-1;
                    end
                end
                2'b11:begin 
                    if(sp == 0)begin // stack is empty then no old value will be pop 
                        stack[sp] <= inputData; // only write 
                        outputData <= inputData; 
                        sp <= sp+1;
                    end else begin // pop old data and push new data at same sp-1 stack position 
                        outputData <= stack[sp-1];
                        stack[sp-1] <= inputData;
                    end
                end
                default : ;
            endcase
        end
    end
    //flag control
    always @(*) begin
        stackFull = (sp == stackSize);
        stackEmpty = (sp == 0);
    end
endmodule