module  execute_stage (
input [104:0]In, 
input [24:0]Ctrl, 
input [39:0]Fwd, 
output[105:0] Out, 
input Reset, 
input CLK
);

/*
16-bit: In port
32-bit: Address of next instruction
16-bit: Rsrc value
16-bit: Rdst value
3-bit:  Rsrc Address
3-bit:  Rdst Address
16-bit: Imm value
*/

wire[15:0] InPort;//passed
wire[31:0] AddressNxtInstruction; //passed
wire[15:0] RsrcValue;//used //passed
wire[15:0] RdstValue;//used
wire[2:0]  RsrcAddress;// used //passed
wire[2:0]  RdstAddress; //used //passed
wire[15:0] ImmValue;//used

assign InPort=In[101:86];
assign AddressNxtInstruction=In[85:54];
assign RsrcValue=In[53:38];
assign RdstValue=In[37:22];
assign RsrcAddress=In[21:19];
assign RdstAddress=In[18:16];
assign ImmValue=In[15:0];
///////////////////////////////////////////////////


/*
Ctrl: 25-bits
7-bit:  ALU-Control
1-bit:  ALU_enable
1-bit:  Immediate value or single-op instructions except CALL
1-bit:  STD
1-bit:  JMP
1-bit:  Flags Protection
1-bit:  Previous stack op
1-bit:  PUSH
1-bit:  POP
1-bit:  RET
1-bit:  RTI
1-bit:  LDD
1-bit:  IN
1-bit:  OUT
1-bit:  second iteration
1-bit:  CALL
1-bit:  Memory read
1-bit:  Memory write
1-bit:  WB signal 
*/

wire [6:0]  ALU_Control;//used
wire ALU_Enable;
wire ImmSingOpInst;//used
wire STD;// used
wire JMP;//used
wire FlagsProtection; //used
wire PrvsStackOp;//passed
wire PUSH;//passed
wire POP;//passed
wire RET;//passed
wire RTI;//passed
wire LDD;//passed
wire IN;//passed
wire OUT;//used
wire ScndIteration;//passed
wire CALL;//used
wire MemRead;//Passed
wire MemWrite;//Passed
wire WB_Signal; //Passed 
wire LDM;

assign ScndIteration = Ctrl[24];

assign ALU_Enable = Ctrl[23];//fo2 a faireeeeee
assign ALU_Control = Ctrl[22:16];


//ldm whereeeeeee????????? bit
assign LDM=Ctrl[15]; //5odouha entou me7tagynha 8aleban


//why no jz jc jn???????????? In[104:102] ###############
//hereeeeeeeeeeeeeeeee watch outttttttttttttttttttttttttt

assign ImmSingOpInst = Ctrl[14];
assign STD = Ctrl[13];
assign JMP = Ctrl[12];
assign FlagsProtection = Ctrl[11];


assign PrvsStackOp = 1'b0;// whattttttttttt on earth is thisssssssssssssssssssss
//this is a loop from execute to memo to decode 
//enjoyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy


assign PUSH = Ctrl[10];
assign POP = Ctrl[9];
assign RET = Ctrl[8];
assign RTI = Ctrl[7];
assign LDD = Ctrl[6];
assign IN = Ctrl[5];
assign OUT = Ctrl[4];
assign CALL = Ctrl[3];
assign MemRead = Ctrl[2];
assign MemWrite = Ctrl[1];
assign WB_Signal = Ctrl[0];


//////////////////////////////////////


/*
Fwd: 40-bits        (These are inputs)
1-bit:  Execute Rdst WB
3-bit:  Execute Rdst Address
16-bit: Execute Rdst value
1-bit:  Memory Rdst WB
3-bit:  Memory Rdst Address
16-bit: Memory Rdst value
*/


wire ExRdst_WB;
wire [2:0]  ExRdstAddress;
wire [15:0] ExRdstVal;
wire MemRdst_WB;
wire [2:0]  MemRdstAddress;
wire [15:0] MemRdstVal;


assign ExRdst_WB = Fwd[39];
assign ExRdstAddress = Fwd[38:36]; 
assign ExRdstVal = Fwd[35:20];
assign MemRdst_WB = Fwd[19];
assign MemRdstAddress = Fwd[18:16];
assign MemRdstVal = Fwd[15:0];

//////////////////////////////////////////////////////////////

wire [15:0] FWD_Result1,FWD_Result2;
wire Ctrl1,Ctrl2;
forwarding_unit FWD(
ExRdst_WB,ExRdstAddress,ExRdstVal,
MemRdst_WB,MemRdstAddress,MemRdstVal,
RsrcAddress,RdstAddress,
FWD_Result1,Ctrl1,
FWD_Result2,Ctrl2
);

wire [15:0] IntrRsrcVal; //THIS WIRE COMES FROM THE MUX WHICH CHOOSE BETWEEN  REAL RSRC COMES FROM REGISTER FILE OR THE FIRST VALUE COMES FROM THE FORWARDING UINT
wire [15:0] IntrRdstVal; //THIS WIRE COMES FROM THE MUX WHICH CHOOSE BETWEEN  REAL RDST COMES FROM REGISTER FILE OR THE SECOMD VALUE COMES FROM THE FORWARDING UINT

    //THIS IS THE MUX WHICH USED TO CHOOSE BETWEEN REAL RSRC COMES FROM REGISTER FILE OR THE FIRST VALUE COMES FROM THE FORWARDING UINT
    mux_2x1_16bit Mux1ForRsrcOrFWDval(.I0(RsrcValue),.I1(FWD_Result1),.S(Ctrl1),.O(IntrRsrcVal));

    //THIS IS THE MUX WHICH USED TO CHOOSE BETWEEN REAL RSRC COMES FROM REGISTER FILE OR THE SECOMD VALUE COMES FROM THE FORWARDING UINT
    mux_2x1_16bit Mux1ForRdstOrFWDval(.I0(RdstValue),.I1(FWD_Result2),.S(Ctrl2),.O(IntrRdstVal));

    //THIS IS THE WIRE COMES FROM THE MUX WHICH CHOOSES BETWEEN THE RSRC VALUE OR 0 IN CASE OF JUMP, STD , CALL OR OUT SIGNALS
    wire [15:0] FirstOperand;
    //THIS IS THE WIRE COMES FROM THE MUX WHICH CHOOSES BETWEEN THE RDST VALUE OR IMMDEDIATE VALUE IN CASE OF SINGLE OPERAND INSTRUCTIONS 
    wire [15:0] SeconedOperand;

    wire Mux3Selectror;
    assign Mux3Selectror=CALL|JMP|OUT|STD|LDM;

    wire [15:0] ALU_Result;

    mux_2x1_16bit Mux3ForSrc(.I0(IntrRsrcVal),.I1(16'h0),.S(Mux3Selectror),.O(FirstOperand));

    mux_2x1_16bit Mux4ForDest(.I0(IntrRdstVal),.I1(ImmValue),.S(ImmSingOpInst),.O(SeconedOperand));

    alu_16bit ALU_inst(.FirstOperand(FirstOperand),.SeconedOperand(SeconedOperand),.OP(ALU_Control),.Result(ALU_Result),.ZeroFlag(ZF),.CarryFlag(CF),.NegativeFlag(NF), .En(ALU_Enable));


    wire[2:0] InFlags,OutFlags;

    assign InFlags [0]=CF; 
    assign InFlags [1]=NF;
    assign InFlags [2]=ZF;

    // THIS IS THE REGISTER WHICH STORE THE PREVIOUS FlAGS  VLAUE IF FlagsProtection SIGNAL IS HIGH
    register_generic #(3) FlagsPrtcReg(.InData(InFlags),.OutData(OutFlags),.Reset(Reset),.Clk(CLK),.Enable(FlagsProtection));



    wire JC,JN,CF,NF,JZ,ZF;

    
    assign JC=(OutFlags[0])?1'b1:1'b0;
    assign JN=(OutFlags[1])?1'b1:1'b0;
    assign JZ=(OutFlags[2])?1'b1:1'b0;

/*
Out: 106-bits
7-bit:  Jump signals (JMP - JC - CF - JN - NF - JZ - ZF)
16-bit: In port
32-bit: Address of next instruction
16-bit: Rsrc value
16-bit: ALU output
3-bit:  Rsrc Address
3-bit:  Rdst Address
1-bit:  Previous stack op
1-bit:  PUSH
1-bit:  POP
1-bit:  RET
1-bit:  RTI
1-bit:  LDD
1-bit:  IN
1-bit:  OUT
1-bit:  second iteration
1-bit:  CALL
1-bit:  Memory read
1-bit:  Memory write
1-bit:  WB signal  
*/  

    assign Out[105]=OutFlags[0];/////CarryFlag
    assign Out[104]=OutFlags[1];////NegativeFlag
    assign Out[103]=OutFlags[2];////ZeroFlag
    assign Out[102]=JMP;
    assign Out[101]=JC;
    assign Out[100]=JN;
    assign Out[99]=JZ;
    assign Out[98:83]=InPort;
    assign Out[82:51]=AddressNxtInstruction;
    assign Out[50:35]=RsrcValue;
    assign Out[34:19]=ALU_Result;
    assign Out[18:16]=RsrcAddress;
    assign Out[15:13]=RdstAddress;
    assign Out[12]=PrvsStackOp;
    assign Out[11]=PUSH;
    assign Out[10]=POP;
    assign Out[9]=RET;
    assign Out[8]=RTI;
    assign Out[7]=LDD;
    assign Out[6]=In;
    assign Out[5]=OUT;
    assign Out[4]=ScndIteration;
    assign Out[3]=CALL;
    assign Out[2]=MemRead;
    assign Out[1]=MemWrite;
    assign Out[0]=WB_Signal;


endmodule