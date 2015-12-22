module DatapathRAM_tb();

reg [7:0] D;
reg [4:0] WA;
reg WE, clock;
wire [7:0] Q;

DatapathRAM dpRAM(D, WA, WE, clock, Q);

always #2 clock = ~clock;

initial begin
#0 clock = 0; D = 0; WA = 0; WE = 0;
#8 D = 8'b10101100; WA = 4'b0010; WE = 1;
#8 D = 8'b00001111; WA = 4'b0110; WE = 1;
#8 WA = 4'b0010; WE = 0; 
#8 WA = 4'b0110; WE = 0;  
#100 $finish;
end

endmodule 