`include "mad_risc_processor.v"

module mad_risc_processor_test();

reg Clk, Rst;
reg [15:0]In;
wire[15:0]Out;
reg Int;


mad_risc_processor mad(In, Out, Clk, Rst, Int);

always begin
    #10
  Clk = ~Clk;
end

initial begin
  $dumpfile("ay7aga.vcd");
  $dumpvars(0, mad_risc_processor_test);
  In = 0;
  Int = 0;
  Clk = 0;
  Rst = 1;
  #20
  Rst = 0;
  #600
  $finish;
end

endmodule