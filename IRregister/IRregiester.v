module IRregiester(clock, Reset,Q_ram, IRload, Q_IR, Q_IRmux, IR, 
                    D_PC, JMPmux, Q_Incr, PCload , Q_PC, Meminst, Q_Meminst);

							
input clock, Reset, IRload, JMPmux, PCload, Meminst;
input [7:0] Q_ram;
output [7:0] Q_IR;
output [2:0] IR;
output [4:0] Q_IRmux ,D_PC, Q_Incr,Q_PC,Q_Meminst;

assign IR = Q_IR[7:5];
assign Q_IRmux = Q_IR[4:0];
		
register8bit #(.SIZE(8)) IRreg (Q_IR,Q_ram,IRload,clock,Reset); 
mux1_2 JMPMux (D_PC, JMPmux,Q_IRmux, Q_Incr);
register8bit #(.SIZE(5)) PCreg (Q_PC, D_PC, PCload, clock, Reset);
counter Incr(Q_PC, Q_Incr);
mux1_2 Memmux (Q_Meminst, Meminst, Q_IRmux, Q_PC); 

endmodule 