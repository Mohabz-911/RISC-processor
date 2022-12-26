/*
This circuit extends the sign bit of the 16-bit input into all the higher 16 bits of the output
ex: 
in =      16'h8402
out = 32'hFFFF8402
*/
module sign_extend (sixteen_bit_in, thirty_two_bit_out);
input  [15:0] sixteen_bit_in;
output [31:0] thirty_two_bit_out;

genvar k;
generate
for(k = 16; k < 32; k = k + 1)
    and(thirty_two_bit_out[k], sixteen_bit_in[15], 1'b1);
endgenerate

assign thirty_two_bit_out[15:0] = sixteen_bit_in[15:0];

endmodule