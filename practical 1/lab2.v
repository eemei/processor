module lab2 (
	input Reset, Clock,
	output reg IRload,Aload,Sub,
	output reg JMPmux,PCload, Meminst, MemWr,
	output reg [1:0] Asel,Halt,
	input [2:0] IR,
	input Aeq0, Apos, Enter
	
	);
	
	reg[3:0] state,nstate;
	
	parameter  [3:0] start=4'b0000,
					  fetch=4'b0001,
					  decode=4'b0010,
					  load=4'b1001,
					  store=4'b1001,
				      add=4'b1010,
				      sub=4'b1011,
				      Input=4'b1100,
				      jz=4'b1101,
				      jpos=4'b1110,
				      halt=4'b1111;
				      
				      
	always@(posedge Reset, posedge Clock)
	begin
		if (Reset)
		  begin
			state<= start;
			end
		else
			state<=nstate;
	end
	
always@(state, IR, Enter)begin 

	case(state)
	start:begin
			IRload=0;
			JMPmux=0;
			PCload=0;
			Meminst=0;
			MemWr=0;
			Asel[1:0]=2'b00;
			Aload=0;
			Sub=0;
			Halt =0;
		  nstate=fetch;
		  end
		  
	fetch:begin
			IRload=1;
			JMPmux=0;
			PCload=1;
			Meminst=0;
			MemWr=0;
			Asel[1:0]=2'b00;
			Aload=0;
			Sub=0;
			Halt =0;
		  nstate=decode;
		  end
	
	decode:begin
			IRload=0;
			JMPmux=0;
			PCload=0;
			Meminst=1;
			MemWr=0;
			Asel[1:0]=2'b00;
			Aload=0;
			Sub=0;
			Halt =0;
			nstate=load;
			if(IR[2:0]== 3'b000)
			begin
			nstate=load;
			end
			if(IR[2:0]== 3'b001)
			begin
			nstate=store;
			end
			if(IR[2:0]== 3'b010)
			begin
			nstate=add;
			end
			if(IR[2:0]== 3'b011)
			begin
			nstate=sub;
			end
			if(IR[2:0]== 3'b100)
			begin
			nstate=Input;
			end
			if(IR[2:0]== 3'b101)
			begin
			nstate=jz;
			end
			if(IR[2:0]== 3'b110)
			begin
			nstate=jpos;
			end
			if(IR[2:0]== 3'b111)
			begin
			nstate=halt;
			end
			end
	load:begin
			IRload=0;
			JMPmux=0;
			PCload=0;
			Meminst=0;
			MemWr=0;
			Asel[1:0]=2'b10;
			Aload=1;
			Sub=0;
			Halt =0;
		  nstate=start;
		  end
		  
	store:begin
			IRload=0;
			JMPmux=0;
			PCload=0;
			Meminst=1;
			MemWr=1;
			Asel[1:0]=2'b00;
			Aload=1;
			Sub=0;
			Halt =0;
		  nstate=start;
		  end
		  
	add:begin
			IRload=0;
			JMPmux=0;
			PCload=0;
			Meminst=0;
			MemWr=0;
			Asel[1:0]=2'b00;
			Aload=1;
			Sub=0;
			Halt =0;
		  nstate=start;
		  end

	sub:begin
			IRload=0;
			JMPmux=0;
			PCload=0;
			Meminst=0;
			MemWr=0;
			Asel[1:0]=2'b00;
			Aload=1;
			Sub=1;
			Halt =0;
		  nstate=start;
		  end
		  
	Input:begin
			IRload=0;
			JMPmux=0;
			PCload=0;
			Meminst=0;
			MemWr=0;
			Asel[1:0]=2'b01;
			Aload=1;
			Sub=0;
			Halt =0;
			if (Enter)
			begin
		  nstate=start;
		  end
		  else 
		  begin
		  nstate=Input;
		  end
		  end
		  
	jz:begin
			IRload=0;
			JMPmux=1;
			PCload=Aeq0;
			Meminst=0;
			MemWr=0;
			Asel[1:0]=2'b00;
			Aload=0;
			Sub=0;
			Halt =0;
		  nstate=start;
		  end
		  
	jpos:begin
			IRload=0;
			JMPmux=1;
			PCload=Apos;
			Meminst=0;
			MemWr=0;
			Asel[1:0]=2'b00;
			Aload=0;
			Sub=0;
			Halt =0;
		  nstate=start;
		  end
		  
		  
	halt:begin
			IRload=0;
			JMPmux=0;
			PCload=0;
			Meminst=0;
			MemWr=0;
			Asel[1:0]=2'b00;
			Aload=0;
			Sub=0;
			Halt =1;
		  nstate=halt;
		  end

		                            
	default:nstate=start;
	endcase
	end
	endmodule
	
	
	