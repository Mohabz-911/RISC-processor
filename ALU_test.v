`include"alu_16bit.v"

module ALU_test();
reg [15:0] a,b;
reg [6:0] select;
wire CF,NF,ZF;
wire [15:0] out;
reg En;

alu_16bit inst(.FirstOperand(a),.SeconedOperand(b),.OP(select),.CarryFlag(CF),.NegativeFlag(NF),.ZeroFlag(ZF),.Result(out),.En(En));

initial begin
  En=1;
  a=16'hFFFF;
  b=16'h0001;
  select=7'b000_0001;
  #5
  if(out==0 && CF==1 && ZF==1 && NF == 0 )
  $display("success:a=%b + b=%b = res=%b ZF=%b CF=%b NF=%b",a,b,out,ZF,CF,NF);
  else
  $display("failre:a=%b + b=%b = res=%b ZF=%b CF=%b NF=%b",a,b,out,ZF,CF,NF);


  En=0;
  a=16'h0001;
  b=16'h0001;
  select=7'b000_0001;
  #5
  if(out==0 && CF==1 && ZF==1 && NF == 0 )
  $display("success:a=%b + b=%b = res=%b ZF=%b CF=%b NF=%b",a,b,out,ZF,CF,NF);
  else
  $display("failre:a=%b + b=%b = res=%b ZF=%b CF=%b NF=%b",a,b,out,ZF,CF,NF);


  En=1;
  a=16'hFFFF;
  b=16'h0001;
  select=7'b000_0100;
  #5
  if(out==0 && CF==1 && ZF==1 && NF == 0 )
  $display("success:a=%b res=%b ZF=%b CF=%b NF=%b",a,out,ZF,CF,NF);
  else
  $display("failre:a=%b res=%b ZF=%b CF=%b NF=%b",a,out,ZF,CF,NF);


  a=16'hFFFF;
  b=16'h0001;
  select=7'b000_0001;
  #5
  if(out==0 && CF==1 && ZF==1 && NF == 0 )
  $display("success:a=%b res=%b ZF=%b CF=%b NF=%b",a,out,ZF,CF,NF);
  else
  $display("failre:a=%b res=%b ZF=%b CF=%b NF=%b",a,out,ZF,CF,NF);
    



  a=16'h0000;
  b=16'h0000;
  select=7'b000_0001;
  #5
  if(out==0 && CF==0 && ZF==1 && NF == 0 )
  $display("success:a=%b + b=%b = res=%b ZF=%b CF=%b NF=%b",a,b,out,ZF,CF,NF);
  else
  $display("failre:a=%b res=%b ZF=%b CF=%b NF=%b",a,out,ZF,CF,NF);


  a=16'b1000_0000_0000_0000;
  b=16'h0001;
  select=7'b001_0000;
  #5
  if(out==16'b0111_1111_1111_1111 && CF==0 && ZF==0 && NF == 0 )
  $display("success:a=%b res=%b ZF=%b CF=%b NF=%b",a,out,ZF,CF,NF);
  else
    $display("failer:a=%b res=%b ZF=%b CF=%b NF=%b",a,out,ZF,CF,NF);
  


  a=16'b0000_0000_0000_0000;
  b=16'h0001;
  select=7'b001_0000;
  #5
  if(out==16'b1111_1111_1111_1111 && CF==0 && ZF==0 && NF == 1 )
  $display("success:a=%b res=%b ZF=%b CF=%b NF=%b",a,out,ZF,CF,NF);
  else
  $display("failre:a=%b res=%b ZF=%b CF=%b NF=%b",a,out,ZF,CF,NF);

  




end

endmodule