`timescale 1ns/1ns
module barrel2_tb();

	reg Clock, Reset;
	reg Load;
	reg [2:0] Select;
	reg [7:0] Data_in;
	wire [7:0] Data_out;
	wire [7:0] Data_out2;
	
	
	integer i, j; 
	integer error;
	
	// Module instantiation
	barrel #(.data_size(8)) barr2(.clk(Clock),.reset(Reset),.sel(Select),.Load(Load),
									.data_in(Data_in),.data_out(Data_out));
	
		
	// Clock initialization
	initial begin
		Clock <= 0;
		forever #1 Clock = ~Clock;
	end
	
	// Reset initialization
	initial begin
		Reset <= 1;
		@(posedge Clock);
		@(negedge Clock) Reset = 0;
	end
	
	// Main loop
	initial begin
		#1 initialize_input();
		#1 generate_input();
		#1 summary_report();
		$finish;
	end
	
	// inputs initialization
	task initialize_input;
	
		begin
		Load = 0;
		Select = 0;
		Data_in = 0;
		error = 0;
		end
	endtask
	
	// inputs generation
	task generate_input;

    
    begin
		for(j=0;j<3;j=j+1) begin
			 Load = 1;
			#2 Data_in = {$random}%256;
			   Select = 0;
			for(i=0;i<=7;i=i+1) begin
				#4 verify_output(Data_out, Data_out2);
				#2 Select = Select + 1;
			end 
		end
		end
	endtask
		
	// outputs verification 
	task verify_output;
		input [7:0] simulated_value;
		input [7:0] expected_value;
		
		begin
		if (simulated_value != expected_value) begin
			error = error + 1;
			$display("Simulated value = %b, Expected Value = %b, error = %d, at time = %d",
					  simulated_value, expected_value, error, $time);
		end
		else
		  $display("Done!! %d Simulated value = %b, Expected Value = %b, Data_in = %b, i = %d",
					$time, simulated_value, expected_value, Data_in, i);
		end
	endtask
	
	// summary report
	task summary_report;

		begin
		if(error == 0)
			$display("Test Completed. ALL MATCH \:\)");
		else
			$display("Test Completed. Matchching Failed \:\(   error\(s\).");//, error);
	  end
	endtask
	
	
	
	// barrel shifter device
	
	wire [7:0] brl_in;
	wire [2:0] selector;
	wire [15:0] brl_double;
	wire [7:0] brl;
	reg [7:0] brl_out;
	
	assign selector = Select;
	assign brl_in = Load?Data_in:Data_out;
	
	assign brl_double = {brl_in,brl_in};
	assign brl = brl_double[selector +:8];
		
	always@(posedge Clock) begin
			if (Reset)
				brl_out <= 0;
			else
				 brl_out <= brl;
	end
	assign Data_out2 = brl_out;
	
	endmodule
	
	