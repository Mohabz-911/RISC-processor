module forwarding_unit(wbExecute,addressExecute,valueExecute,
wbMemo,addressMemo,valueMemo,
sourceAddress1,sourceAddress2,
result1,ctrl1,
result2,ctrl2
);
input [15:0]valueExecute,valueMemo;

input [2:0]addressExecute,addressMemo,sourceAddress1,sourceAddress2;

input wbExecute,wbMemo;
output  [15:0]result1,result2;
output  ctrl1,ctrl2;





assign result1=(addressExecute==sourceAddress1 && wbExecute==1'b1)?valueExecute:
(addressMemo==sourceAddress1 && wbMemo==1'b1)?valueMemo:
16'b0;

assign result2=(addressExecute==sourceAddress2 && wbExecute==1'b1)?valueExecute:
(addressMemo==sourceAddress2 && wbMemo==1'b1)?valueMemo:
16'b0;

assign ctrl1=(addressExecute==sourceAddress1 && wbExecute==1'b1)?1'b1:
(addressMemo==sourceAddress1 && wbMemo==1'b1)?1'b1:
1'b0;

assign ctrl2=(addressExecute==sourceAddress2 && wbExecute==1'b1)?1'b1:
(addressMemo==sourceAddress2 && wbMemo==1'b1)?1'b1:
1'b0;


// if(addressExecute==sourceAddress && wbExecute==1'b1)begin
// result=valueExecute;
// ctrl=1'b1;
// end else if(addressMemo==sourceAddress && wbMemo==1'b1) begin 

// result=valueMemo;
// ctrl=1'b1;

// end else begin

// ctrl=1'b0;
// result=16'b0;

// end



endmodule