module decoder_3x8 (I, O);
input  [2:0]I;
output [7:0]O;

wire   Ibar[2:0];

not(Ibar[0], I[0]);
not(Ibar[1], I[1]);
not(Ibar[2], I[2]);

and(O[0], Ibar[2], Ibar[1], Ibar[0]);
and(O[1], Ibar[2], Ibar[1], I[0]);
and(O[2], Ibar[2], I[1],    Ibar[0]);
and(O[3], Ibar[2], I[1],    I[0]);

and(O[4], I[2],    Ibar[1], Ibar[0]);
and(O[5], I[2],    Ibar[1], I[0]);
and(O[6], I[2],    I[1],    Ibar[0]);
and(O[7], I[2],    I[1],    I[0]);

endmodule