module counterTB();
  
   // Outputs
   wire [5:0] count;

   // Inputs
   reg clk;
   reg rst_n;




   initial begin
      // Initialize Inputs
      clk = 0;
      rst_n = 1;

      // Force Reset after delay
      #10 rst_n = 0;
      #10 rst_n = 1;
      #50 $finish;   
   end

   // Generate clock
   always
      #1 clk = ~clk;
      
         // Instantiate the Unit Under Test (UUT)
   counter uut (
      .count(count), 
      .clk(clk), 
      .rst_n(rst_n)
   );

endmodule