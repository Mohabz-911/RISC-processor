module alu_16bit(
    input[15:0] FirstOperand ,
    input[15:0] SeconedOperand,
    input[6:0] OP, 
    input En,
    output [15:0] Result,
    output ZeroFlag,
    output CarryFlag,
    output NegativeFlag
);
reg [15:0] TempResult;
reg TempBit;
always @(*)begin
    if(En)begin
        case (OP)
        7'b0000_001:{TempBit,TempResult} = FirstOperand + SeconedOperand; 
        7'b0000_010:{TempBit,TempResult} = FirstOperand - SeconedOperand;
        7'b0000_100:{TempBit,TempResult} = FirstOperand & SeconedOperand;
        7'b0001_000:{TempBit,TempResult} = FirstOperand | SeconedOperand;
        7'b0010_000:{TempBit,TempResult} = (~FirstOperand)&17'hFFFF;
        7'b0100_000:{TempBit,TempResult} = FirstOperand >> SeconedOperand;
        7'b1000_000:{TempBit,TempResult} = FirstOperand << SeconedOperand;
        endcase
    end

end


assign ZeroFlag = !Result;
assign Result = TempResult;
assign CarryFlag = TempBit;
assign NegativeFlag = TempResult[15];


endmodule
