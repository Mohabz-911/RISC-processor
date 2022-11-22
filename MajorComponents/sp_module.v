`include"register_32bit.v"
`include "SP_ALU_32bit.v"
`include "mux_2x1_32bit.v"
module sp_module(
    input CLK,
    input Enable,
    input popSignal,
    input PushSignal,
    input PreviousPoPSignal,
    input Reset,
    output[31:0] SPtoBuffer
);

wire [31:0] InSPReg,Out,Result;

wire [1:0] SP_OP;


assign SP_OP={popSignal.PushSignal};

register_32bit SP_Reg(Enable,CLK,Reset,InSPReg,Out);

SP_ALU_32bit ALU_Inst(Out,SP_OP,Result);

mux_2x1_32bit MuxAfterALu(.I0(Out),.I1(Result),.S(popSignal),.O(SPtoBuffer));

mux_2x1_32bit MuxBeforeSP(.I0(Out),.I1(Result),.S(PreviousPoPSignal),.O(InSPReg));



endmodule