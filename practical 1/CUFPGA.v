module CUFPGA(
	input [5:0] SW,
	input CLOCK_50,
	input [0:0] KEY,
	output [7:0] LEDG,
	output [9:0] LEDR
	);

	
	wire Reset,Aeq0, Apos, Enter;
	wire [2:0] IR;
	wire IRload,Aload,Sub,JMPmux,PCload, Meminst, MemWr, Halt;
	wire [1:0] Asel;
	wire [3:0] state, nstate;
	wire [9:0] CLOCKOUT;
	
	assign Reset = KEY[0] ;
	assign Aeq0 = SW[0];
	assign Apos = SW[1];
	assign Enter = SW[2];
	assign IR[2:0] = SW[5:3];
	assign LEDR[3:0] = state;
	assign LEDR[4] = IRload;
	assign LEDR[5] = Aload;
	assign LEDR[6] = Sub;
	assign LEDR[7]= JMPmux;
	assign LEDR[8]= PCload;
	assign LEDR[9]= Meminst;
	assign LEDG[0]= MemWr;
	assign LEDG[1]= Halt;
	assign LEDG[3:2]= Asel; 
	
	Part1 Clockdiv (CLOCK_50, CLOCKOUT);	
	CU ControlUnit (Reset, CLOCKOUT, IRload,Aload,Sub, JMPmux,PCload, Meminst, MemWr, Halt, Asel,IR, Aeq0, Apos, Enter,state, nstate);
	
	endmodule 
	