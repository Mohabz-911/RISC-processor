module register_32bit(
    input Enable,
    input Clk,
    input[31:0] InData,
    input Reset,
    output[31:0] OutData
);



reg[31:0] Data;
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