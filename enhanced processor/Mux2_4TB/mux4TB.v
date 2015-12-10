module mux4TB();
  //output wire, input reg
 	reg [1:0]sel;
	reg [7:0]a, b, c, d; 
	wire [7:0] Q;
	
	//instatiate
	mux2_4 mux4TB( sel, a, b, c, d, Q);
	
	initial begin 

	a=7'b0000001; b=7'b0000011; c=7'b0000111;d=7'b0001111;
	#2 sel = 2'b10;
	#4 sel = 2'b01;
	#2 sel = 2'b11;
	#2 sel = 2'b00;
	#10 $finish;
	end
	
	endmodule 