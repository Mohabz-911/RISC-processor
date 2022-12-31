`include "sign_extend.v"

module sign_extend_test();
reg [15:0]  in;
wire [31:0] out;

sign_extend se(.sixteen_bit_in(in), .thirty_two_bit_out(out));

initial begin

//Negative number
in = 16'h8402;
#1
if (out == 32'hFFFF_8402)
    $display("SUCCESSFUL: Negative number case");
else
    $display("FAILED: Negative number case");

//Positive number
in = 16'h4402;
#1
if (out == 32'h0000_4402)
    $display("SUCCESSFUL: Positive number case");
else
    $display("FAILED: Positive number case");

end

endmodule