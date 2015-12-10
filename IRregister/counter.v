module counter(D_data, Q_data);

  output reg [4:0] Q_data;
  input [4:0] D_data;


  always@(*) begin
	Q_data = D_data + 1'b1;
	end
	
endmodule
