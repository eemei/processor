module EC2_microprocessor (Enter, Input, Clock, Reset, Halt, Output,Initialize, state );

	input Enter;
	input [7:0] Input;
	input Clock, Reset;
	output [7:0] Output;
	output Halt;
	
	input Initialize;
	output [3:0] state;

	
	wire IRload, Aload, Sub, JMPmux, PCload, Meminst, MemWr,Aeq0, Apos;
  wire [1:0] Asel;
	wire [2:0] IR;
	wire [3:0] nstate; 
	wire [4:0] Q_Meminst,Q_Incr, D_PC, Q_PC, Q_IRmux;
	wire [7:0] Q_IR, Q_ram, Q_A, Q_addsub, D_A;
	
	CU ControlUnit (Reset, Clock, IRload, Aload, Sub, JMPmux, PCload, 
									Meminst, MemWr, Halt,Asel, IR, Aeq0, Apos, Enter, state, nstate);
	
	//Aeq0, Apos,IR,addr,Output, Q_Meminst, Q_ram, Q_A, Initialize
  DP  DATAPATH( Reset, Clock,IRload,JMPmux,PCload, Meminst, MemWr, Aload, Sub, Asel,Input,
						Aeq0, Apos,IR,Output,Q_IR, Q_ram, Q_A, Q_addsub, D_A,D_PC, Q_Incr,Q_PC,Q_Meminst, Q_IRmux, Initialize);

endmodule 