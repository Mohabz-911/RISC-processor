`include "includes.v"

module mad_risc_processor(In, Out, Clk, Rst, Int);
input   Clk, Rst, Int;
input  [15:0]    In;//done
output [15:0]    Out;//done
wire [63:0]  i_IF_ID;//done
wire [63:0]  o_IF_ID;//done
wire [132 : 0]  i_ID_EX;
wire [132 : 0]  o_ID_EX;
wire [105 : 0]  i_EX_MEM;
wire [105 : 0]  o_EX_MEM;
wire [57 : 0]  i_MEM_WB;
wire [57 : 0]  o_MEM_WB;

//Buffer between fetch stage and decode stage
//16-bits: Instruction
buffer #(64)IF_ID(Rst, Clk, i_IF_ID, o_IF_ID);

//Buffer between decode stage and execute stage
buffer #(127)ID_EX(Rst, Clk, i_ID_EX, o_ID_EX);

//Buffer between execute and memory stage
buffer #(106)EX_MEM(Rst, Clk, i_EX_MEM, o_EX_MEM);

//Buffer between the memory and writeback stage
buffer #(58)MEM_WB(Rst, Clk, i_MEM_WB, o_MEM_WB);

wire [57:0] FetchInput;//****************************
wire [19:0] WritebackOutput;       //[19]WB + [18:3]data + [2:0]Address
wire [39:0] ForwardBus;
wire [3:0]  LUCU;
assign FetchInput[57:55]=o_EX_MEM[105:103];
assign FetchInput[54:39] = In;

assign FetchInput[38:23] = o_ID_EX[50:35]; //Rsrc value
//assign FetchInput[22:19] = {o_ID_EX[12],o_ID_EX[132:130]};//jump signals
assign FetchInput[22]=o_ID_EX[12];


assign FetchInput[18:3]=  WritebackOutput[19:4];
assign FetchInput[2]= o_ID_EX[7] | o_ID_EX[8];

//ret rti stall int 


assign ForwardBus[15:0] = o_MEM_WB[26:11];  //Memory Rdst value (ALU output)
assign ForwardBus[18:16] = o_MEM_WB[10:8];  //Memory Rdst address
assign ForwardBus[19] = o_MEM_WB[0];        //Memory WB
assign ForwardBus[35:20] = o_EX_MEM[34:19]; //Execute Rdst value (ALU output)
assign ForwardBus[38:36] = o_EX_MEM[15:13]; //Execute Rdst address
assign ForwardBus[39] = o_EX_MEM[0];        //Execute WB
assign LUCU[3] = o_ID_EX[2];                //mem read
assign LUCU[2:0] = o_ID_EX[43:41];          //Rdst address

fetch_stage f(.In(FetchInput), .Out(i_IF_ID), .Clk(Clk), .Rst(Rst));

decode_stage d(.In({o_IF_ID,Int,LUCU}), .Out({FetchInput[21:19],FetchInput[1:0],i_ID_EX}), .writeback(WritebackOutput), .Clk(Clk), .Rst(Rst));

execute_stage e(.In(o_ID_EX[126:25]), .Ctrl(o_ID_EX[24:0]), .Fwd(ForwardBus), .Out(i_EX_MEM), .CLK(Clk), .Reset(Rst));

memory_stage m(.MemoryInput(o_EX_MEM[98:13]), .Ctrl(o_EX_MEM[12:0]), .MemoryOutput(i_MEM_WB), .Reset(Rst), .CLK(Clk));

writeback_stage w(.In(o_MEM_WB), .Out(WritebackOutput));

endmodule