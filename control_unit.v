module control_unit(In,Output);
input [15:0]In;
output [7:0]Output;

// assign Output[0]= ~In[15] && In[14] && In[13] && In[11] ;//meme read-out
// assign Output[1]= ~In[15] && In[14] && In[13] && ~In[11] ;//mem write-in

// assign Output[2]= ~In[15] && In[14] && In[13] && ~In[12]&&~In[11] ;//push
// assign Output[3]= ~In[15] && In[14] && In[13] && ~In[12]&& In[11] ;//pop
// assign Output[4]= ~In[15] && In[14] && In[13] && In[12]&& ~In[11] ;//ldd


// // assign Output[5]= ~In[15] && In[14] && In[13] && In[12]&& In[11] ;//std




and(Output[0], ~In[15] , In[14] , In[13] , In[11]);//mem read
and(Output[1], ~In[15] , In[14] , In[13] , ~In[11]);//mem write

and(Output[2], ~In[15] , In[14], In[13] , ~In[12] , ~In[11]);//push
and(Output[3], ~In[15] , In[14], In[13] , ~In[12] , In[11]);//pop
and(Output[4], ~In[15] , In[14], In[13] , In[12] , In[11]);//ldd
and(Output[5], ~In[15] , In[14], In[13] , In[12] , ~In[11]);//std

assign Output[6]=(In[15:11]==5'b00001||
In[15:11]==5'b11111||
In[15:11]==5'b11101||
In[15:11]==5'b00011||
In[15:11]==5'b11100||
In[15:11]==5'b00111||
In[15:11]==5'b10100||
In[15:11]==5'b10101)?1:0;//immmediate or single operand inst
assign Output[7]=(In[15:14]==2'b10||
In[15:11]==5'b01101||
In[15:11]==5'b01111||

In[15:11]==5'b00101||
In[15:11]==5'b00111||
In[15:11]==5'b00010||
In[15:11]==5'b00000
)?1:0;

endmodule

