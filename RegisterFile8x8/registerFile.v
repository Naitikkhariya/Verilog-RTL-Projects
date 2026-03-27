module RegisterFile(
    input wire clk,
    input wire writeEnable,
    input wire [2:0]readAddr1,
    input wire [2:0]readAddr2,
    input wire [2:0]writeAddr,
    input wire [7:0]writeData,
    output reg [7:0]readData1,
    output reg [7:0]readData2
);
    reg [7:0] registerFile[0:7];

    always@(posedge clk)begin
        if(writeEnable)begin
            registerFile[writeAddr]<=writeData;//this performed by 3x8 decoder
        end
    end
    //combinational logic for data read
    always@(*)begin
        if(writeEnable && (writeAddr==readAddr1))begin
            readData1=writeData; //bypass for read after write
        end else readData1=registerFile[readAddr1]; //this performed by 8x1 mux
        if(writeEnable && (writeAddr==readAddr2))begin
            readData2=writeData;
        end else readData2=registerFile[readAddr2];
    end
endmodule