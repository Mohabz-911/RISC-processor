module immediate_control(Inp,LDM,Out);
input [15:0]Inp;
input LDM;
output [15:0]Out;



wire [15:0]outputOne;
wire [15:0]outputTwo;
wire [15:0]outputThree;

wire sel1,sel2,sel3,sel4;

assign sel1=(Inp[15:12]==4'b1010 || Inp[15:11] == 5'b01110)?1:0;//shift or LDD

assign sel2=(Inp[15:11]==5'b00010||Inp[15:11]==5'b10000)?1:0;//inc or not


// sel3=(
//         Inp[15:14]==2'b11||
//         Inp[15:14]==2'b01||
//         (Inp[15:14]==2'b01||Inp[15:14]==2'b01)
//         )?1:0;
assign sel3=(Inp[15:11]==5'b00101)?1:0;




mux_2x1_16bit m1({8'b0,Inp[7:0]},
{11'b0,Inp[4:0]},
sel1,
outputOne
);

mux_2x1_16bit m2(outputOne,
16'b1,
sel2,
outputTwo
);


mux_2x1_16bit m3(outputTwo,
16'b0,
sel3,
outputThree
);



mux_2x1_16bit m4(outputThree,
Inp,
LDM,
Out
);


endmodule

