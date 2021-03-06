module storeRAM (Clock, WE, data_IN, data_Out, Initialize, addr);

input Clock, WE, Initialize; 
input [4:0] addr; 
input [7:0] data_IN;
output reg [7:0] data_Out;

reg [7:0] AddrStore [31:0];

always @(posedge Clock)
	begin
		if(Initialize)
			begin
			AddrStore[5'b00000]	= 8'b10000000;
			AddrStore[5'b00001]	= 8'b00111110;
			AddrStore[5'b00010]	= 8'b10000000;
			AddrStore[5'b00011]	= 8'b00111111;
			AddrStore[5'b00100]	= 8'b00011110;
			AddrStore[5'b00101]	= 8'b01111111;
			AddrStore[5'b00110]	= 8'b10110000;
			AddrStore[5'b00111]	= 8'b11001100;
			AddrStore[5'b01000]	= 8'b00011111;
			AddrStore[5'b01001]	= 8'b01111110;
			AddrStore[5'b01010]	= 8'b00111111;
			AddrStore[5'b01011]	= 8'b11000100;
			AddrStore[5'b01100]	= 8'b00011110;
			AddrStore[5'b01101]	= 8'b01111111;
			AddrStore[5'b01110]	= 8'b00111110;
			AddrStore[5'b01111]	= 8'b11000100;
			AddrStore[5'b10000]	= 8'b00011110;
			AddrStore[5'b10001]	= 8'b11111111;
			AddrStore[5'b11110]	= 8'b00000000;
			AddrStore[5'b11111]	= 8'b00000000;
			end
		else
		begin	
			if (WE)
				AddrStore[addr] = data_IN;
			else 
				data_Out = AddrStore[addr];
		end			
	end

endmodule 
