`timescale 1ns/1ns

module BarrelTB ();
// wire as output :
reg reset, clk;
reg [7:0] data_in;
reg load;
reg [2:0] select;
wire [7:0]data_out;
integer i, j; 
integer error;
//wire [7:0] brl_in;
//wire [7:0] brl_out;

barrel2 #(.data_size (8))barrelTb (.Load(load), 
.sel(select), .reset(reset), .clk(clk),.data_out(data_out), .data_in(data_in)); 

initial begin  
clk <= 0;
forever #1 clk = ~clk; end

initial begin 
	reset <= 0;
	@(posedge clk);
	@(negedge clk) reset =1; end

initial begin
	data_in = 0;
	clk=0;
	load =0;
	reset = 1;
	reset =0;
	barrelshift_verify;
	//Reset;
	//error_verify;
 // data_in random , sel use for loop
 // reset error count
end 
	

task Reset;
	//input [7:0] D_mux;
	//input [7:0] brl_in;
	//output [7:0] brl_out;
	
	//assign brl_in = load?data_in:br1_out;

	if (reset)
		if(data_out == 0)
		#2 $display ("successful for reset:)");
		else 
		begin
		  $display ("reset = %d, error= %d", reset, error);
		  error = error+1; 
		end
	//if(load)
			
	endtask

	
task barrelshift_verify;
	integer i, j;
	integer errors;

	for (i= 0; i<3; i= i+1)begin
		#2 data_in = {$random}%3;
		#4 load =1;
		#4 load =0;
		for (j= 0; j<8; j=j+1)begin
			#2 select = j;
			#2 $display ("select = %d, data_in= %b", select, data_in);
		end
	end 
endtask


task error_verify;
  input  silmulated, expected;
  if (silmulated != expected)
  begin
    $display("silmulated value = %b, expected value = %b,errors = %d at time = %d\n",silmulated, expected, error, $time);
    error = error +1;
 end 
  else begin
   $display("successful"); end 
endtask

 
endmodule 
 