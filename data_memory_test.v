`include "data_memory.v"

module data_memory_test();

reg [15:0]  DataIn;
reg [31:0] Address;
reg  MemoryRead;
reg  MemoryWrite;
wire [15:0] out; 


data_memory m(.DataIn(DataIn), .Address(Address), .MemoryRead(MemoryRead), .MemoryWrite(MemoryWrite), .DataOut(out));

initial begin
  DataIn = 16'b1111111111111111;
  Address = 32'b00000000000000000000000000000001;
  MemoryWrite = 1'b1;
  MemoryRead = 1'b0;
  

  #20

  Address = 32'b00000000000000000000000000000001;
  MemoryRead = 1'b1;
  MemoryWrite = 1'b0;
  #20

   if(out == 16'b1111111111111111)
    $display("SUCCESS: Address = %b,  out = %b", Address,  out);
  else
    $display("FAILED: Address = %b,  out = %b", Address,  out);
  

  #20
  DataIn = 16'b0000110111010101;
  Address = 32'b00000000000000000000000000000001;
  MemoryWrite = 1'b1;
  MemoryRead = 1'b0;

#20

  Address = 32'b00000000000000000000000000000001;
  MemoryRead = 1'b1;
  MemoryWrite = 1'b0;
  #20

   if(out == 16'b0000110111010101)
    $display("SUCCESS: Address = %b,  out = %b", Address,  out);
  else
    $display("FAILED: Address = %b,  out = %b", Address,  out);
  
  

  #20
  DataIn = 16'b0000110111011111;
  Address = 32'b00000000000000000000000000001000;
  MemoryWrite = 1'b1;
  MemoryRead = 1'b0;

#20

  Address = 32'b00000000000000000000000000001000;
  MemoryRead = 1'b1;
  MemoryWrite = 1'b0;
  #20

   if(out == 16'b0000110111011111)
    $display("SUCCESS: Address = %b,  out = %b", Address,  out);
  else
    $display("FAILED: Address = %b,  out = %b", Address,  out);
  
  

  #20
  DataIn = 16'b1110101101011010;
  Address = 32'b00000000000000000000011111111111;
  MemoryWrite = 1'b1;
  MemoryRead = 1'b0;

#20

  Address = 32'b00000000000000000000011111111111;
  MemoryRead = 1'b1;
   MemoryWrite = 1'b0;
   #20

   if(out == 16'b1110101101011010)
    $display("SUCCESS: Address = %b,  out = %b", Address,  out);
  else
    $display("FAILED: Address = %b,  out = %b", Address,  out);


    #20

  Address = 32'b00000000000000000000000000001000;
  MemoryRead = 1'b1;
  MemoryWrite = 1'b0;
  #20

   if(out == 16'b0000110111011111)
    $display("SUCCESS: Address = %b,  out = %b", Address,  out);
  else
    $display("FAILED: Address = %b,  out = %b", Address,  out);
  
end

endmodule