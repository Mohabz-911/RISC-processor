module sp_alu_32bit(
    input[31:0] SPValue,
    input[1:0] OP,
    output reg [31:0] Result
);

always @(*)
begin
case (OP)
2'b01:Result=SPValue-1;
2'b10:Result=SPValue+1;
default:Result=SPValue;
endcase
end

endmodule