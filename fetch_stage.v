module fetch_stage(In, Out, Clk, Rst);
localparam number_of_instructions = 5;
input           Clk, Rst;
input [57:0]    In;
output [63:0]   Out;

wire [31:0] PC_out, PC_plus;
wire [15:0] instruction;


wire jmp_signal;
wire [31:0] dataFromWrightBack;
wire [31:0] Rdst;

wire [31:0]vars;

append_zeros b(.InputData(In[38:23]) , .OutputData(Rdst));
append_zeros a(.InputData(In[18:3]) , .OutputData(dataFromWrightBack));

instruction_memory im(.Address(PC_out), .Data(instruction));


// check if there is a jump
handle_jumps m(.jmp(In[22]), 
               .jc(In[21]) , 
               .cf(In[57]) , 
               .jn(In[20]) , 
               .nf(In[56]) , 
               .jz(In[19]) , 
               .zf(In[55]) , 
               .jmp_signal(jmp_signal));


// get the value of the pc
register_32bit_PC PC(.Rst(Rst), 
                    .Clk(Clk), 
                    .InData(PC_plus), 
                    .jumpSignal(jmp_signal), 
                    .Rdst(Rdst), 
                    .interruptSignal(In[1]), 
                    .RetRtiCall(In[2]), 
                    .dataFromWrightBack(dataFromWrightBack) , 
                    .OutData(PC_out));

//To be edited
//sp_alu_32bit add(PC_out, 2'b10, PC_plus);
// check for stall
assign PC_plus = (In[0] == 1'b1) ?  PC_out : PC_out + 1; 
//mux_2x1_32bit m(.I0(PC_plus), .I1(In), .S(), .O(NewPC));

assign vars=PC_out + 1'b1;
// out buffer
assign Out = {In[54:39] , vars , instruction};

endmodule