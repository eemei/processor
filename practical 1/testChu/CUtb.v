module CUtb ();

//...declaration input as reg and output as wire...
	reg Clock, Reset, Enter;
	reg [7:5]IR;
	reg Aeq0, Apos;

	wire IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub, Halt;
	wire [1:0]Asel;
	wire [3:0]state, next_state;



initial begin 
//..intialize the input 
	Clock = 0;
	Reset = 1;
	IR = 3'b000;
	Aeq0 = 0;
	Apos = 0;
	Enter = 0;
//..strt delay mode..
#8  Reset = 0; Aeq0 = 0; Apos = 0; Enter = 0;
#8 IR = 3'b000;
#8 IR = 3'b001;
#8 IR = 3'b010;
#8 IR = 3'b011;
#8 IR = 3'b100; Enter = 0;
#8 IR = 3'b100; Enter = 1;
#8 IR = 3'b101; 	Aeq0 = 0;
#8 IR = 3'b101; 	Aeq0 = 1;
#10 IR = 3'b110; 	Apos = 0;
#10 IR = 3'b110; 	Apos = 1;
#10 IR = 3'b111;
#200 $finish;          /*terminal stimulaton*/
end

//...clock pulse genneartor.....
always #1 Clock = ~Clock;

//..connect module to test bench..
 ControlUnit CU(Clock, Reset, Enter, IR, Aeq0, Apos, IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub, Halt, Asel, state, next_state);
	endmodule 
	
	
	
