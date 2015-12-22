module HardwareProcessor(input [9:0] SW,
						   input CLOCK_50,
						   output [9:0] LEDR,
						   output [6:0] HEX3);


wire Reset,Enter;
wire [7:0] Input ;
wire [7:0] Output ;
wire Halt;
wire [3:0] outputState;
reg Clock = 0;
integer count  = 32'd0;


assign Input = SW[7:0];
assign Reset = SW[8];
assign Enter = SW[9];

assign LEDR[9:0] = {Output, Halt};

Part1 Clockdiv (CLOCK_50, CLOCKOUT);	
	DP DataPath (Reset, CLOCKOUT,IRload,JMPmux,PCload, Meminst, MemWr, Aload, Sub, Asel,Input,
						Aeq0, Apos,IR,addr,Output,  Q_Meminst, Q_ram, Q_A,  Initialize);