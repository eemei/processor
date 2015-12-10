module CUtb ();

//...declaration input as reg and output as wire...
	reg Reset, 
			Clock;
	wire IRload,
	     Aload,
			 Sub;
	wire JMPmux,
	     PCload,
			 Meminst,
			 MemWr;
	wire [1:0]	Asel,
							Halt;
	reg [2:0] IR;
	reg	Aeq0, 
	    Apos,
			Enter;
		
initial begin 
//..intialize the input 
	Clock = 0;
	Reset = 1;
	IR = 3'b000;
	Aeq0 = 0;
	Apos = 0;
	Enter = 0;
//..strt delay mode..
#2 Reset = 0; Aeq0 = 0; Apos = 0; Enter = 0;
#6 IR = 3'b001; Aeq0 = 0; Apos = 0; Enter = 0;
#3 IR = 3'b010; Aeq0 = 0; Apos = 0; Enter = 0;
#3 IR = 3'b011; Aeq0 = 0; Apos = 0; Enter = 0;
#3 IR = 3'b100; Aeq0 = 0; Apos = 0; Enter = 0;
#3 IR = 3'b100; Aeq0 = 0; Apos = 0; Enter = 1;
#3 IR = 3'b101; Aeq0 = 0; Apos = 0; Enter = 0;
#3 IR = 3'b101; Aeq0 = 1; Apos = 0; Enter = 0;
#3 IR = 3'b110; Aeq0 = 0; Apos = 0; Enter = 0;
#3 IR = 3'b110; Aeq0 = 0; Apos = 1; Enter = 0;
#3 IR = 3'b111; Aeq0 = 0; Apos = 0; Enter = 0;
#100 $finish;          /*terminal stimulaton*/
end

//...clock pulse genneartor.....
always #1 Clock = ~Clock;

//..connect module to test bench..
 CU CUtb (Reset, Clock, IRload,Aload,Sub,JMPmux,PCload, Meminst, MemWr,Asel,Halt,IR,
					Aeq0, Apos, Enter);

endmodule 