`include "mux_2x1_1bit.v"
`include "mux_2x1_16bit.v"
`include "mux_2x1_32bit.v"
`include "sp_module.v"
`include "alu_16bit.v"

module  execute_stage (
    input[69:0] In, 
    output[75:0] Out,
    input Reset,
    input CLK,
    input Enable 
    );

    wire [15:0] RsrsValue, RdstValue;

    wire[15:0] FirstOperand,SeconedOperand,ALU_Result;

    wire ImOrSingleOp;
   
    mux_2x1_16bit Mux1ForDest(.I0(In[68:53]),.I1(16'h0),.S(In[3]),.O(FirstOperand));

    mux_2x1_16bit Mux2ForSrc(.I0(In[52:37]),.I1(In[30:15]),.S(In[1]),.O(SeconedOperand));

    alu_16bit ALU_inst(.FirstOperand(FirstOperand),.SeconedOperand(SeconedOperand),.OP(In[14:8]),.Result(Out[27:12]),.ZeroFlag(),.CarryFlag(),.NegativeFlag());

    sp_module SP_Block(.CLK(CLK),.Enable(Enable),.Reset(Reset),.SP_OP(In[5:4]),.PreviousOpSignal(In[69]),.SPtoBuffer(Out[75:44]));
    

    //RSCRS VALUE
    assign Out[43:28]=In[68:53];

    //RSCRS ADDRESS      
    assign Out[11:9]=In[36:34];

    //RDST ADDRESS
    assign Out[8:6]=In[33:31];

    //2BITS MEM
    assign Out[5:4]=In[7:6];

    //2BIT SPOP
    assign Out[3:2]=In[5:4];

    //WRITEBACK
    assign Out[1]=In[0];

    //LDD 
    assign Out[0]=In[2];




endmodule