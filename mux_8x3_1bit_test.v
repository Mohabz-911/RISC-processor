`include "mux_8x3_1bit.v"

module mux_8x3_1bit_test ();
reg [7:0]in;
reg [2:0]s;
wire out;

mux_8x3_1bit m(.I(in), .S(s), .O(out));

integer i;
initial begin
  in = 8'b0110_1001;
  s = 3'b000;
  #1
  if (out == 1) $display("SUCCESS: s = %b, out = %b", s, out);
  else $display("FAILED: s = %b, out = %b", s, out);

  in = 8'b0110_1001;
  s = 3'b001;
  #1
  if (out == 0) $display("SUCCESS: s = %b, out = %b", s, out);
  else $display("FAILED: s = %b, out = %b", s, out);

  in = 8'b0110_1001;
  s = 3'b010;
  #1
  if (out == 0) $display("SUCCESS: s = %b, out = %b", s, out);
  else $display("FAILED: s = %b, out = %b", s, out);

  in = 8'b0110_1001;
  s = 3'b011;
  #1
  if (out == 1) $display("SUCCESS: s = %b, out = %b", s, out);
  else $display("FAILED: s = %b, out = %b", s, out);

  in = 8'b0110_1001;
  s = 3'b100;
  #1
  if (out == 0) $display("SUCCESS: s = %b, out = %b", s, out);
  else $display("FAILED: s = %b, out = %b", s, out);

  in = 8'b0110_1001;
  s = 3'b101;
  #1
  if (out == 1) $display("SUCCESS: s = %b, out = %b", s, out);
  else $display("FAILED: s = %b, out = %b", s, out);

  in = 8'b0110_1001;
  s = 3'b110;
  #1
  if (out == 1) $display("SUCCESS: s = %b, out = %b", s, out);
  else $display("FAILED: s = %b, out = %b", s, out);

  in = 8'b0110_1001;
  s = 3'b111;
  #1
  if (out == 0) $display("SUCCESS: s = %b, out = %b", s, out);
  else $display("FAILED: s = %b, out = %b", s, out);

end


endmodule