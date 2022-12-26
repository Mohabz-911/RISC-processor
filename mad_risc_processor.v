`include "includes.v"

module mad_risc_processor(Clk, Rst);
input   Clk, Rst;
wire [15:0]  i_IF_ID;
wire [15:0]  o_IF_ID;
wire [69 : 0]  i_ID_EX;
wire [69 : 0]  o_ID_EX;
wire [75 : 0]  i_EX_MEM;
wire [75 : 0]  o_EX_MEM;
wire [41 : 0]  i_MEM_WB;
wire [41 : 0]  o_MEM_WB;

//Buffer between fetch stage and decode stage
//16-bits: Instruction
buffer #(16)IF_ID(Rst, Clk, i_IF_ID, o_IF_ID);



//Buffer between decode stage and execute stage
    /*70 bits:
    1-bit: LDM signal
    1-bit: Write back signal        /////////////////// What is it for?
    16-bit: Rsrc value
    16-bit: Rdst value
    3-bit: Rsrc address
    3-bit: Rdst address
    16-bit: Immediate value

    7-bit: ALU Control signals
     ============
    add
    sub
    and
    or
    not
    shr
    shl 
     =============

    2-bit: Memory read & write signals
    ====================
    mem-read
    mem-write
    ====================
   
    2-bit: Stack operation signals
    =================
    push
    pop
    =================
    1-bit: std signal
    1-bit: LDD signal
    1-bit: Immediate or single-op instruction signal
    */
buffer #(70)ID_EX(Rst, Clk, i_ID_EX, o_ID_EX);


//Buffer between execute and memory stage
/*76 bits:
    32-bit: Stack pointer
    16-bit: Rsrc value
    16-bit: ALU output
    3-bit: Rsrc address
    3-bit: Rdst address
    1-bit: Memory read signal
    1-bit: Memory write signal
    1-bit: PUSH operation signals
    1-bit: POP operation signals
    1-bit: Write back signal        /////////////////// What is it for?
    1-bit: LDD signal
*/
buffer #(76)EX_MEM(Rst, Clk, i_EX_MEM, o_EX_MEM);

//Buffer between the memory and writeback stage
/*42 bits:
    16-bit: Memory Data out
    16-bit: ALU output
    3-bit: Rsrc address
    3-bit: Rdst address
    1-bit: PUSH operation signals
    1-bit: POP operation signals
    1-bit: Write back signal        /////////////////// What is it for?
    1-bit: LDD signal
*/
buffer #(42)MEM_WB(Rst, Clk, i_MEM_WB, o_MEM_WB);

wire [31:0] JumpAddress;
wire [19:0] WritebackOutput;       //[18:3]data + [2:0]Address

fetch_stage f(.In(JumpAddress), .Out(i_IF_ID), .Clk(Clk), .Rst(Rst));

decode_stage d(.In(o_IF_ID), .Out(i_ID_EX), .writeback(WritebackOutput), .Clk(Clk), .Rst(Rst));

execute_stage e(.In(o_ID_EX), .Out(i_EX_MEM), .CLK(Clk), .Reset(Rst));

memory_stage m(.MemoryInput(o_EX_MEM), .MemoryOutput(i_MEM_WB));

writeback_stage w(.In(o_MEM_WB), .Out(WritebackOutput));

endmodule