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
	
	//instantiate 
	DP DataPathTB ( Reset, Clock,IRload,JMPmux,PCload, Meminst, MemWr, Aload, Sub, Asel,Input,
						Aeq0, Apos,IR,addr,Output);
						
	