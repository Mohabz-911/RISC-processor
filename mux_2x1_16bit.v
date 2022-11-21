`include "mux_2x1_1bit.v"

module mux_2x1_16bit (I0, I1, S, O);
input [15:0]    I0, I1;
input           S;
output [15:0]   O;

genvar k;
generate for (k = 0; k < 16; k = k + 1)
    mux_2x1_1bit m(I0[k], I1[k], S, O[k]);
endgenerate

endmodule