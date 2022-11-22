`include "immediate_control.v"

module control_unit_test();

reg [15:0]  inst;

wire [15:0]       out; 

reg[15:0]  last;



immediate_control cu(inst,last,out);
//
initial begin
 last=16'b1111_0000_1111_0000;
  inst = 16'b1111_1000_0000_0000;//nop
  #1
  if(out == 16'b0)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);



  inst = 16'b0000_1000_0000_0000;//setc
 #1
  if(out == 16'b0)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);



  inst = 16'b0001_1000_0000_0000;//clrc
  #1
  if(out == 16'b0)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);




  inst = 16'b0010_0000_0000_0000;//out
  #1
  if(out == 16'b0)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);


  inst = 16'b0011_0000_0000_0000;//in
  #1
  if(out == 16'b0)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);



  inst = 16'b0010_1000_0000_0000;//mov
  #1
  if(out == 16'b0)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);



  last = 16'b0011_1000_0000_0000;//ldm
  inst=16'b1111_0000_1111_0000;
  #1
  if(out == 16'b1111_0000_1111_0000)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);

  last = 16'b0000_0000_0000_0000;//ldm

  inst = 16'b0001_0000_0000_0000;//inc
  #1
  if(out == 16'b1)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);



  inst = 116'b0000_0000_0000_0000;//add
  #1
  if(out == 16'b0)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);



  inst = 16'b0110_0000_0000_0000;//push
  #1
  if(out == 16'b0)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);


  inst = 16'b0110_1000_0000_0000;//pop
  #1
  if(out == 16'b0)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);



  inst = 16'b01110_000_0000_0000;//std
  #1
  if(out == 16'b0)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);


  inst = 16'b01111_000_0000_0000;//ldd
  #1
  if(out == 16'b0)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);



  inst = 16'b1000_0000_0000_0000;//dec
  #1
  if(out == 16'b1)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);


  inst = 16'b1000_1000_0000_0000;//sub
  #1
  if(out == 16'b0)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);



  inst = 16'b1001_0000_0000_0000;//or
  #1
  if(out == 16'b0)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);



  inst = 16'b1001_1000_0000_0000;//and
  #1
  if(out == 16'b0)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);




  inst = 16'b1010_0000_0000_0000;//shl
  #1
  if(out == 16'b0)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);


  inst = 16'b1010_1000_0000_0000;//shr
  #1
  if(out == 16'b0)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);



  inst = 16'b1011_0000_0000_0000;//not
  #1
  if(out == 16'b0)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);




  inst = 16'b1100_0000_0000_0000;//jz
  #1
  if(out == 16'b0)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);



  inst = 16'b1100_1000_0000_0000;//jnz
  #1
  if(out == 16'b0)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);




  inst = 16'b1101_0000_0000_0000;//jc
  #1
  if(out == 16'b0)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);


  inst = 16'b1101_1000_0000_0000;//jmp
  #1
  if(out == 16'b0)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);



  inst = 16'b0100_0000_0000_0000;//int
  #1
  if(out == 16'b0)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);


  inst = 16'b0100_1000_0000_0000;//call
  #1
  if(out == 16'b0)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);



  inst = 16'b1110_0000_0000_0000;//ret
  #1
  if(out == 16'b0)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);



  inst = 16'b1110_1000_0000_0000;//rti
  #1
  if(out == 16'b0)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);


  inst = 16'b1111_0000_0000_0000;//reset
  #1
  if(out == 16'b0)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);

    
 end

endmodule