module addTB();
  	reg [7:0] dataa;
	reg [7:0] datab;
	reg add_sub;	  // if this is 1, add; else subtract
	//input clk,
	wire [7:0] result;
	
	addsub addsubTB (dataa, datab, add_sub, result);
	
	initial begin 
	  dataa = 8'b00000110;
	  datab = 8'b00000010;
	  add_sub = 0; $display ("result = %d", result);
	  #2 add_sub = 1; $display ("result = %d", result);
	  #3 add_sub = 0;$display ("result = %d", result);
	  #10 $finish;
	  end 
	  
	  endmodule
	  
