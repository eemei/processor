module Processor_tb();

//input reg
	//reg  clock, reset, Enter, cheat;
	//reg  [7:0] Minput;

//output wire
	//wire Halt;
	//wire [7:0] Moutput;
	//wire [3:0] DisplayState;
  //wire [2:0] IR75;
  
  reg Enter;
	reg [7:0] Input;
	reg Clock, Reset;
	wire [7:0] Output;
	wire Halt;
	
	wire [1:0] Asel;
	wire [7:0] Q_ram, Q_A;
	wire [4:0] Q_Meminst; 
	reg Initialize;
	wire [3:0] state;
	wire [2:0] IR;

  integer error, i;
	reg  [7:0] expectedValue, X, Y;

//Processor mine ( clock, reset, Enter, cheat, Minput,
//                 Halt, Moutput, DisplayState, IR75);
EC2_microprocessor ProcessorTB (Enter, Input, Clock, Reset, Halt,   Q_Meminst, Q_ram, Q_A, Asel,   Output,Initialize, state, IR);

/************************* GLOBAL INITIAL CLOCK and GLOBAL INITIAL RESET **********************/
initial
begin
  Reset <= 0; Initialize <= 1;
  @(posedge Clock);
  @(negedge Clock);
  Reset <= 1;  Initialize <= 0;
end

initial
begin
  Clock = 0;
  forever #1 Clock = ~Clock;
end

initial
begin
  $display("clk | reset | Enter | cheat | Minput | Halt| Moutput| State| IR75");
  $monitor("%b   | %b     | %b     |  %b   |    %d  |  %b  |   %d   | %b | %b ", Clock, Reset, Enter, Initialize, Input, Halt, Output, state, IR);
end

initial
begin
  initialise();
  #2  autoChecking;
  #2  if(!error)
        $display(" Simulation Successful =) ");
      else
        $display(" Simulation Failed. Total errors = %d ", error);
      $finish;
      
  // #8  $display("CP1"); getInput(2);
  // #14 $display("CP2"); getInput(8); checkingOutput(2);

end

/*
initial
begin
  forever #1
  if(Halt)
  begin
    if(expectedValue != Moutput)
    begin
      error = error + 1;
      $display("ERROR occur! expectedValue = %d, output = %d", expectedValue, Moutput);
    end
  end
end
*/

/*************************** TASKS **********************************/
task getInput;
input [7:0] dataIn;
begin
  Input = dataIn; Enter = 1;
  #2 Enter = 0;
end
endtask

task restart;
begin
  Reset <= 0;
  #2 Reset <= 1;
end
endtask

task initialise;
begin
	Minput <= 0; Enter <= 0; error <= 0; expectedValue <= 0;
end
endtask

task checkingOutput;
input [7:0] expectedValue;
begin
  //$display("CP4");
  while(!Halt) #1;

    if(expectedValue != Output)
    begin
      error = error + 1;
      $display(" !!!!!! ERROR !!!!!!  expected output = %d, actual output = %d", expectedValue, Moutput);
    end
    else
      $display("***************************** PASS with %d time *************************************", (i + 1));

end
endtask

task algorithmChecking;
begin
  // $display("CP3");
  while(X != Y)
  begin
    if(X > Y)    X = X - Y;
    else         Y = Y - X;
  end
    
  checkingOutput(X);
end
endtask

task autoChecking;
begin
  for(i = 0; i < 100; i = i + 1)
  begin
    restart();
    X = ({$random} % 128); Y = ({$random} % 128);
    while(X == 0) begin X = ({$random} % 128); end
    while(Y == 0) begin Y = ({$random} % 128); end //restart();
    $display("X = %d, Y = %d ", X, Y);
    #8  getInput(X);
    #14 getInput(Y); algorithmChecking();
    
  end
end
endtask

endmodule