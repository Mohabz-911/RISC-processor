`include "memory_stage.v"

module memory_stage_test();

reg [75:0]  a;
wire [41:0]       out; 


memory_stage m(.MemoryInput(a), .MemoryOutput(out));

 

initial begin
  a = 76'b0000000000000000000000000000001100000000000011110000000000001001101111011001;


  
  #20
 
    $display("out = %b",   out);

 #20

  a = 76'b0000000000000000000000000000001100000000000011110000000000001001101111100101;
 #20


 
  if(out == 42'b000000000000111100000000000010011011110101)
    $display("SUCCESS:  out = %b", out);
  else
    $display("FAILED:   out = %b",   out);
end

endmodule