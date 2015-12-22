module ClockDivider25M_4Hz(
	input CLOCK_25,
	output reg [9:0]CLOCKOUT
);

	integer value = 3125000;
	integer count;
	
	always@(posedge CLOCK_25)begin
		if (count < 3125000) begin
			count = count + 1;
		end
		else begin
			CLOCKOUT = ~CLOCKOUT;
			count = 0;
		end
	end
	
 endmodule 