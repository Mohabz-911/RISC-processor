`include "shift_left_by_two.v"

module shift_left_by_two_test();
reg [31:0]  in;
wire [31:0] out;

shift_left_by_two shft(in, out);

initial begin

//Normal Case
in = 32'b0000_0000_0000_0000_0011_0101_0000_1111;
#1
if (out == 32'b00_0000_0000_0000_0011_0101_0000_1111_00)
    $display("SUCCESSFUL: Normal case, out = 4*in\nIn = %d\tOut = %d\n", in, out);
else
    $display("FAILED: Normal case\nIn = %d\tOut = %d\n", in, out);

//Overflow Case
in = 32'b1111_1111_1111_1111_1011_0101_0000_1111;
#1
if (out == 32'b11_1111_1111_1111_1011_0101_0000_1111_00)
    $display("SUCCESSFUL: Overflow case\nIn = %d\tOut = %d", in, out);
else
    $display("FAILED: Normal case\nIn = %d\tOut = %d", in, out);

end

endmodule