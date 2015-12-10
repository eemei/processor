module IRregTB();
  
reg clock, Reset, IRload, JMPmux, PCload, Meminst;
reg [7:0] Q_ram;
wire [7:0] Q_IR;
wire [2:0] IR;
wire [4:0] Q_IRmux ,D_PC, Q_Incr,Q_PC,Q_Meminst;


//instantiate 
//IRregiester irReg(clock, Reset, Q_ram, IRload, JMPmux, PCload, Meminst,
	//										IR, Q_IR, D_PC, Q_Incr,Q_PC,Q_Meminst, Q_IRmux);

IRregiester irREG(clock, Reset,Q_ram, IRload, Q_IR, Q_IRmux, IR, 
                    D_PC, JMPmux, Q_Incr, PCload , Q_PC, Meminst, Q_Meminst);



initial begin
clock = 0;
Reset = 0;
IRload = 0;
Q_ram = 0;
#7 Reset =1; IRload =1;
#4 Q_ram = 8'b00000110;
#4 Q_ram = 8'b11001011;
#4 Q_ram = 8'b00011011;
#4  JMPmux =1;
#4  JMPmux = 0;
#7 PCload = 0;
#4 PCload = 1;
#4 Meminst = 0;
#4 Meminst = 1;

#45 $finish;
end

initial
  begin

$display ("Q_ram    IRload    Q_IR      IR    Q_IRmux   D_PC    PCload    Q_PC  JMPmux  Meminst    Q_meminst");
$monitor ("%b    %b     %b     %b     %b    %b    %b    %b      %b     %b     %b"   
        , Q_ram, IRload, Q_IR, IR, Q_IRmux, D_PC, PCload, Q_PC, JMPmux, Meminst, Q_Meminst);
end

always #1 clock =~clock;

endmodule 
	
	
	