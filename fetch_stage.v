module fetch_stage(In, Out, Clk, Rst);
localparam number_of_instructions = 5;
input           Clk, Rst;
input [31:0]    In;
output [15:0]   Out;

wire [31:0] PC_out, PC_plus;

instruction_memory im(.Address(PC_out), .Data(Out));


// handle_jumps m(.jmp(jmp), .jc(jc) , .cf(cf) , .jn(jn) , .nf(nf) , .jz(jz) , .zf(zf) , .jmp_signal(jmp_signal));

register_32bit_PC PC(.Rst(Rst), .Clk(Clk), .InData(PC_plus), .OutData(PC_out));

//To be edited
sp_alu_32bit add(PC_out, 2'b10, PC_plus);

//mux_2x1_32bit m(.I0(PC_plus), .I1(In), .S(), .O(NewPC));

endmodule