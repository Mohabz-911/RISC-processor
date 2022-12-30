`include "load_use_case.v"

module load_use_case_test();

reg [2:0]  a,b;
reg memoRead;
wire  out; 

load_use_case m(.Rsc_IFID(a), .Rdst_IDEX(b) , .memo_read(memoRead) , .stall_signal(out));

 

initial begin
  a = 3'b000;
  b = 3'b000;
  memoRead = 1'b1;
  #20
 
    $display("stall = %b",   out);

 #20
  a = 3'b000;
  b = 3'b000;
  memoRead = 1'b0;
  #20
    $display("stall = %b",   out);
 #20
  a = 3'b000;
  b = 3'b010;
  memoRead = 1'b1;
  #20
    $display("stall = %b",   out);
 

end

endmodule