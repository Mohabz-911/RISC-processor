`include "data_memory.v"
`include "append_zeros.v"
`include "mux_2x1_32bit.v"

module memory_stage (MemoryInput, MemoryOutput);
input wire [75:0] MemoryInput;
output wire [41:0] MemoryOutput;

wire [31:0] out; 

append_zeros m(.InputData(MemoryInput[27:12]), .OutputData(out));


wire [31:0] OutFromMux; 

wire SP ;

assign SP = MemoryInput[3] | MemoryInput[2];


mux_2x1_32bit n(out, MemoryInput[75:44],  SP, OutFromMux);


wire [15:0] MemoryDataOut; 

data_memory z(.DataIn(MemoryInput[43:28]), .Address(OutFromMux), .MemoryRead(MemoryInput[5]), .MemoryWrite(MemoryInput[4]), .DataOut(MemoryDataOut));


assign MemoryOutput = {MemoryDataOut, MemoryInput[27:12], MemoryInput[11:9], MemoryInput[8:6], MemoryInput[3:2], MemoryInput[1:0]};



endmodule



