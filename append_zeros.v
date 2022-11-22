module append_zeros (InputData, OutputData);

input wire [15:0] InputData;
output wire [31:0] OutputData;


assign OutputData = {16'b0000000000000000,InputData};

endmodule