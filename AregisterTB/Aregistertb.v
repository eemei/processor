module Aregistertb();

reg [7:0]data, Input;
reg [1:0]Asel;
reg clk, reset;
reg Aload, Sub;
wire [7:0] Output;
wire Aeq0, Apos;
wire [7:0] Q_addsub;
wire [7:0] Q_A, D_A;
//integer i;

Aregister Aregistertb( data, Input, Asel, Aload, clk, reset, Sub, Aeq0, Apos, Output, Q_A, Q_addsub, D_A);



initial begin 
clk = 0;
reset = 1;
data = 8'b000000001;
Input = 8'b00000011;



#2 Asel = 2'b01; Aload= 0;
#2 Asel = 2'b01; Aload= 1;
#2 Asel = 2'b01;Aload= 1; Sub = 1;
#2 Asel = 2'b01; Aload= 1; Sub = 0;

#2 Input = 8'b00001111;
#2 Asel = 2'b01; Aload= 1; Sub = 1;
#2 Asel = 2'b01; Aload= 1; Sub = 0;

#2 Asel = 2'b00; Aload= 0;
#2 Asel = 2'b00; Aload= 1; Sub = 1;
#2 Asel = 2'b00; Aload= 1; Sub = 0;


 
#2 Asel = 2'b10; Aload= 0;
#2 Asel = 2'b10; Aload= 1; Sub = 1;
#2 Asel = 2'b10; Aload= 1; Sub = 1;  

#2 Asel = 2'b11; Aload= 0;
#2 Asel = 2'b11; Aload= 1; Sub = 1;
#2 Asel = 2'b11; Aload= 1; Sub = 1;
 end 
 
 initial begin 
   $display ("input:       data:         Asel:        Sub:         D_A:       Q_addsub       q_A      Aload     Apos    Aeq0");
   $monitor ("%d          %d         %b         %b       %d           %d       	%b         %d   %d      %d"
   ,Input, data, Asel, Sub,D_A, Q_addsub,Q_A, Aload,Apos,Aeq0);
end 
 
always 
#1 clk = ~clk;

endmodule 

