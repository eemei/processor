module Aregistertb();

reg [7:0]data, Input;
reg [1:0]Asel;
reg clk, reset;
reg Aload, Sub;
wire [7:0] Output;
wire Aeq0, Apos;
integer i;

Aregister Aregistertb(data, Input, Asel, Aload, clk, reset, Sub, Aeq0, Apos, Output);

initial begin 
clk = 0;
reset = 1;
data = 8'b10101010;
Input = 8'b01010101;
assign i = Asel;
for (i =0; i < 4; i =i+1) begin 
  #2 load= 0; $display ("output = %b", output);
  #2 load= 1; $display ("output = %b", output);
  end  
 end 
 
always #1 clk = ~clk;

endmodule 

