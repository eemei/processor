module mux2_4 (
 // input clk,
	input [1:0]sel,
	input [7:0]a, b, c, d, 
	output reg [7:0] Q
	);

	always@(sel, a, b, c, d)
	case (sel)
		2'b00: Q = a;
		2'b01: Q = b;
		2'b10: Q = c;
		2'b11: Q = d;
		default; //Q = 2'bxx;
	endcase
endmodule 
