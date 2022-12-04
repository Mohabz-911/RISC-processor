module register_32bit_SP(
    input Rst,
    input Clk,
    input[31:0] InData,
    output[31:0] OutData
);

reg[31:0] Data;
assign OutData=Data;

always @(posedge Clk)
begin
if(Rst)
  Data<=2047;
else
  Data<=InData;
end


endmodule