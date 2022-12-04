`include "register_32bit_PC.v"

module register_32bit_PC_test();

reg Rst, Clk;
reg [31:0] InData;
wire [31:0] OutData;

register_32bit_PC r(Rst, Clk, InData, OutData);

always begin
#1 Clk = ~Clk;
end

initial begin
    $dumpfile("ay7aga.vcd");
    $dumpvars(1, register_32bit_PC_test);
    Clk = 0;
    Rst = 0;
    InData = 32'hABCD;
    #2
    if (OutData == 32'hABCD) $display("Vamos");
    else $display("lol");

    Rst = 1;
    #2
    if (OutData == 32) $display("Vamos");
    else $display("lol");
    $finish;
end

endmodule