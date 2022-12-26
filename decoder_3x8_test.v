`include "decoder_3x8.v"

module decoder_3x8_test();
reg     [2:0]in;
wire    [7:0]out;

decoder_3x8 d(.I(in), .O(out));

initial begin
in = 3'b000;    #1
if (out == 1) $display("SUCCESS: in = %b, out = %b", in, out);
else $display("FAILED: in = %b, out = %b", in, out);

in = 3'b001;    #1
if (out == 2) $display("SUCCESS: in = %b, out = %b", in, out);
else $display("FAILED: in = %b, out = %b", in, out);

in = 3'b010;    #1
if (out == 4) $display("SUCCESS: in = %b, out = %b", in, out);
else $display("FAILED: in = %b, out = %b", in, out);

in = 3'b011;    #1
if (out == 8) $display("SUCCESS: in = %b, out = %b", in, out);
else $display("FAILED: in = %b, out = %b", in, out);

in = 3'b100;    #1
if (out == 16) $display("SUCCESS: in = %b, out = %b", in, out);
else $display("FAILED: in = %b, out = %b", in, out);

in = 3'b101;    #1
if (out == 32) $display("SUCCESS: in = %b, out = %b", in, out);
else $display("FAILED: in = %b, out = %b", in, out);

in = 3'b110;    #1
if (out == 64) $display("SUCCESS: in = %b, out = %b", in, out);
else $display("FAILED: in = %b, out = %b", in, out);

in = 3'b111;    #1
if (out == 128) $display("SUCCESS: in = %b, out = %b", in, out);
else $display("FAILED: in = %b, out = %b", in, out);

end

endmodule