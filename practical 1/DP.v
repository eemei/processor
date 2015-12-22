module DP ( Reset, Clock,IRload,JMPmux,PCload, Meminst, MemWr, Aload, Sub, Asel,Input,
						Aeq0, Apos,IR,addr,Output);
						
	input Reset, Clock;
	input IRload,JMPmux; 
	input PCload, Meminst, MemWr, Aload, Sub;
	input [1:0] Asel;
	input [7:0] Input;
	output Aeq0, Apos;
	output [2:0]IR;
	output [4:0]addr;
	output [7:0]Output;
	
	wire [7:0] Q_IR, Q_ram, Q_A, Q_addsub, D_A;
	wire [4:0] D_PC, Q_Incr,Q_PC,Q_Meminst, Q_IRmux;

	register8bit #(.SIZE(8)) IRreg (Q_IR,Q_ram,IRload,Clock,Reset); 
	mux1_2 JMPMux (D_PC, JMPmux,Q_IRmux, Q_Incr);
	register8bit #(.SIZE(5)) PCreg (Q_PC, D_PC, PCload, Clock, Reset);
	counter Incr(Q_PC, Q_Incr);
	mux1_2 Memmux (Q_Meminst, Meminst, Q_IRmux, Q_PC); 
	RAM RAM32 (Q_A, Q_Meminst, MemWr,Clock, Q_ram);
	mux2_4 muxA(Asel, Q_addsub,Input, Q_ram, 8'd0, D_A);
	register8bit #(.SIZE(8)) Amux (Q_A,D_A,Aload,Clock,Reset);
	addsub AddSub (Q_A,Q_ram,Sub,Q_addsub);

	assign IR = Q_IR[7:5];
	assign Q_IRmux = Q_IR[4:0];
	
	
	assign Output = Q_A;
	assign Apos = ~Q_A[7];
	//assign Aeq0 = (Q_A == 0)? 1'b1: 1'b0; //Q_A== 0 -> 1 
	assign Aeq0 = ~( Q_A[0]| Q_A[1]| Q_A[2]| Q_A[3]| Q_A[4]| Q_A[5]| Q_A[6]| Q_A[7]);

endmodule
