module  execute_stage (
    input[69:0] In, 
    output[75:0] Out,
    input Reset,
    input CLK
    );

    wire[15:0] FirstOperand,SeconedOperand,ALU_Result;

    


    mux_2x1_16bit Mux1ForSrc(.I0(In[69:54]),.I1(16'h0),.S(In[4]),.O(FirstOperand));

    mux_2x1_16bit Mux2ForDest(.I0(In[53:38]),.I1(In[31:16]),.S(In[1]),.O(SeconedOperand));

    alu_16bit ALU_inst(.FirstOperand(FirstOperand),.SeconedOperand(SeconedOperand),.OP(In[15:9]),.Result(Out[27:12]),.ZeroFlag(),.CarryFlag(),.NegativeFlag());

    // sp_module SP_Block(.CLK(CLK),.Reset(Reset),.SP_OP(In[6:5]),.PreviousOpSignal(1'b0),.SPtoBuffer(Out[75:44]));
                                                                    //YAMAAAAAAAA

    //RSRC VALUE
    assign Out[43:28]=In[69:54];

    //RSRC ADDRESS      
    assign Out[11:9]=In[37:35];

    //RDST ADDRESS
    assign Out[8:6]=In[34:32];

    //2BITS MEM
    assign Out[5:4]=In[8:7];

    //2BIT SPOP
    assign Out[3:2]=In[6:5];

    //WRITEBACK
    assign Out[1]=In[0];

    //LDD 
    assign Out[0]=In[3];




endmodule