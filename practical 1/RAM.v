module RAM( data_in, addr, we, clk, data_out);

	input [7:0] data_in;
	input [4:0] addr;
	input we, clk;
	output reg [7:0] data_out;

	// Declare the RAM variable
	reg [7:0] ram[32:0];
	
	// Variable to hold the registered read address
	reg [5:0] addr_reg;
	
	always @ (posedge clk)
	begin
	// Write
		if (we)
			ram[addr] <= data_in;
		else 
			data_out <= ram[addr];	
	end

	
endmodule
