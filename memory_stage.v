module memory_stage (MemoryInput, Ctrl, MemoryOutput,  Reset, CLK);
input wire [85:0] MemoryInput;
input wire [12:0] Ctrl;
input wire Reset;
input wire CLK;
output wire [59:0] MemoryOutput;

wire [31:0] AluOut32, SP, Address; 
wire [15:0] DataIn, DataOut;




sp_module SP_Block(.CLK(CLK), .Reset(Reset), .SP_OP(Ctrl[11:10]), .PreviousOpSignal(Ctrl[12]), .SPtoBuffer(SP));

//assign MemoryOutput[59] = Ctrl[11] | Ctrl[10];
//                          (ALU_Output)
append_zeros m(.InputData(MemoryInput[21:6]), .OutputData(AluOut32));

assign Address = (Ctrl[11] | Ctrl[10]) ? SP : AluOut32;

assign DataIn = (Ctrl[3] == 1'b1) ? ((Ctrl[4] == 1'b1) ? MemoryInput[69:54] : MemoryInput[53:38]) : MemoryInput[37:22];

data_memory z(.DataIn(DataIn), .Address(Address), .MemoryRead(Ctrl[2]), .MemoryWrite(Ctrl[1]), .DataOut(DataOut));

assign MemoryOutput = {(Ctrl[11] | Ctrl[10]), Ctrl[2], MemoryInput[85:70] , DataOut , MemoryInput[21:6] , MemoryInput[2:0] , Ctrl[10:5] , Ctrl[0]};

// wire [31:0] OutFromMux; 

// wire SP ;

// // PUSH or POP
// assign SP = MemoryInput[3] | MemoryInput[2];

// // Adress selector MUX
// mux_2x1_32bit n(.I0(out), .I1(MemoryInput[75:44]),  .S(SP), .O(OutFromMux));


// wire [15:0] MemoryDataOut; 

// data_memory z(.DataIn(MemoryInput[43:28]), .Address(out), .MemoryRead(MemoryInput[5]), .MemoryWrite(MemoryInput[4]), .DataOut(MemoryDataOut));


// assign MemoryOutput = {MemoryDataOut, MemoryInput[27:12], MemoryInput[11:9], MemoryInput[8:6], MemoryInput[3:2], MemoryInput[1:0]};



endmodule



