module barrel_me (clk, reset, sel, data_in, data_out, load);

input clk, reset, load;
input [7:0] data_in;        //  data input
input [2:0] sel;            //  select->shift how many bit
output reg [7:0] data_out;  //  data output 
wire [7:0 ]brl_in;
reg [7:0] brl_out;
          
// function integer ii;
  // integer n;
	// input [7:0]Vrol;
  // reg [7:0] TMPD;
    // //n=s; 
    // //TMPD = D;
    // for (ii = 1; ii <= n; ii=ii+1) begin 
      // TMPD = {TMPD[0], TMPD[7:1]};
    // //Vrol = TMPD;
  // end 
// endfunction

assign brl_in = load? data_in: brl_out;
always@ (posedge clk)
  if (reset)
    data_out <= 0;
  else 
    data_out <=  brl_out;
  
always @(data_in or sel) begin 
  case (sel)
    3'b000 :brl_out = data_in;
    3'b001 :brl_out = {data_in[0], data_in[7:1]}; // infront bit , continuos bit 
    3'b010 :brl_out = {data_in[1:0], data_in[7:2]};
    3'b011 :brl_out = {data_in[2:0], data_in[7:3]};
    3'b100 :brl_out = {data_in[3:0], data_in[7:4]};
    3'b101 :brl_out = {data_in[4:0], data_in[7:5]};
    3'b110 :brl_out = {data_in[5:0], data_in[7:6]};
    3'b111 :brl_out = {data_in[6:0], data_in[7]};
    default : brl_out = data_in;
  endcase
 end
endmodule 
