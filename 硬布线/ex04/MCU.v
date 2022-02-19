module MCU(
	input	CLK, 
	input	CLR, 
	input LOAD,
	output[15:0] Q
);	
	
	wire[15:0] address;
	wire[31:0] O;
	

	UPC upc(
		.LOAD(LOAD) ,			
		.CLK(CLK) ,			
		.ET(1) ,				
		.EP(1) ,				
		.CLR(CLR) ,				
		.D(0),
		.Q(address)
	);
	

	rom1 romA(
		.address(address) ,
		.q(O),
		.clock(CLK)
	);
	
	
	wire S0, S1, S2, S3, M, CPR2, CPR1, CPR0, CN, UIR;
	wire[15:0] NUM;
	
	
	assign S0 = O[0];
	assign S1 = O[1];
	assign S2 = O[2];
	assign S3 = O[3];
	assign M = O[4];
	assign CPR2 = (O[5])&(~CLK);
	assign CPR1 = (O[6])&(~CLK);
	assign CPR0 = (O[7])&(~CLK);
	assign CN = O[8];
	assign UIR = O[9];
	
	assign NUM = O[31:16];
	
	ALU16 alu(
		.CPR0 (CPR0),
		.CPR1 (CPR1),
		.CPR2 (CPR2),
		.M (M),
		.S0 (S0),
		.S1 (S1),
		.S2 (S2),
		.S3 (S3),
		.A(NUM),
		.B(NUM),
		.CN(CN), 
		.CLR(CLR),
		.Q(Q)
	);
	
	
endmodule 