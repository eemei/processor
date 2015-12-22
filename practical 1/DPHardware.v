module DPHardware (
	input[9:0]SW, 
	output[9:0]LEDR,
	output[7:0]LEDG,
	input CLOCK_50,
	input [0:0] KEY);

	
wire Reset,IRload,JMPmux, PCload, Meminst, MemWr, Aload, Sub;
wire [1:0] Asel;
wire [7:0] Input;
wire Aeq0, Apos;
wire [2:0]IR;
wire [4:0]addr;
wire [7:0]Output;
wire [9:0] CLOCKOUT;

assign Input = 8'b10101010;
assign {IRload, JMPmux, PCload, Meminst, MemWr, Asel, Aload, Sub} = SW[9:0];
assign LEDR[4:0] = {IR, Aeq0, Apos};
assign LEDG[7:0] = Output;

Part1 Clockdiv (CLOCK_50, CLOCKOUT);	
DP DataPath( Reset, CLOCKOUT,IRload,JMPmux,PCload, Meminst, MemWr, Aload, Sub, Asel,Input,
						Aeq0, Apos,IR,addr,Output);

endmodule 
