module handle_jumps (jmp, jc, cf, jn, nf, jz, zf, jmp_signal);
input wire jmp, jc, cf, jn, nf, jz, zf;
output wire jmp_signal;

assign jmp_signal = (jmp == 1'b1 || (jc & cf) || (jn & nf) || (jz & zf)) ? 1 : 0;


endmodule



