/*
This module simply left shifts the input by 2, nothing interesting.
*/
module shift_left_by_two (in, out);
input [31:0]    in;
output [31:0]   out;

assign out[31:2] = in[29:0];
assign out[1:0] = 2'b0;

endmodule