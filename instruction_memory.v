module instruction_memory(Address, Data);
localparam INSTRUCTION_MEMORY_SIZE = 50;
input      [31:0]   Address;
output reg [15:0]   Data;

reg [15:0] Memory [0:INSTRUCTION_MEMORY_SIZE-1];
initial $readmemb("InstructionMemory.txt", Memory);

always @(*) begin
    Data <= Memory[Address]; 
end

endmodule


//Instruction memory size is 1048576