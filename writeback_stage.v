module writeback_stage(In, Out);
input [41:0]    In;
output [19:0]   Out;

wire selector;
assign selector = In[0] | In[2];

mux_2x1_16bit m(.I0(In[25:10]), .I1(In[41:26]), .S(selector), .O(Out[18:3]));

assign Out[2:0] = In[6:4];
assign Out[19] = In[1];

endmodule