module data_memory (DataIn, Address, MemoryRead, MemoryWrite, DataOut);

input wire [15:0] DataIn;
input wire [31:0] Address;
input wire  MemoryRead;
input wire  MemoryWrite;

output wire [15:0] DataOut;

reg [15:0] Memory [0:2047];


always @(*) begin 
    if (MemoryWrite == 1'b1) begin
        Memory[Address] <= DataIn;
    end
end


assign DataOut = (MemoryRead == 1'b1) ? Memory[Address] : 16'b1111111111111111;

endmodule