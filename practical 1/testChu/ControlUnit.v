/****
	Name 	:	Chu Jaan Horng
	Date 	:	29/9/2015
	Project :	Control Unit of the Enhanced Processor 
****/

module ControlUnit(
	//Status Signals for input except Clock & Reset
	input Clock, Reset, Enter,
	input [7:5]IR,
	input Aeq0, Apos,
	//Control Signals for output
	output reg IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub, Halt,
	output reg [1:0]Asel,
	output reg [3:0]state, next_state
);

	//reg [3:0]state, next_state;
	parameter [3:0]start=4'b0000, fetch=4'b0001, decode=4'b0010, load=4'b1000, store=4'b1001, add=4'b1010, sub=4'b1011, Input=4'b1100, jz=4'b1101, jpos=4'b1110, halt=4'b1111;
	
	//Initialize the state machine
	always@(negedge Clock, negedge Reset)
	begin
		if(~Reset)
		begin
			state<=start;
		end
		else
		begin
			state<=next_state;
		end
	end
	
	// State Machine (Control Unit)
	always@(state, IR, Aeq0, Apos, Enter)
	begin
	//Each of the state will output the control signals to datapath
		case(state)
		start	:	begin
						IRload=0;
						JMPmux=0;
						PCload=0;
						Meminst=0;
						MemWr=0;
						Asel[1:0]=2'b00;
						Aload=0;
						Sub=0;
						Halt=0;
						next_state=fetch;
					end
		fetch	:	begin
						IRload=1;
						JMPmux=0;
						PCload=1;
						Meminst=0;
						MemWr=0;
						Asel[1:0]=2'b00;
						Aload=0;
						Sub=0;
						Halt=0;
						next_state=decode;
					end
		decode	:	begin
						IRload=0;
						JMPmux=0;
						PCload=0;
						//PCload=1; // error
						Meminst=1;
						MemWr=0;
						Asel[1:0]=2'b00;
						Aload=0;
						Sub=0;
						Halt=0;
						case(IR)
						3'b000 : next_state=load;
						3'b001 : next_state=store;
						3'b010 : next_state=add;
						3'b011 : next_state=sub;
						3'b100 : next_state=Input;
						3'b101 : next_state=jz;
						3'b110 : next_state=jpos;
						3'b111 : next_state=halt;
						default: next_state=decode;
						endcase
					end
		load	:	begin
						IRload=0;
						JMPmux=0;
						PCload=0;
						Meminst=0;
						MemWr=0;
						Asel[1:0]=2'b10;
						Aload=1;
						Sub=0;
						Halt=0;
						next_state=start;
					end
		store	:	begin
						IRload=0;
						JMPmux=0;
						PCload=0;
						Meminst=1;
						MemWr=1;
						Asel[1:0]=2'b00;
						Aload=0;
						Sub=0;
						Halt=0;	
						next_state=start;
					end
		add		:	begin
						IRload=0;
						JMPmux=0;
						PCload=0;
						Meminst=0;
						MemWr=0;
						Asel[1:0]=2'b00;
						Aload=1;
						Sub=0;
						Halt=0;
						next_state=start;
					end
		sub		:	begin
						IRload=0;
						JMPmux=0;
						PCload=0;
						Meminst=0;
						MemWr=0;
						Asel[1:0]=2'b00;
						Aload=1;
						Sub=1;
						Halt=0;
						next_state=start;
					end
		Input	:	begin
						IRload=0;
						JMPmux=0;
						PCload=0;
						Meminst=0;
						MemWr=0;
						Asel[1:0]=2'b01;
						Aload=1;
						Sub=0;
						Halt=0;
					if(Enter)
						next_state=start;
					else
						next_state=Input;
					end
		jz		:	begin
						IRload=0;
						JMPmux=1;
						PCload=Aeq0;
						Meminst=0;
						MemWr=0;
						Asel[1:0]=2'b00;
						Aload=0;
						Sub=0;
						Halt=0;
						next_state=start;
					end
		jpos	:	begin
						IRload=0;
						JMPmux=1;
						PCload=Apos;
						Meminst=0;
						MemWr=0;
						Asel[1:0]=2'b00;
						Aload=0;
						Sub=0;
						Halt=0;
						next_state=start;
					end
		halt	:	begin
						IRload=0;
						JMPmux=0;
						PCload=0;
						Meminst=0;
						MemWr=0;
						Asel[1:0]=2'b00;
						Aload=0;
						Sub=0;
						Halt=1;
						next_state=halt;
					end
		default	:	next_state=start;
		endcase
	end
endmodule 