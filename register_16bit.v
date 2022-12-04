module register_16bit(Rst, Clk, InData, OutData);
input Rst, Clk;
input[15:0] InData;
output[15:0] OutData;

reg[15:0] Data;
assign OutData=Data;

always @(posedge Clk)
begin
  if(Rst)
    Data <= 0;
  else
    Data<=InData;
end


endmodule