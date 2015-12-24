module HardwareProcessor(input [9:0] SW,
						   input CLOCK_50,
               input [3:0] KEY,
						   output [9:0] LEDR,
						   output [7:0] LEDG);


	wire Enter;
	wire [7:0] Input;
	wire Clock, Reset;
	wire [7:0] Output;
	wire  Halt;
	
	wire  Initialize;
	wire  [3:0] state;         
               
               
              

assign Input[7:0] = SW[7:0];
assign Initialize = SW[8];
assign Enter = SW[9];
assign Reset = KEY[0];
assign LEDG [7:4] = state;
//assign LEDR [7:0] = Output;


assign LEDR[9:0] = {Output, Halt};

Part1 Clockdiv (CLOCK_50, CLOCKOUT);	
EC2_microprocessor (Enter, Input, CLOCKOUT, Reset, Halt, Output,Initialize, state );



            
endmodule 
            