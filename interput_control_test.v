`include "interupt_control.v"
module interupt_control_test();

reg clk,intSignal;
reg rst;
wire [3:0]       out; 

interupt_control ic(intSignal,clk,rst,out);


initial begin

clk=0;
intSignal=0;
rst=1;
#10
intSignal=1;
#5
rst=0;



#10

 $display("interrupt  int = %b",  intSignal);
  if(out == 4'b0001)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);

#20
  if(out == 4'b0001)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);

#20
      if(out == 4'b0001)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);

#20
      if(out == 4'b0011)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);


#20
      if(out == 4'b0111)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);

#20
         if(out == 4'b1000)
    $display("1 SUCCESS:  out = %b",  out);
  else
    $display("1 FAILED:  out = %b", out);
intSignal=1'b0;


$finish;
end

always 
 #10 clk=~clk;


endmodule