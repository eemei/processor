module ProcessorTB ();

	 reg Enter;
	reg [7:0] Input;
	reg Clock, Reset;
	wire Halt;
	wire [7:0] Output;
	reg Initialize;
	
	wire [3:0] state;

integer error;
integer j,i;
reg[7:0] X, Y;

// instantiate 
EC2_microprocessor ProceesorTB(Enter, Input, Clock, Reset, Halt, Output,Initialize, state );

initial begin
Clock <= 0;
forever #1 Clock = ~Clock;
end

// reset 
initial begin
	Reset <= 0; Initialize <= 1;
	@(posedge Clock);
	@(negedge Clock) Reset = 1;  Initialize <= 0;
	end

initial begin 
Clock=0; //Reset=0;
error = 0;  Enter = 0; Input = 8'd0; //Initialize = 0;
//#2 Reset=1;
// Display();
//#2 Initialize = 1;
#8 Algorithm_Program();
#100 summary_report();
#10 $finish;
end

task Input_Value;
input [7:0] D;
begin
  Input = D; 
  #2 Enter = 1;
  #6 Enter = 0;
end
endtask

task Algorithm_Program;
  begin
  //input [7:0] X, Y;
  for (i=0; i< 100; i=i+1)begin 
  X = ({$random} % 128);
  Y = ({$random} % 128);
  while (X == 0) begin X = ({$random} % 128); end
  while (Y == 0) begin Y = ({$random} % 128); end
  #10 Input_Value(X);
  #10 Input_Value(Y);
  $display("X (%d) and Y (%d)", X, Y);
    while (X != Y) begin 
      if (X > Y) //begin
        X = X - Y;
       // expected_value <= X; end
      else //begin
        Y = Y - X;
        //expected_value <= Y; end
    end
  $display("Result %d", X);
  verify_output(X); 
  end  
 end
endtask

// task Display;
 //initial
  // begin
  //  $display ("time                  clock  Input      Output    Enter  Halt       X   Y   Ir");
  //  $monitor ("%d     %d    %b   %d    %d   %d   %d  %d   %b",$time, Clock, Input, Output, Enter, Halt,X,Y,IR );
  // end
 //  endtask
  
  // outputs verification 
task verify_output;
	input [7:0] expected_value;
	begin
	while(!Halt) #1;
	if (Output != expected_value) begin
		error = error + 1;
		$display("Simulated value = %d, Expected Value = %d, error = %d, at time = %d", Output, expected_value, error, $time);
	end
  end
endtask
	
// summary report
task summary_report;
	begin
	if(error == 0)
		$display("Test Completed. ALL MATCH \:\)");
	else
		$display("Test Completed. Matchching Failed \:\( %d  error\(s\).", error);//, error);
	 end
endtask

endmodule 
