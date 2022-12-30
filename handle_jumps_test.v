`include "handle_jumps.v"

module handle_jumps_test();

reg jmp, jc, cf, jn, nf, jz, zf;
wire  jmp_signal; 

handle_jumps m(.jmp(jmp), .jc(jc) , .cf(cf) , .jn(jn) , .nf(nf) , .jz(jz) , .zf(zf) , .jmp_signal(jmp_signal));

 

initial begin
 jmp = 1'b1;
 jc = 1'b1;
 cf = 1'b1;
 jn = 1'b1;
 nf = 1'b1;
 jz = 1'b1;
 zf = 1'b1;
  
#20
 
$display("jump signal = %b",   jmp_signal);

#20
  
jmp = 1'b0;
jc = 1'b1;
cf = 1'b0;
jn = 1'b0;
nf = 1'b0;
jz = 1'b0;
zf = 1'b0;
  
#20
 
$display("jump signal = %b",   jmp_signal);

#20
  
jmp = 1'b0;
jc = 1'b1;
cf = 1'b1;
jn = 1'b0;
nf = 1'b0;
jz = 1'b0;
zf = 1'b0;
  
#20
 
$display("jump signal = %b",   jmp_signal);

 

end

endmodule