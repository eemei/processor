module register8bit #(parameter SIZE = 8)(Q,D,load,Clock,Reset);
	
	output reg [SIZE-1:0] Q;
	input [SIZE-1:0] D;
	input load, Clock, Reset;
	

 always @(posedge Clock , negedge Reset) begin

 if (!Reset) 
	Q <= 0;
 else begin 
  if (load) 
	Q <= D;
	else 
	Q <= Q;
	end
end	

endmodule
