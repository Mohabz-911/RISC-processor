module decode_stage (In, Out, writeback, Rst, Clk);
input [15:0]    In;
input [19:0]    writeback;
output [69:0]       Out;
input           Rst, Clk;

wire [2:0]  Rsrc_address, Rdst_address, WritebackAddress;
wire [15:0] Rsrc, Rdst, WritebackData;
wire WB;
wire [15:0] Imm_value;

assign WritebackAddress = writeback[2:0];
assign WritebackData = writeback[18:3];
assign WB = writeback[19];
assign Rsrc_address = In[10:8];
assign Rdst_address = In[7:5];

register_file rf(.ReadRegister1(Rsrc_address), .ReadRegister2(Rdst_address), .WriteRegister(WritebackAddress), .WriteEnable(WB), .Clk(Clk), .Reset(Rst), .WriteData(WritebackData), .ReadData1(Rsrc), .ReadData2(Rdst));

assign Out[69:54] = Rsrc;
assign Out[53:38] = Rdst;
assign Out[37:35] = Rsrc_address;
assign Out[34:32] = Rdst_address;

register_16bit Imm(.Rst(Rst), .Clk(Clk), .InData(Imm_value), .OutData(Out[31:16]));
immediate_control ic(.Inp(In), .LDM(1'b0), .Out(Imm_value));                        ///////YALAHWIIIIIIIIIII
//assign Out[69] = 1'b1;                                                          ///////YALAHWIIIIIIIIIII

alu_control_unit a(.Inp(In),.Out(Out[15:9]));

control_unit cu(.In(In), .Output(Out[8:0]));

endmodule