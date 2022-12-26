module buffer(Rst, Clk, InData, OutData);
parameter N = 16;
input Clk, Rst;
input[N-1:0] InData;
output[N-1:0] OutData;

reg[N-1:0] Data;
assign OutData = Data;

always @(negedge Clk)
begin
if (Rst)
  Data <= 0;
else
  Data <= InData;
end


endmodule