module DataPathTB();

	reg Reset, Clock;
	reg IRload,JMPmux; 
	reg PCload, Meminst, MemWr, Aload, Sub;
	reg [1:0] Asel;
	reg [7:0] Input;
	wire Aeq0, Apos;
	wire [2:0]IR;
	wire [4:0]addr;
	wire [7:0]Output;
	
	wire [7:0] Q_IR, Q_ram, Q_A, Q_addsub, D_A;
	wire [4:0] D_PC, Q_Incr,Q_PC,Q_Meminst, Q_IRmux;
	integer error;


	//instantiate 
	DP DataPathTB (Reset, Clock,IRload,JMPmux,PCload, Meminst, MemWr, Aload, Sub, Asel,Input,
						Aeq0, Apos,IR,addr,Output,Q_IR, Q_ram, Q_A, Q_addsub, D_A,D_PC, Q_Incr,Q_PC,Q_Meminst, Q_IRmux);
// clock 


	initial begin
	Reset <= 0;
	@(posedge Clock);
	@(negedge Clock); 
	 Reset = 1;
	end

initial begin
Clock <= 0;
forever #1 Clock = ~Clock;
	end

initial begin 
Input = 8'b00000011;
IRload = 0; JMPmux = 0; PCload = 0; Meminst = 0; MemWr = 0; error = 0; 
Asel = 0; Aload = 0; Sub = 0;
#3 Reset = 1; Display();
//#2 Reset = 0; Display();// Address = 000 00
//#2 start_verify(); 
#2 Aload = 0; Asel = 2'b01;  
#2 Asel = 2'b01; Aload= 0; 
#2 Asel = 2'b01; Aload= 1; JMPmux =1;
#2 Asel = 2'b01; Aload= 1; Display();
#2 PCload = 1; MemWr = 1; Display(); Asel = 1; Aload =1; 
#2 MemWr =0; 
#2 $display("FETCH");IRload = 1; PCload = 1; JMPmux = 0; Meminst = 0; Asel =0 ; Aload = 0; 
#5 $display("DECODE"); Reset =0 ;IRload = 1; JMPmux = 1; PCload = 0; Meminst = 1; MemWr= 1; JMPmux = 1; 
#2 Reset =1; IRload = 0; PCload = 0; Meminst = 1; MemWr= 0; JMPmux = 0; verify_output (Q_ram, Q_A);
#2 $display ("LOAD"); Input = 8'b00001111; Aload  =1; Asel =1; 
#2 Asel = 2; MemWr= 0; Aload = 1; 
#2 verify_output (Q_ram, Q_A);
#2 $display ("STORE"); IRload = 0; JMPmux = 0; PCload = 0; Meminst = 0; MemWr = 0; error = 0; 
Asel = 0; Aload = 0; Sub = 0; // reset all 
#2 Input = 8'b11110000; Aload  =1; Asel = 1; 
#2 JMPmux = 0; PCload = 1; Meminst =0; MemWr = 1;
#2 JMPmux = 1;MemWr = 0; IRload = 1; 
#8 $display("check STORE"); IRload =0; JMPmux =0; PCload = 0; Meminst =1; MemWr = 1; Asel = 0; Aload = 0; 
#2 MemWr =0; 
#2 verify_output(Q_ram, Q_A);
#2 $display ("Add"); Aload = 1; Asel = 3; Meminst = 0; // change the Q_A to 11111111
#2 add_verify();
#5 $display ("Sub");sub_verify();
#6 $display ("Input"); Input_verify();
#3 $display ("JZ"); jz_verify();


#5 $finish ;                                                                                                                                                                                                                                                                                                                                                      
end 

//------- start -----------
task start_verify; 
  begin
  {IRload, JMPmux, PCload, Meminst, MemWr, Asel, Aload, Sub}= 9'b00000000;
  verify_output (8'b00000000, Output);
  //Display();
  end
endtask;

task add_verify;
  reg [7:0]Q_ramExpected;
  begin
  Asel =0; Aload = 1; 
  Q_ramExpected= Q_ram + Q_A;
  verify_output (Q_ramExpected, Q_addsub);
  end
endtask

  
task sub_verify;
  reg [7:0]Q_ramExpected;
  begin
  Asel =0; Aload = 1; Sub = 1; 
 #4 Q_ramExpected= Q_A - Q_ram; verify_output (Q_ramExpected, Q_addsub);
  end
endtask

task Input_verify;
  begin
  Asel =1; Input =8'b10110011; Aload= 1; Sub =0;
  #3 verify_output (Q_A, Input);
  end
endtask

task jz_verify;
  begin
     Asel = 0; Aload =1;  JMPmux = 1; IRload = 1; PCload = 0; MemWr = 1;
  #2 MemWr = 0; 
  #4 $display ("when PCload = %d", PCload); Asel =0; Aload = 0; IRload = 0; JMPmux= 1;
  #2 PCload = 1; $display ("when PCload= %d", PCload); 
  end
endtask

// outputs verification 
task verify_output;
	input [7:0] simulated_value;
	input [7:0] expected_value;
		
	begin
	if (simulated_value != expected_value) begin
		error = error + 1;
		$display("Simulated value = %b, Expected Value = %b, error = %d, at time = %d",
				  simulated_value, expected_value, error, $time);
	end
	else
	  $display("Successful !");
	end
endtask
	
// summary report
task summary_report;
	begin
	if(error == 0)
		$display("Test Completed. ALL MATCH \:\)");
	else
		$display("Test Completed. Matchching Failed \:\(   error\(s\).", error);//, error);
	 end
endtask


task Display;
 begin 
  $display ("time=              clock:  Input=   Q_A:    Asel:  Aload:  Pcload:  Q_IR(4..0):   Q_IR(7..5)=   Q_Meminst=   JMPmux: IRload:   Meminst:    MemWr:  Sub:  Q_ram     Q_add_sub:  Q_PC, D_pc");
  $monitor ("%d %d    %b  %b  %d     %d        %d      %b          %b          %b         %d        %d       %d           %d      %d  %b      %b  %b, %b", $time, Clock, Input, Q_A, Asel, Aload, PCload, Q_IRmux,IR,Q_Meminst,JMPmux,IRload,Meminst,MemWr,Sub,Q_ram, Q_addsub,Q_PC,D_PC);
end 
endtask 
			
//always 
// #1 Clock = ~Clock;		
 	
endmodule 