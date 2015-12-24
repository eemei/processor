module Part1(
	input CLOCK_50,
	output reg CLOCKOUT
);

	//integer value = 25000000;
		integer value = 5000000;
	integer count;
	
	always@(posedge CLOCK_50)begin
		if (count < 5000000) begin
			count = count + 1;
			end
		else begin
			CLOCKOUT = ~CLOCKOUT;
			count = 0;
		end
	end
	
 endmodule 