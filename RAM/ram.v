module RAM#(
    parameter ramWidth = 16,
    parameter dataSize = 8
)(
    input wire clk,
    input wire read_en,
    input wire write_en,
    input wire [dataSize-1:0]data_in,
    input wire [$clog2(ramWidth)-1:0]add, //address
    output reg [dataSize-1:0]data_out
);
    //RAM
    reg [dataSize-1:0] ram[0:ramWidth-1];
    always @(posedge clk ) begin
            if(read_en)begin
                data_out<=ram[add];
            end
            if(write_en)begin
                ram[add]<=data_in;
            end
        end
endmodule