module mux1_2(Q, sel, a, b);

	input sel;
	input[4:0] a, b;
	output [4:0] Q;
	/*
	always@(sel,a,b)begin
	if (sel) // sel 1 = a
		Q = a;
	else
		Q = b;
	end
	*/
	
	assign Q = sel ? a : b;

endmodule
