module ControlUnit(outputState, IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub, Halt, Asel, Enter, Clock, Reset, Aeq0, Apos, IR);

input Enter, Clock, Reset, Aeq0, Apos;
input [7:5] IR;
output reg IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub, Halt;
output [3:0]outputState;
output reg [1:0] Asel;
reg [3:0] state, next_state;

parameter S0 = 4'b0000, S1 = 4'b0001, S2 = 4'b0010, S3 = 4'b1000, S4 = 4'b1001, S5 = 4'b1010, S6 = 4'b1011, S7 = 4'b1100, S8 = 4'b1101, S9 = 4'b1110, S10 = 4'b1111;

assign outputState = state;

always @ (posedge Clock)
begin 
	if(Reset)
    state <= S0;  
	else 
		state <= next_state;
end

always @ (state or Enter or IR)
	case(state)
		S0:
			next_state = S1;
		S1:
			next_state = S2;
		S2:
			case(IR)
				3'b000: next_state = S3;
				3'b001: next_state = S4;
				3'b010: next_state = S5;
				3'b011: next_state = S6;
				3'b100: next_state = S7;
				3'b101: next_state = S8;
				3'b110: next_state = S9;
				3'b111: next_state = S10;
			default: 
				next_state = S2;
			endcase
		S3:
			next_state = S0;
		S4:
			next_state = S0;
		S5:
			next_state = S0;
		S6:
			next_state = S0;
		S7:
			if(Enter)
				next_state = S0;
			else
				next_state = S7;
		S8:
			next_state = S0;
		S9:
			next_state = S0;
		S10:
			next_state = S10;
	default:
		next_state = S0;
	endcase

always @ (state or Aeq0 or Apos)
	case(state)
	// start
		S0:
		begin
			IRload = 0;
			JMPmux = 0;
			PCload = 0;
			Meminst = 0;
			MemWr = 0;
			Asel = 2'b00;
			Aload = 0;
			Sub = 0;
			Halt = 0;
		end
	// fetch
		S1:
		begin
			IRload = 1;
			JMPmux = 0;
			PCload = 1;
			Meminst = 0;
			MemWr = 0;
			Asel = 2'b00;
			Aload = 0;
			Sub = 0;
			Halt = 0;
		end
	// decode
		S2:
		begin
			IRload = 0;
			JMPmux = 0;
			PCload = 0;
			Meminst = 1;
			MemWr = 0;
			Asel = 2'b00;
			Aload = 0;
			Sub = 0;
			Halt = 0;
		end
	// load
		S3:
		begin
			IRload = 0;
			JMPmux = 0;
			PCload = 0;
			Meminst = 0;
			MemWr = 0;
			Asel = 2'b10;
			Aload = 1;
			Sub = 0;
			Halt = 0;
		end
	// store
		S4:
		begin
			IRload = 0;
			JMPmux = 0;
			PCload = 0;
			Meminst = 1;
			MemWr = 1;
			Asel = 2'b00;
			Aload = 0;
			Sub = 0;
			Halt = 0;
		end
	// add
		S5:
		begin
			IRload = 0;
			JMPmux = 0;
			PCload = 0;
			Meminst = 0;
			MemWr = 0;
			Asel = 2'b00;
			Aload = 1;
			Sub = 0;
			Halt = 0;
		end
	// sub
		S6:
		begin
			IRload = 0;
			JMPmux = 0;
			PCload = 0;
			Meminst = 0;
			MemWr = 0;
			Asel = 2'b00;
			Aload = 1;
			Sub = 1;
			Halt = 0;
		end
	// input
		S7:
		begin
			IRload = 0;
			JMPmux = 0;
			PCload = 0;
			Meminst = 0;
			MemWr = 0;
			Asel = 2'b01;
			Aload = 1;
			Sub = 0;
			Halt = 0;
		end
	// jz
		S8:
		begin
			IRload = 0;
			JMPmux = 1;
			PCload = Aeq0;
			Meminst = 0;
			MemWr = 0;
			Asel = 2'b00;
			Aload = 0;
			Sub = 0;
			Halt = 0;
		end
	// jpos
		S9:
		begin
			IRload = 0;
			JMPmux = 1;
			PCload = Apos;
			Meminst = 0;
			MemWr = 0;
			Asel = 2'b00;
			Aload = 0;
			Sub = 0;
			Halt = 0;
		end
	// halt
		S10:
		begin
			IRload = 0;
			JMPmux = 0;
			PCload = 0;
			Meminst = 0;
			MemWr = 0;
			Asel = 2'b00;
			Aload = 0;
			Sub = 0;
			Halt = 1;
		end
		
	default:
		begin
		  IRload = 0;
		  JMPmux = 0;
		  PCload = 0;
		  Meminst = 0;
		  MemWr = 0;
		  Asel = 2'b00;
		  Aload = 0;
		  Sub = 0;
		  Halt = 0;
		end
	endcase

endmodule 