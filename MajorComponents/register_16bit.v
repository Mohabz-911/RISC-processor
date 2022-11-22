module register_16bit(
    input Enable,
    input Clk,
    input Reset,
    input[15:0] InData,
    output[15:0] OutData
);

reg[15:0] Data;
assign OutData=Data;

always @(posedge Clk)
begin
    if(Reset)
        Data=0;
    else 
    begin
        if(Enable)
        Data<=InData;
    end
end



endmodule