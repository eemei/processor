module TB();
reg clk, reset;
reg [2:0] sel;            //  select->shift how many bit
reg [7:0] data_in;        //  data input
wire [7:0] data_out;  //  data output 
reg  load;

initial
reset = 1; 
sel = 0;
