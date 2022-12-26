`include "mux_2x1_16bit.v"
`include "mux_2x1_1bit.v"


module mux_2x1_16bit_test();

reg [15:0]  a, b;
reg         select;
wire [15:0]       out; 


mux_2x1_16bit m(.I0(a), .I1(b), .S(select), .O(out));

initial begin
  $dumpfile("mux_2x1_16bit_test.vcd");
  $dumpvars;

  a = 16'hABCD;
  b = 16'h0088;
  
  select = 0;
  #1
  if(out == 16'hABCD)
    $display("SUCCESS: a = %h, b = %h, s = %b \t out = %h", a, b, select, out);
  else
    $display("FAILED: a = %h, b = %h, s = %b \t out = %h", a, b, select, out);

  select = 1;
  #1
  if(out == 16'h0088)
    $display("SUCCESS: a = %h, b = %h, s = %b \t out = %h", a, b, select, out);
  else
    $display("FAILED: a = %h, b = %h, s = %b \t out = %h", a, b, select, out);
end

endmodule