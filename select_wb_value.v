module select_wb_value(DataOut, AluOutput, MemorySignal, InPort, InSignal, WBValue);
input [15:0]    DataOut, AluOutput, InPort;
input MemorySignal, InSignal;
output [15:0]   WBValue;

assign WBValue = (InSignal == 1'b1) ? InPort :
                 (MemorySignal == 1'b1) ? DataOut : AluOutput;

endmodule