module sp_module(
    input CLK,
    input Reset,
    input [1:0]SP_OP,
    input PreviousOpSignal,
    output[31:0] SPtoBuffer
);

wire [31:0] InSPReg,Out,Result;


register_32bit_SP SP_Reg(.Clk(CLK), .InData(InSPReg), .Rst(Reset), .OutData(Out));

sp_alu_32bit ALU_Inst(Out,SP_OP,Result);

mux_2x1_32bit MuxAfterALu(.I0(Out),.I1(Result),.S(SP_OP[1]),.O(SPtoBuffer));

mux_2x1_32bit MuxBeforeSP(.I0(Out),.I1(Result),.S(PreviousOpSignal),.O(InSPReg));



endmodule