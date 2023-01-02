`include "mad_risc_processor.v"

module mad_risc_processor_test();

reg Clk, Rst;
reg [15:0]In;
wire[15:0]Out;
reg Int;
integer idx;


mad_risc_processor mad(In, Out, Clk, Rst, Int);

always begin
    #10
  Clk = ~Clk;
end

initial begin
  $dumpfile("ay7aga.vcd");
  $dumpvars(0, mad_risc_processor_test);
  //for (idx = 0; idx < 2048; idx = idx + 1)$dumpvars(0, mad.m.z.Memory[idx]);
  In = 16'h0005;
  Int = 0;
  Clk = 0;
  Rst = 1;
  #20
  Rst = 0;
  In = 16'h0005;
  #20
  In = 16'hFFFF;
  #20
  In = 16'hF320;
  #150
  In = 16'hAABD;
  #800
  $finish;
end

endmodule