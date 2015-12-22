module Datapath(Input,IRload,JMPmux,PCload,Meminst,MemWr,Asel,Aload,Reset,Clock,Sub,IR,Aeq0,Apos,Output);

input [7:0] Input;
input IRload,JMPmux,PCload,Meminst,MemWr,Aload,Reset,Clock,Sub ;
input [1:0]Asel;
output Aeq0 ,Apos ;
output [2:0]IR ;
output [7:0]Output ;

reg xtraSignal = 1 ;

wire [7:0] Aout, RAMout, ASout,Amux_out, IRout ;
wire [4:0] JMPmux_out, Memmux_out, INCout, PCout ;

always @(posedge Clock)
begin
  if (Reset)
      xtraSignal <= 1 ;
else
      xtraSignal <= 0; 
end 

Register_8bit IRreg		(IRload,Reset,Clock,RAMout,IRout);
Register_8bit A			(Aload,Reset,Clock,Amux_out,Aout);
Register_5bit PC		(PCload,Reset,Clock,JMPmux_out,PCout);
RAM_32_x_8bit RAM		(Memmux_out,MemWr,xtraSignal,Clock,Aout,RAMout);
Mux_1_2_5bit  JMP		(JMPmux,INCout,IRout[4:0],JMPmux_out);
Mux_1_2_5bit  Mem		(Meminst,PCout,IRout[4:0],Memmux_out);
Mux_2_4_8bit  Amux		(Asel,ASout,Input,RAMout,8'd0,Amux_out);
Add_Sub_8bit  AddSub	(Sub,Aout,RAMout,ASout);
Increment5bit Inc5bit	(PCout,INCout);

assign IR = IRout[7:5] ;
assign Aeq0 = (Aout == 0) ? 1'b1 : 1'b0 ;
assign Apos = ~Aout[7] ;
assign Output = Aout ;

endmodule