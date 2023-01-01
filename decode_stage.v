module decode_stage (In, Out, writeback, Rst, Clk);
input [68:0]    In;
input [19:0]    writeback;
output [133:0]       Out;
input           Rst, Clk;

wire [2:0]  Rsrc_address, Rdst_address, WritebackAddress;
wire [15:0] Rsrc, Rdst, WritebackData, InPort;
wire WB;
wire [15:0] Imm_value;
wire [3:0] CallSig;
wire [3:0] IntSig;
wire [19:0] ControlUnitOut;




assign WritebackAddress = writeback[2:0];
assign WritebackData = writeback[18:3];
assign WB = writeback[19];
assign Rsrc_address = In[15:13];
assign Rdst_address = In[12:10];


assign Out[129]=In[4];

//done
assign Out[125:110]=In[68:53];//inport
assign Out[109:78]=In[52:21];//address
//done



register_file rf(.ReadRegister1(Rsrc_address), .ReadRegister2(Rdst_address), .WriteRegister(WritebackAddress), .WriteEnable(WB), .Clk(Clk), .Reset(Rst), .WriteData(WritebackData), .ReadData1(Rsrc), .ReadData2(Rdst));

//done
assign Out[77:62] = Rsrc;//16
assign Out[61:46] = Rdst;//16
assign Out[45:43] = Rsrc_address;//3
assign Out[42:40] = Rdst_address;//3


//done
//126:25 in
//24:0 ctrl
immediate_control ic(.Inp(In[20:5]), .LDM(1'b0), .Out(Out[39:24])); //immediate                       ///////YALAHWIIIIIIIIIII


//on continue ici apres immediate
alu_control_unit a(.Inp(In[20:5]),.Out(Out[23:16]));//alu control +alu control


// assign Out[19:16] = Rdst_address;//3
control_unit cu(.In(In[20:5]), .Output(ControlUnitOut));//output of control unit


call_control CC(.intSignal(ControlUnitOut[3]),.clk(Clk),.rst(Rst),.out(CallSig));//call decoded signal
interupt_control IC(.intSignal(In[4]),.clk(Clk),.rst(Rst),.out(IntSig));//input interrupt signal

assign Out[15:11]=ControlUnitOut[15:11];//ldm immorsingleop std jmp flags

assign Out[10]=(ControlUnitOut[10]||CallSig[1]||IntSig[1])?1:0;//push

assign Out[9:4]=ControlUnitOut[9:4];// pop ret rti ldd in out

assign Out[3]=(ControlUnitOut[3]||CallSig[1]||IntSig[1])?1:0;//call

assign Out[2:0]=ControlUnitOut[2:0];//memread memwrite wb

assign Out[128]=(CallSig[0]||IntSig[0])?1:0;//stall
assign Out[127]=(CallSig[2]||IntSig[2])?1:0;//second iteration
assign Out[126]=(CallSig[3]||IntSig[3])?1:0;//flush

assign Out[132:130]=ControlUnitOut[18:16];//jmps
assign Out[133]=ControlUnitOut[19];//mov

endmodule