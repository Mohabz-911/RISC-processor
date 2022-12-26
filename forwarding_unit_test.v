`include "forwarding_unit.v"

module forwarding_unit_test();


reg [15:0]  valueExecute,valueMemo;
reg [2:0]  addressMemo,sourceAddress1,sourceAddress2,addressExecute;
reg wbExecute,wbMemo;

wire  ctrl1,ctrl2;
wire [15:0]       result1,result2; 

forwarding_unit fu(.wbExecute(wbExecute),
.addressExecute(addressExecute),
.valueExecute(valueExecute),
.wbMemo(wbMemo),
.addressMemo(addressMemo),
.valueMemo(valueMemo),

.sourceAddress1(sourceAddress1),
.sourceAddress2(sourceAddress2),
.result1(result1),
.ctrl2(ctrl2),

.result2(result2),
.ctrl1(ctrl1)
);

initial begin


//the memo
valueExecute=16'b1111_1111_1111_1111;
addressExecute=3'b101;
wbExecute=1'b1;

valueMemo=16'b1111_0000_1111_0000;
addressMemo=3'b111;
wbMemo=1'b1;

sourceAddress1=3'b111;
sourceAddress2=3'b111;


 #1
  if(result1 == 16'b1111_0000_1111_0000&& ctrl1==1'b1&&
  result2 == 16'b1111_0000_1111_0000&& ctrl2==1'b1
  )
      $display("2 SUCCESS:  out1 = %b out2=",  result1,result2);
  else
    $display("2 FAILED: out1 = %b out2=",  result1,result2);




//the execute
valueExecute=16'b1111_1111_1111_1111;
addressExecute=3'b101;
wbExecute=1'b1;

valueMemo=16'b1111_0000_1111_0000;
addressMemo=3'b111;
wbMemo=1'b1;

sourceAddress1=3'b101;
sourceAddress2=3'b111;

    #1
  if(result1 == 16'b1111_1111_1111_1111&& ctrl1==1'b1&&
  result2 == 16'b1111_0000_1111_0000&& ctrl2==1'b1)
    $display("2 SUCCESS:  out1 = %b out2=",  result1,result2);
  else
    $display("2 FAILED: out1 = %b out2=",  result1,result2);

//not any of them

valueExecute=16'b1111_1111_1111_1111;
addressExecute=3'b101;
wbExecute=1'b1;

valueMemo=16'b1111_0000_1111_0000;
addressMemo=3'b111;
wbMemo=1'b1;

sourceAddress1=3'b001;
sourceAddress2=3'b101;

#1
  if(result1 == 16'b0&& ctrl1==1'b0&&
  result2 == 16'b1111_1111_1111_1111&& ctrl2==1'b1)
      $display("2 SUCCESS:  out1 = %b out2=",  result1,result2);
  else
    $display("2 FAILED: out1 = %b out2=",  result1,result2);



//both
valueExecute=16'b1111_1111_1111_1111;
addressExecute=3'b001;
wbExecute=1'b1;

valueMemo=16'b1111_0000_1111_0000;
addressMemo=3'b001;
wbMemo=1'b1;

sourceAddress1=3'b001;
sourceAddress2=3'b001;

#1
  if(result1 == 16'b1111_1111_1111_1111&& ctrl1==1'b1&&
  result2 == 16'b1111_1111_1111_1111&& ctrl2==1'b1)
       $display("2 SUCCESS:  out1 = %b out2=",  result1,result2);
  else
    $display("2 FAILED: out1 = %b out2=",  result1,result2);


//none of them
valueExecute=16'b1111_1111_1111_1111;
addressExecute=3'b001;
wbExecute=1'b0;

valueMemo=16'b1111_0000_1111_0000;
addressMemo=3'b011;
wbMemo=1'b1;

sourceAddress1=3'b001;
sourceAddress2=3'b000;
#1
  if(result1 == 16'b0&& ctrl1==1'b0&&
  result2 == 16'b0&& ctrl2==1'b0
  )
       $display("2 SUCCESS:  out1 = %b out2=",  result1,result2);
  else
    $display("2 FAILED: out1 = %b out2=",  result1,result2);


//none of them
valueExecute=16'b1111_1111_1111_1111;
addressExecute=3'b001;
wbExecute=1'b0;

valueMemo=16'b1111_0000_1111_0000;
addressMemo=3'b011;
wbMemo=1'b1;

sourceAddress1=3'b001;
sourceAddress2=3'b011;
#1
  if(result1 == 16'b0&& ctrl1==1'b0&&
  result2 == 16'b1111_0000_1111_0000&& ctrl2==1'b1
  )
       $display("2 SUCCESS:  out1 = %b out2=",  result1,result2);
  else
    $display("2 FAILED: out1 = %b out2=",  result1,result2);





    end

    endmodule
