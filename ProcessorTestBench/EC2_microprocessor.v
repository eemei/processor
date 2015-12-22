module EC2_microprocessor (Enter, Input, Clock, Reset, Halt,   Q_Meminst, Q_ram, Q_A,Asel,   Output,Initialize, state, IR );

	input Enter;
	input [7:0] Input;
	input Clock, Reset;
	output [7:0] Output;
	output Halt;
	
	output [7:0] Q_ram, Q_A;
	output [4:0] Q_Meminst; 
	output [1:0] Asel;
	input Initialize;
	output [3:0] state;
	output [2:0] IR;
	
	wire IRload, Aload, Sub, JMPmux, PCload, Meminst, MemWr,Aeq0, Apos;
	//wire [1:0] Asel;
	// wire [2:0] IR;
	wire [3:0] nstate; 
	wire [4:0] addr;
	
	CU ControlUnit (Reset, Clock, IRload, Aload, Sub, JMPmux, PCload, 
									Meminst, MemWr, Halt,Asel, IR, Aeq0, Apos, Enter, state, nstate);
	
	//Aeq0, Apos,IR,addr,Output, Q_Meminst, Q_ram, Q_A, Initialize
	DP DataPath (Reset, Clock,IRload,JMPmux,PCload, Meminst, MemWr, Aload, Sub, Asel,Input,
						Aeq0, Apos,IR,addr,Output,  Q_Meminst, Q_ram, Q_A,  Initialize);

endmodule 