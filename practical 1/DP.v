module DP (
	input Reset, Clock,
	input IRload,JMPmux, 
	input PCload, Meminst, MemWr, Aload, Sub,
	input [1:0] Asel,
	//input [7:0] D,
	output Aeq0, Apos,
	output [7:0] IR
    );
    wire [7:0] D;

	//register8bit #(8) (IR,D,IRload,Clock,Reset);



endmodule
