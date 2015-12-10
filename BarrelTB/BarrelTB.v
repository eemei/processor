'timescale 1ns/1ns

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
.sel(select), .reset(reset), .clk(clk),.data_out(data_out), data_in(data_in)); 

initial begin  
clk <= 0;
forever #1 clk = ~clk; end

initial begin 
	reset <= 0;
	@(posedge clk);
	@(negedge clk) reset =0; end

initial begin
	data_in = 0;
	clk=0;
	load =0;
	reset = 1;
	reset =0;
 // data_in random , sel use for loop
 // reset error count
end 
  
task Reset;
	input [7:0] D_mux;
	input [7:0] brl_in;
	output [7:0] brl_out;
	
	//assign brl_in = load?data_in:br1_out;

	if (reset)
		if(data_out = 0)
		$ display ("successful for reset:)");
		else begin
		//data_out = brl_out;
		error = error+1; 
		$ display ("reset = %d, error= %d", reset, error);end
  
//  if(load)
//    if ()
			
	endtask
	
task load;
 endtask  
	
	
task barrelshift_verify;

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

 if (silmulated != expected)begin 
 #2 display ("silmulated value = %b, expected value = %b,
	 errors = %d at time = %d\n",silmulated, expected, error, $time");end
else 
 #2 display ("succesful :)");
endtask

task summary_report;
if (error)
  $display ("Test completed. Mismatching error");
else 
  $display ("Successful... Test Completed ~~");
endtask 

// barrelshifter
input [2:0] selector;       //  select->shift how many bit
wire [7:0 ]brl_in;
reg [7:0] brl_out;

assign selector = sel;

assign brl_in = load? data_in: brl_out;

always@ (posedge clk)
  if (reset)
    data_out <= 0;
  else 
    data_out <=  brl_out;
    
 endmodule 
	
	