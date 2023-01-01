`include "forwarding_unit.v"
`include "mux_2x1_16bit.v"
`include "alu_16bit.v"
`include "mux_2x1_1bit.v"
module  execute_stage (
input [101:0]In, 
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

assign InPort=In[101:85];
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
wire FlagsProtection;
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


assign ALU_Control = Ctrl[24:18];
assign ALU_Enable = Ctrl[17];
assign ImmSingOpInst = Ctrl[16];
assign STD = Ctrl[15];
assign JMP = Ctrl[14];
assign FlagsProtection = Ctrl[13];
assign PrvsStackOp = Ctrl[12];
assign PUSH = Ctrl[11];
assign POP = Ctrl[10];
assign RET = Ctrl[9];
assign RTI = Ctrl[8];
assign LDD = Ctrl[7];
assign IN = Ctrl[6];
assign OUT = Ctrl[5];
assign ScndIteration = Ctrl[4];
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
assign ExRdstVal = Fwd[35:15];
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
    assign Mux3Selectror=CALL|JMP|OUT|STD;

    wire [15:0] ALU_Result;

    mux_2x1_16bit Mux3ForSrc(.I0(IntrRsrcVal),.I1(16'h0),.S(Mux3Selectror),.O(FirstOperand));

    mux_2x1_16bit Mux4ForDest(.I0(IntrRdstVal),.I1(ImmValue),.S(ImmSingOpInst),.O(SeconedOperand));

    alu_16bit ALU_inst(.FirstOperand(FirstOperand),.SeconedOperand(SeconedOperand),.OP(ALU_Control),.Result(ALU_Result),.ZeroFlag(ZF),.CarryFlag(CF),.NegativeFlag(NF));

    wire JC,JN,CF,NF,JZ,ZF;
    assign JC=(CF)?1'b1:1'b0;
    assign JN=(NF)?1'b1:1'b0;
    assign JZ=(ZF)?1'b1:1'b0;

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

    assign Out[105]=CF;
    assign Out[104]=NF;
    assign Out[103]=ZF;
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