module register_16bit_f(Enable, Reset, Clk, InData, OutData);
input Enable, Reset, Clk;
input[15:0] InData;
output[15:0] OutData;

reg[15:0] Data;
assign OutData=Data;

always @(posedge Clk)
begin
  if(Reset)
    Data <= 0;
  else if(Enable)
    Data<=InData;
end


endmodule