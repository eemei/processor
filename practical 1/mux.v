module mux #(parameter width =4)(q, sel, a, b);

	input sel;
	input[width-1:0] a, b;
	output[width-1:0] q;
	

	assign q = sel ? b : a;

endmodule
