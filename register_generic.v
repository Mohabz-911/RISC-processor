module register_generic#(parameter N=16)(Enable, Reset, Clk, InData, OutData);
input Enable, Reset, Clk;
input[N-1:0] InData;
output[N-1:0] OutData;

reg[N-1:0] Data;
assign OutData=Data;

always @(posedge Clk)
begin
  if(Reset)
    Data <= {N{1'b0}};
  else if(Enable)
    Data<=InData;
  else
    Data<=Data;  
end


endmodule