module register_32bit_PC(
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
  Data<=32;
else
  Data<=InData;
end


endmodule