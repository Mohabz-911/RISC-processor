module call_control(intSignal,clk,rst,out);


input intSignal;
input clk,rst;
output reg [3:0]out;
reg [2:0]status;
//reg [2:0]counter;
//reg sig;


always@(posedge clk)begin


    if(rst==1)begin
    status=3'b000;
    out=4'b0;
    //counter=3'b0;
    //sig=1'b1;
    end 

    if(intSignal == 1'b1 && status == 3'b000) begin
    status = 3'b001;
    out = 4'b1;
    end

    else if(status==3'b001)begin
    status = 3'b010;
    out=4'b0001;
    end

    else if(status==3'b010)begin
    status = 3'b011;
    out=4'b0001;
    end

    else if(status==3'b011)begin
    status = 3'b100;
    out=4'b0011;
    end

    //4
    else if(status==3'b100)begin
    status = 3'b101;
    out=4'b0111;
    end
    //5
    else if(status==3'b101)begin
    status = 3'b110;
    out=4'b1000;
    end
    //6
    else if(status==3'b110)begin
    status = 3'b000;
    out=4'b0;
    end

end

endmodule