module finalMicroprocessor(input [9:0] SW,
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

// assign FPGA pins
// input pins
assign Input = SW[7:0];
assign Reset = SW[8];
assign Enter = SW[9];

// output pins
assign LEDR[9:0] = {Output, Halt};

seg7 sevenSeg(outputState, HEX3);

always @ (posedge CLOCK_50)
	begin
		if(count == 2500000)
		begin
			count <= 0;
			Clock <= ~Clock;
		end
		else
			count = count + 1;
	end

	Microprocessor mp(outputState, Input,Output,Reset,Enter,Halt,Clock);
endmodule 		   