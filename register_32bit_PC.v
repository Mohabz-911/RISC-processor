module register_32bit_PC(
    input Rst,
    input Clk,
    input[31:0] InData,
    input jumpSignal,
    input [31:0]Rdst,
    input interruptSignal,
    input RetRtiCall,
    input [31:0]dataFromWrightBack,
    output reg[31:0] OutData
);

// reg[31:0] Data;
// assign OutData=Data;

always @(posedge Clk)
begin
if(Rst)
  OutData<=32;
else if (jumpSignal) begin
  OutData<=Rdst;
end
else if (interruptSignal) begin
  OutData<=0;
end
else if (RetRtiCall) begin
  OutData<=dataFromWrightBack;
end
else begin
  OutData<=InData;
end
end


endmodule