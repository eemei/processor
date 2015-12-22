module DatapathRAM(
	input [7:0] D,
	input [4:0] WA,
	input WE, clock,
	output reg [7:0] Q
);

reg [7:0] memArray [31:0];

always @(posedge clock)begin
	if(WE == 1)
		memArray[WA] <= D;
	else
		Q <= memArray[WA];
end

endmodule