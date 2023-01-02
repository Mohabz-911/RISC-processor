module control_unit(In,Output);
input [15:0]In;
output [19:0]Output;//kanet 15



//and(Output[15], ~In[15] , ~In[14], In[13] , In[12] , In[11]);//flags

//00101
and(Output[19], ~In[15] , ~In[14], In[13] , ~In[12] , In[11]);//mov
and(Output[18], In[15] , In[14], ~In[13] , In[12] , ~In[11]);//jc
and(Output[17], In[15] , In[14], ~In[13] , ~In[12] , In[11]);//jn
and(Output[16], In[15] , In[14], ~In[13] , ~In[12] , ~In[11]);//jz



and(Output[15], ~In[15] , ~In[14], In[13] , In[12] , In[11]);//ldm
assign Output[14]=(In[15:11]==5'b00001||//setc
In[15:11]==5'b11111||//nop
In[15:11]==5'b11101||//rti
In[15:11]==5'b00011||//clrc
In[15:11]==5'b11100||//ret
In[15:11]==5'b00111||//ldm
In[15:11]==5'b10100||//shl
In[15:11]==5'b10101||//shr
In[15:11]==5'b01110||//ldd
In[15:11]==5'b00110||//in
In[15:11]==5'b00010||//inc
In[15:11]==5'b10000  //dec
)?1:0;//immmediate or single operand inst
and(Output[13], ~In[15] ,  In[14], In[13] , In[12] ,  In[11]);//std   
and(Output[12], In[15] , In[14], ~In[13] , In[12] , In[11]);//jmp
assign Output[11]=(
In[15:14]==2'b10||//dec sub or and shl shr not
In[15:11]==5'b00000||//add
In[15:11]==5'b00010||//inc
In[15:11]==5'b00011||//clc
In[15:11]==5'b00001//setc
)?1:0;//flag saving
//13
//12
and(Output[10], ~In[15] ,  In[14], In[13] , ~In[12] , ~In[11]);//push
and(Output[9], ~In[15] ,  In[14], In[13] , ~In[12] , In[11]);//pop
and(Output[8], In[15] , In[14], In[13] , ~In[12] , ~In[11]);//ret
and(Output[7], In[15] , In[14], In[13] , ~In[12] , In[11]);//rti
and(Output[6], ~In[15] ,  In[14], In[13] , In[12] , ~In[11]);//ldd 
and(Output[5], ~In[15] , ~In[14], In[13] , In[12] , ~In[11]);//In
and(Output[4], ~In[15] , ~In[14], In[13] , ~In[12] , ~In[11]);//out
//4
and(Output[3], In[15] , In[14], In[13] , In[12] , ~In[11]);//call 11110
//and(Output[2], ~In[15] , In[14] , In[13] , ~In[11]);//mem read
assign Output[2] = (
In[15:11] == 5'b01101 || //pop
In[15:11] == 5'b01110 || //ldd
In[15:11] == 5'b00111 || //ldm
In[15:11] == 5'b11100 || //ret
In[15:11] == 5'b11101    //rti
)?1:0;
//and(Output[1], ~In[15] , In[14] , In[13] , In[11]);//mem write
assign Output[1] = (
In[15:11] == 5'b01100 || //push
In[15:11] == 5'b01111 || //store
In[15:11] == 5'b11110    //call
)?1:0;
assign Output[0]=(In[15:14]==2'b10||
In[15:11]==5'b01101||
In[15:11]==5'b00101||
In[15:11]==5'b00111||
In[15:11]==5'b00010||
In[15:11]==5'b00000||
In[15:11]==5'b01110||
In[15:11]==5'b00110
)?1:0;//WB

endmodule

