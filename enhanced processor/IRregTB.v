module IRregTB ();
  

reg clock, Reset, IRload, JMPmux, PCload, Meminst;
reg [7:0] Q_ram;
reg [2:0] IR;
wire [7:0] Q_IR;
wire [4:0] D_PC, Q_Incr,Q_PC,Q_Meminst;

//instantiate 
IRregiester irReg(clock, Reset, IRload, JMPmux, PCload, Meminst, 
             IR, Q_IR, Q_ram, D_PC, Q_Incr,Q_PC,Q_Meminst);

// initial clock 
initial begin
clock = 0;	
Reset = 1;
#2 Reset = 0;
#2 checker; checking;
end 

//initial block 
task checker;
  #2  Q_ram = 8'b00000001; IRload = 1; JMPmux = 1; PCload = 1; Meminst =1;
  #2  Q_ram = 8'b00000001; IRload = 1; JMPmux = 0; PCload = 1; Meminst =0;
  #2  Q_ram = 8'b00000010;
  #2  IRload = 0; JMPmux = 1; PCload = 0; Meminst =1; 
  #2  IRload = 0; JMPmux = 0; PCload = 0; Meminst =0;
  
  #2  Q_ram = 8'b00000111; IRload = 1; JMPmux = 1; PCload = 1; Meminst =1;
  #2  Q_ram = 8'b00000111; IRload = 1; JMPmux = 0; PCload = 1; Meminst =0;
  #2  Q_ram = 8'b00001111;
  #2  IRload = 0; JMPmux = 1; PCload = 0; Meminst =1; 
  #2  IRload = 0; JMPmux = 0; PCload = 0; Meminst =0;
endtask 

task checkig;
  $display ("IRload   JMPmux   PCload   Meminst | IR    Q_Meminst   D_PC    Q_PC    Q_IR");
  $montor ("%b    %b    %b    %b    %b    %b    %b    %b    %b",IRload   JMPmux   PCload   Meminst | IR    Q_Meminst   D_PC    Q_PC    Q_IR );
 endtask 
endmodule 
	
	
	