module register_file(
    input[2:0] ReadRegister1,
    input[2:0] ReadRegister2,
    input[2:0] WriteRegister,
    input WriteEnable,
    input Clk,
    input Reset,
    input[15:0] WriteData,
    output[15:0] ReadData1,
    output[15:0] ReadData2
);

//ARRAY OF BUSES COMES OUT FROM REGISTER MODULE 
//CARRIES OUTPUT DATA GOES TO MUX TO SELECT FROM THE REGISTERS
wire [15:0] OutoRegisters[0:7];

//AND BETWEEN WriteEnable AND THE SELECTED REGISTER 
wire Enables[7:0];
wire[7:0] WriteEnables;

//DECODER TO SELECT THE  
decoder_3x8 decoder(WriteRegister,WriteEnables);


genvar i;
generate

  for(i=0;i<8;i=i+1)
  begin
    and(Enables[i],WriteEnable,WriteEnables[i]);
    register_16bit_f RegInstance(.Enable(Enables[i]), .Clk(Clk), .Reset(Reset), .InData(WriteData), .OutData(OutoRegisters[i]));
  
  end

endgenerate

assign ReadData1 = OutoRegisters[ReadRegister1];
assign ReadData2 = OutoRegisters[ReadRegister2];

//mux_8x3_16bit mux1(OutoRegisters,ReadRegister1,ReadData1);
//mux_8x3_16bit mux2(OutoRegisters,ReadRegister2,ReadData2);


endmodule