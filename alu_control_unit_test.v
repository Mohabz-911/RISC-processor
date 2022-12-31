`include "alu_control_unit.v"

module alu_control_unit_test();

reg [15:0]  inst;

wire [6:0]       out; 


alu_control_unit cu(inst,out);
//
initial begin
  inst = 16'b1111_1000_0000_0000;//nop
  #1
  if(out == 7'b0)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);



  inst = 16'b0000_1000_0000_0000;//setc
 #1
  if(out == 7'b1)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);



  inst = 16'b0001_1000_0000_0000;//clrc
  #1
  if(out == 7'b1)
    $display("3 SUCCESS:  out = %b",  out);
  else
    $display("3 FAILED:  out = %b", out);




  inst = 16'b0010_0000_0000_0000;//out
  #1
  if(out ==7'b1)
    $display("4 SUCCESS:  out = %b",  out);
  else
    $display("4 FAILED:  out = %b", out);


  inst = 16'b0011_0000_0000_0000;//in
  #1
  if(out ==7'b1)
    $display("5 SUCCESS:  out = %b",  out);
  else
    $display("5 FAILED:  out = %b", out);



  inst = 16'b0010_1000_0000_0000;//mov
  #1
  if(out ==7'b1)
    $display("6 SUCCESS:  out = %b",  out);
  else
    $display("6 FAILED:  out = %b", out);



  inst = 16'b0011_1000_0000_0000;//ldm
  #1
  if(out == 7'b1)
    $display("7 SUCCESS:  out = %b",  out);
  else
    $display("7 FAILED:  out = %b", out);



  inst = 16'b0001_0000_0000_0000;//inc
  #1
  if(out ==7'b1)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);



  inst = 116'b0000_0000_0000_0000;//add
  #1
  if(out ==7'b1)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);



  inst = 16'b0110_0000_0000_0000;//push
  #1
  if(out == 7'b1)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);


  inst = 16'b0110_1000_0000_0000;//pop
  #1
  if(out == 7'b1)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);



  inst = 16'b0111_0000_0000_0000;//std
  #1
  if(out == 7'b1)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);


  inst = 16'b0111_1000_0000_0000;//ldd
  #1
  if(out == 7'b01)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);



  inst = 16'b1000_0000_0000_0000;//dec
  #1
  if(out == 7'b10)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);


  inst = 16'b1000_1000_0000_0000;//sub
  #1
  if(out == 7'b10)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);



  inst = 16'b1001_0000_0000_0000;//or
  #1
  if(out == 7'b1000)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);



  inst = 16'b1001_1000_0000_0000;//and
  #1
  if(out == 7'b100)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);




  inst = 16'b1010_0000_0000_0000;//shl
  #1
  if(out == 7'b100_0000)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);


  inst = 16'b1010_1000_0000_0000;//shr
  #1
  if(out == 7'b10_0000)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);



  inst = 16'b1011_0000_0000_0000;//not
  #1
  if(out == 7'b1_0000)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);




  inst = 16'b1100_0000_0000_0000;//jz
  #1
  if(out ==7'b1)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);



  inst = 16'b1100_1000_0000_0000;//jnz
  #1
  if(out ==7'b1)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);




  inst = 16'b1101_0000_0000_0000;//jc
  #1
  if(out ==7'b1)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);


  inst = 16'b1101_1000_0000_0000;//jmp
  #1
  if(out ==7'b1)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);



  inst = 16'b0100_0000_0000_0000;//int
  #1
  if(out ==7'b1)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);


  inst = 16'b0100_1000_0000_0000;//call
  #1
  if(out ==7'b1)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);



  inst = 16'b1110_0000_0000_0000;//ret
  #1
  if(out == 7'b1)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);



  inst = 16'b1110_1000_0000_0000;//rti
  #1
  if(out == 7'b1)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);


  inst = 16'b1111_0000_0000_0000;//reset
  #1
  if(out ==7'b1)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);

    
 end

endmodule