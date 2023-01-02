`include "includes.v"

module mad_risc_processor(In, Out, Clk, Rst, Int);
input   Clk, Rst, Int;
input  [15:0]    In;//done
output [15:0]    Out;//done
wire [63:0]  i_IF_ID;//done
wire [63:0]  o_IF_ID;//done
wire [136 : 0]  i_ID_EX;
wire [136 : 0]  o_ID_EX;
wire [105 : 0]  i_EX_MEM;
wire [105 : 0]  o_EX_MEM;
wire [59 : 0]  i_MEM_WB;
wire [59 : 0]  o_MEM_WB;
// reg [15:0]Out_Port;

//Buffer between fetch stage and decode stage
//16-bits: Instruction
buffer #(64)IF_ID((Rst|o_ID_EX[126]), Clk, 1'b1, i_IF_ID, o_IF_ID);

//Buffer between decode stage and execute stage
buffer #(120)ID_EX((Rst|o_ID_EX[126]), Clk, ((o_ID_EX[134])|(~o_ID_EX[15])), {i_ID_EX[136:135],i_ID_EX[133:40],i_ID_EX[23:0]}, {o_ID_EX[136:135],o_ID_EX[133:40],o_ID_EX[23:0]});
buffer #(17)ID_EX_2((Rst|o_ID_EX[126]), Clk, 1'b1, {i_ID_EX[134], i_ID_EX[39:24]}, {o_ID_EX[134], o_ID_EX[39:24]});

//Buffer between execute and memory stageS
buffer #(106)EX_MEM((Rst|o_ID_EX[126]), Clk, 1'b1, i_EX_MEM, o_EX_MEM);

//Buffer between the memory and writeback stage
buffer #(60)MEM_WB((Rst|o_ID_EX[126]), Clk, 1'b1, i_MEM_WB, o_MEM_WB);

wire [57:0] FetchInput;//****************************
wire [19:0] WritebackOutput;       //[19]WB + [18:3]data + [2:0]Address
wire [39:0] ForwardBus;
wire [3:0]  LUCU;
wire stallSignal;
assign FetchInput[57:55]=o_EX_MEM[105:103];
assign FetchInput[54:39] = In;

assign FetchInput[38:23] = o_EX_MEM[50:35]; //Rsrc value
//assign FetchInput[22:19] = {o_ID_EX[12],o_ID_EX[132:130]};//jump signals
assign FetchInput[22]=o_EX_MEM[102];


assign FetchInput[18:3]=  WritebackOutput[19:4];
assign FetchInput[2]= o_EX_MEM[9] | o_EX_MEM[8];  //RTI or RET
assign FetchInput[21:19]=o_EX_MEM[101:99];  //JC JN JZ
assign FetchInput[1]=o_ID_EX[129];
//ret rti stall int 
assign FetchInput[0]=i_ID_EX[128];

assign ForwardBus[15:0] = (~o_MEM_WB[2])?((o_MEM_WB[58])?o_MEM_WB[41:26]:o_MEM_WB[25:10]):o_MEM_WB[57:42];  //Memory Rdst value
assign ForwardBus[18:16] = o_MEM_WB[9:7];  //Memory Rdst address
assign ForwardBus[19] = o_MEM_WB[0];        //Memory WB
assign ForwardBus[35:20] = (o_EX_MEM[6])?o_EX_MEM[98:83]:o_EX_MEM[34:19]; //Execute Rdst value (ALU output)
assign ForwardBus[38:36] = o_EX_MEM[15:13]; //Execute Rdst address
assign ForwardBus[39] = o_EX_MEM[0];        //Execute WB
assign LUCU[3] = o_ID_EX[2];                //mem read
assign LUCU[2:0] = o_ID_EX[42:40];          //Rdst address

fetch_stage f(.In(FetchInput), .Out(i_IF_ID), .Clk(Clk), .Rst(Rst));

decode_stage d(.In({o_IF_ID,Int,LUCU}), .Out(i_ID_EX), .writeback({o_ID_EX[15], WritebackOutput}), .Clk(Clk), .Rst(Rst));
//{FetchInput[21:19],FetchInput[1:0],
//ctrl plus second iteration
execute_stage e(.In({o_ID_EX[132:130],o_ID_EX[125:24]}), .Ctrl({o_ID_EX[136:135],o_ID_EX[133],o_ID_EX[124],o_ID_EX[23:0]}), .Fwd(ForwardBus), .Out(i_EX_MEM), .CLK(Clk), .Reset(Rst));

memory_stage m(.MemoryInput(o_EX_MEM[98:13]), .Ctrl({o_MEM_WB[59],o_EX_MEM[11:0]}), .MemoryOutput(i_MEM_WB), .Reset(Rst), .CLK(Clk));

writeback_stage w(.In(o_MEM_WB[57:0]), .Out({Out,WritebackOutput}), .clk(Clk), .rst(Rst));


// assign Out_Port=

endmodule