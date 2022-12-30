module control_unit(In,Output);
input [15:0]In;
output [15:0]Output;



//and(Output[15], ~In[15] , ~In[14], In[13] , In[12] , In[11]);//flags

assign Output[15]=(
In[15:14]==2'b10||
In[15:11]==5'b00000||
In[15:11]==5'b00010||
In[15:11]==5'b00011||
In[15:11]==5'b00001
)?0:1;//flag saving

and(Output[14], ~In[15] , ~In[14], In[13] , In[12] , In[11]);//ldm
assign Output[13]=(In[15:11]==5'b00001||//setc
In[15:11]==5'b11111||//nop
In[15:11]==5'b11101||//rti
In[15:11]==5'b00011||//clrc
In[15:11]==5'b11100||//ret
In[15:11]==5'b00111||//ldm
In[15:11]==5'b10100||//shl
In[15:11]==5'b10101||//shr
In[15:11]==5'b01110//ldd
)?1:0;//immmediate or single operand inst
and(Output[12], ~In[15] ,  In[14], In[13] , In[12] ,  In[11]);//std   
and(Output[11], In[15] , In[14], ~In[13] , In[12] , In[11]);//jmp
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
and(Output[2], ~In[15] , In[14] , In[13] , ~In[11]);//mem read
and(Output[1], ~In[15] , In[14] , In[13] , In[11]);//mem write
assign Output[0]=(In[15:14]==2'b10||
In[15:11]==5'b01101||
In[15:11]==5'b01111||

In[15:11]==5'b00101||
In[15:11]==5'b00111||
In[15:11]==5'b00010||
In[15:11]==5'b00000
||In[15:11]==5'b01110
)?1:0;//WB

endmodule

