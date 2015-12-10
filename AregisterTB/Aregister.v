module Aregister( data, Input, Asel, Aload, clk, reset, Sub, Aeq0, Apos, Output, Q_A, Q_addsub, D_A);

input [7:0]data, Input;
input [1:0]Asel;
input clk, reset;
input Aload, Sub;
output [7:0] Output;
output Aeq0, Apos;
output [7:0] Q_addsub;
output [7:0] Q_A, D_A;
	
	mux2_4 muxA(Asel, Q_addsub,Input, data, 8'dx, D_A);
	register8bit #(.SIZE(8)) Amux (Q_A,D_A,Aload,clk,reset);
	addsub AddSub (Q_A,data,Sub,Q_addsub); // add= 1 from Q_A  module addsub( dataa, datab, add_sub, result);
	
	assign Output = Q_A;
	assign Apos = ~Q_A[7];
	//assign Aeq0 = (Q_A == 0)? 1'b1: 1'b0; //Q_A== 0 -> 1 
	assign Aeq0 = ~( Q_A[0]| Q_A[1]| Q_A[2]| Q_A[3]| Q_A[4]| Q_A[5]| Q_A[6]| Q_A[7]);
	endmodule 
	
