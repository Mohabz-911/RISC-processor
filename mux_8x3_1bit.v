module mux_8x3_1bit (I, S, O);
input  [7:0]I;
input  [2:0]S;
output O;
//wire Sbar, w1, w2;
wire Sbar[2:0];
wire Selector[7:0];
wire w[7:0];

not(Sbar[0], S[0]);
not(Sbar[1], S[1]);
not(Sbar[2], S[2]);

and(Selector[0], Sbar[0], Sbar[1], Sbar[2]);
and(Selector[1], Sbar[0], Sbar[1], S[2]);
and(Selector[2], Sbar[0], S[1], Sbar[2]);
and(Selector[3], Sbar[0], S[1], S[2]);

and(Selector[4], S[0], Sbar[1], Sbar[2]);
and(Selector[5], S[0], Sbar[1], S[2]);
and(Selector[6], S[0], S[1], Sbar[2]);
and(Selector[7], S[0], S[1], S[2]);

genvar k;
generate
    for(k = 0; k < 8; k = k + 1)
        and(w[k], Selector[k], I[k]);
endgenerate

or(O, w[0], w[1], w[2], w[3], w[4], w[5], w[6], w[7]);

endmodule