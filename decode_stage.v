module decode_stage (In, Out, writeback, Rst, Clk);
input [68:0]    In;
input [20:0]    writeback;
output [136:0]       Out;
input           Rst, Clk;

wire [2:0]  Rsrc_address, Rdst_address, WritebackAddress;
wire [15:0] Rsrc, Rdst, WritebackData, InPort;
wire WB;
wire [15:0] Imm_value;
wire [3:0] CallSig;
wire [3:0] IntSig;
wire [21:0] ControlUnitOut;
wire stallSignal;




assign WritebackAddress = writeback[3:1];
assign WritebackData = writeback[19:4];
assign WB = writeback[0];
assign Rsrc_address = In[15:13];
assign Rdst_address = In[12:10];


assign Out[129]=In[4];  //Interrupt

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
alu_control_unit a(.Inp({writeback[20], In[20:5]}),.Out(Out[23:16]));//alu control +alu control


// assign Out[19:16] = Rdst_address;//3
control_unit cu(.In(In[20:5]), .Output(ControlUnitOut));//output of control unit


call_control CC(.intSignal(ControlUnitOut[3]),.clk(Clk),.rst(Rst),.out(CallSig));//call decoded signal
interupt_control IC(.intSignal(In[4]),.clk(Clk),.rst(Rst),.out(IntSig));//input interrupt signal

load_use_case lucu(.Rsc_IFID(Rsrc_address), .Rdst_IDEX(In[2:0]), .memo_read(In[3]), .stall_signal(stallSignal));


assign Out[136]=ControlUnitOut[21];////CLEAR CARRY

assign Out[135]=ControlUnitOut[20];///SetCARRY

assign Out[15:11]=ControlUnitOut[15:11];//ldm immorsingleop std jmp flags

assign Out[10]=(ControlUnitOut[10]||CallSig[1]||IntSig[1])?1:0;//push

assign Out[9:4]=ControlUnitOut[9:4];// pop ret rti ldd in out

assign Out[3]=(ControlUnitOut[3]||CallSig[1]||IntSig[1])?1:0;//call

assign Out[2:0]=ControlUnitOut[2:0];//memread memwrite wb

assign Out[128]=(CallSig[0]||IntSig[0]||stallSignal)?1:0;//stall
assign Out[127]=(CallSig[2]||IntSig[2])?1:0;//second iteration
assign Out[126]=(CallSig[3]||IntSig[3])?1:0;//flush

assign Out[132:130]=ControlUnitOut[18:16];//jmps
assign Out[133]=ControlUnitOut[19];//mov
assign Out[134] = writeback[20];

endmodule