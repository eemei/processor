module Processor(

	input Clock, Reset, Enter, Enable,
	input [7:0]Input,
	
	output Halt,
	output [7:0]Output
);
	
	wire IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub, Aeq0, Apos;
	wire [1:0]Asel;
	wire [7:5]IR;
	wire [3:0] state, nstate;

	CU ContriMei (Reset, Clock, IRload, Aload, Sub, JMPmux, PCload, Meminst, MemWr, Halt,
						Asel, IR, Aeq0, Apos, Enter, state, nstate);
	
	Datapath 	DP (.Clock(Clock), .Reset(Reset), .Enable(Enable), .IRload(IRload), .JMPmux(JMPmux), .PCload(PCload), .Meminst(Meminst), .MemWr(MemWr), .Aload(Aload), .Sub(Sub), .Asel(Asel), .Input(Input), .Aeq0(Aeq0), .Apos(Apos), .IR(IR), .Output(Output));
	
endmodule 