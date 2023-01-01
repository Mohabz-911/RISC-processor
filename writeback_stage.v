module writeback_stage(In, Out, clk, rst);
input [57:0]    In;
input clk , rst;
output [35:0]   Out;

wire [15:0] WBValue;

reg [15:0] outPort;

select_wb_value s(.DataOut(In[41:26]) ,
                 .AluOutput(In[25:10]) , 
                 .MemorySignal(In[6] | In[5] | In[4] | In[3]) ,
                 .InPort(In[57:42]) ,
                 .InSignal(In[2]) ,
                 .WBValue(WBValue));


always@(posedge clk)begin
    if (rst) outPort = 16'b0;
    else if(In[1]) outPort = In[25:10];
end

assign Out = {outPort, WBValue , In[9:7] , In[0]};                 
// wire selector;
// assign selector = In[0] | In[2];

// mux_2x1_16bit m(.I0(In[25:10]), .I1(In[41:26]), .S(selector), .O(Out[18:3]));

// assign Out[2:0] = In[6:4];
// assign Out[19] = In[1];

endmodule