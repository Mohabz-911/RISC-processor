/*
If the selector is 0, O = I0.
If the selector is 1, O = I1.
*/
module mux_2x1_1bit (I0, I1, S, O);
input I0, I1, S;
output O;

wire Sbar, w1, w2;

not(Sbar, S);
and(w1, Sbar, I0);
and(w2, S, I1);
or(O, w1, w2);

endmodule