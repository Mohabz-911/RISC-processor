`include "append_zeros.v"

module append_zeros_test();

reg [15:0]  a;
wire [31:0]       out; 


append_zeros m(.InputData(a), .OutputData(out));

initial begin
  a = 16'b1111111111111111;

  
  #10
  if(out == 32'b00000000000000001111111111111111)
    $display("SUCCESS: a = %b,  out = %b", a,  out);
  else
    $display("FAILED: a = %b,  out = %b", a,  out);

  #10

   a = 16'b1111101111111100;

   if(out == 32'b00000000000000001111101111111100)
    $display("SUCCESS: a = %b,  out = %b", a,  out);
  else
    $display("FAILED: a = %b,  out = %b", a,  out);
end

endmodule