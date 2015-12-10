module RAMtb ();
	reg [7:0] data;
	reg [4:0] addr;
	reg we, clk;
	wire [7:0] q;
	
initial
begin
  clk= 0;
  we= 1;
  data = 0;
  addr = 0;
//we = 1; addr= 5'd0; clk = 0; data = 8'b00000000;
  for(addr = 0; addr < 20; addr = addr + 1)
  begin
   #4 data = data + 1;
     $display ("address %d, out %d",addr, q );
  end
 we = 0;
  for(addr = 0; addr < 20; addr = addr + 1)
  begin
     #4 data = data + 1;
     $display ("address %d, out %d",addr, q );
  end

  #60 $finish;
end
	
	 always
      #1 clk = ~clk;
      
	RAM ramtb (data, addr, we, clk, q);
	 

endmodule 
