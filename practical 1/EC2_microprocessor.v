module EC2_microprocessor (Enter, Input, Clock, Reset, Halt, Output);
	input Enter;
	input [7:0] Input;
	input Clock, Reset;
	output [7:0] Output;
	output Halt;
	
	wire IRload, Aload, Sub, JMPmux, PCload, Meminst, MemWr,Aeq0, Apos;
	wire [1:0] Asel;
	wire [2:0] IR;
	wire [3:0] state, nstate, addr;
	
	CU ControlUnit (Reset, Clock, IRload, Aload, Sub, JMPmux, PCload, 
									Meminst, MemWr, Halt,Asel, IR, Aeq0, Apos, Enter, state, nstate);
	
	DP DataPath (Reset, Clock,IRload,JMPmux,PCload, Meminst, MemWr, Aload, Sub, Asel,Input,
						Aeq0, Apos,IR,addr,Output);

endmodule 