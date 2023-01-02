module buffer(Rst, Clk, En, InData, OutData);
parameter N = 16;
input Clk, Rst, En;
input[N-1:0] InData;
output[N-1:0] OutData;

reg[N-1:0] Data;
assign OutData = Data;

always @(negedge Clk)
begin
if (Rst)
  Data = 0;
else if(En)
  Data = InData;
else
  Data = Data;
end


endmodule