module memory_stage (MemoryInput, MemoryOutput);
input wire [75:0] MemoryInput;
output wire [41:0] MemoryOutput;

wire [31:0] out; 

//                          (ALU_Output)
append_zeros m(.InputData(MemoryInput[27:12]), .OutputData(out));


wire [31:0] OutFromMux; 

wire SP ;

// PUSH or POP
assign SP = MemoryInput[3] | MemoryInput[2];

// Adress selector MUX
mux_2x1_32bit n(.I0(out), .I1(MemoryInput[75:44]),  .S(SP), .O(OutFromMux));


wire [15:0] MemoryDataOut; 

data_memory z(.DataIn(MemoryInput[43:28]), .Address(out), .MemoryRead(MemoryInput[5]), .MemoryWrite(MemoryInput[4]), .DataOut(MemoryDataOut));


assign MemoryOutput = {MemoryDataOut, MemoryInput[27:12], MemoryInput[11:9], MemoryInput[8:6], MemoryInput[3:2], MemoryInput[1:0]};



endmodule



