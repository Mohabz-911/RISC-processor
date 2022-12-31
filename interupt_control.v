module interupt_control(intSignal,clk,rst,out);


input intSignal;
input clk,rst;
output reg [3:0]out;
reg [2:0]status;
reg [2:0]counter;



always@(posedge clk)begin


if(rst==1)begin
status=3'b001;
out=4'b0;
counter=3'b0;
end 

if(status>3'b0 &&counter<3'b111&&intSignal)begin
$display("status   = %b",  status);
if(status==3'b010||status==3'b011||status==3'b100||status==3'b101)begin
out=4'b0001;
end
else if(status==3'b110)begin
out=4'b0010;
end
else if(status==3'b111)begin
out=4'b0110;
end
else if(status==3'b110)begin
out=4'b1000;
end
else begin
out=4'b0;
end

counter=counter+1;
status=status+1;

end
 
// if(counter==6)begin
// sig=0;
// counter=0;
// end


end
endmodule