module DPHardware (
	input[9:0]SW, 
	output[9:0]LEDR,
	output[7:0]LEDG,
	input CLOCK_50,
	input [0:0] KEY);

	
	wire Enter;
	wire [7:0] Input;
	wire Clock, Reset;
	wire [7:0] Output;
	wire Halt;
	
	wire Initialize;
	wire [3:0] state;

assign Input = 8'b10101010;
assign {IRload, JMPmux, PCload, Meminst, MemWr, Asel, Aload, Sub} = SW[9:0];
assign LEDR[4:0] = {IR, Aeq0, Apos};
assign LEDG[7:0] = Output;

Part1 Clockdiv (CLOCK_50, CLOCKOUT);	
EC2_microprocessor Processor (Enter, Input, Clock, Reset, Halt, Output,Initialize, state );

endmodule 
