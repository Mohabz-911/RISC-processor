module register_16bit(
    input Enable,
    input Clk,
    input[15:0] InData,
    output[15:0] OutData
);

reg[15:0] Data;
assign OutData=Data;

always @(posedge Clk & Enable)
begin
  Data<=InData;
end


endmodule