`define ADD 7'b000_0001
`define SUB 7'b000_0010
`define AND 7'b000_0100
`define OR  7'b000_1000
`define NOT 7'b001_0000
`define SHR 7'b010_0000
`define SHL 7'b100_0000

module alu_control_unit(Inp,Out);
localparam ADD = 7'b000_0001;
localparam SUB = 7'b000_0010;
localparam AND = 7'b000_0100;
localparam OR  = 7'b000_1000;
localparam NOT = 7'b001_0000;
localparam SHR = 7'b010_0000;
localparam SHL = 7'b100_0000;
input [16:0]Inp;
output [7:0]Out;

assign Out[6:0]= (Inp[15:12]==4'b1000)?SUB:
            (Inp[15:11]==5'b10011)?AND:
            (Inp[15:11]==5'b10010)?OR:
            (Inp[15:11]==5'b10110)?NOT:
            (Inp[15:11]==5'b10101)?SHR:
            (Inp[15:11]==5'b10100)?SHL:
            (Inp[15:14]==2'b0 || 
            Inp[15:14]==2'b01 ||
            (Inp[15:14]==2'b11 && !(Inp[13:11]==3'b111)) )? ADD : 7'b0;

assign Out[7]=1'b1;
// a faire la derniere signal (control)

endmodule

