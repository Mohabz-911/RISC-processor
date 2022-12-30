module load_use_case (Rsc_IFID, Rdst_IDEX, memo_read, stall_signal);
input wire [2:0] Rsc_IFID, Rdst_IDEX;
input wire memo_read;
output wire stall_signal;

assign stall_signal = (memo_read == 1'b1 && (Rsc_IFID == Rdst_IDEX)) ? 1 : 0;


endmodule



