module alu_16bit(
    input[15:0] FirstOperand ,
    input[15:0] SeconedOperand,
    input[6:0] OP, 
    input En,
    output[15:0] Result,
    output ZeroFlag,
    output CarryFlag,
    output NegativeFlag
);
reg [16:0] TempResult;

always @(*)begin
    if(En)begin
        case (OP)
        7'b0000_001:TempResult = FirstOperand + SeconedOperand; 
        7'b0000_010:TempResult = FirstOperand - SeconedOperand;
        7'b0000_100:TempResult = FirstOperand & SeconedOperand;
        7'b0001_000:TempResult = FirstOperand | SeconedOperand;
        7'b0010_000:TempResult = (~FirstOperand)&17'hFFFF;
        7'b0100_000:TempResult = FirstOperand >> SeconedOperand;
        7'b1000_000:TempResult = FirstOperand << SeconedOperand;
        endcase
        end
        TempResult[15:0]<=Result;
end


assign ZeroFlag = !Result;
assign Result = TempResult[15:0];
assign CarryFlag = TempResult[16];
assign NegativeFlag = TempResult[15];


endmodule
