`include "mad_risc_processor.v"

module mad_risc_processor_test();

reg Clk, Rst;

mad_risc_processor mad(Clk, Rst);

always begin
    #10
  Clk = ~Clk;
end

initial begin
  $dumpfile("ay7aga.vcd");
  $dumpvars(0, mad_risc_processor_test);
  Clk = 0;
  Rst = 1;
  #20
  Rst = 0;
  #600
  $finish;
end

endmodule