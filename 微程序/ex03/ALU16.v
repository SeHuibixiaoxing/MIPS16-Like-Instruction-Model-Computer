module ALU16(
	input CPR0 ,
	input CPR1 ,
	input CPR2 ,
	input M ,
	input S0 ,
	input S1 ,
	input S2 ,
	input S3 ,
	input[15:0] A,
	input[15:0] B,
	input CN , 
	input CLR ,
	output[15:0] Q
);
	
	wire[15:0] numA, NUMA, numB;
	wire[15:0] ans;
	
	register16 R0(
		.D(A) ,
		.CLR(CLR) ,
		.CPR(CPR0) ,
		.Q(numA)
	);
	register16 R1(
		.D(B) ,
		.CLR(CLR) ,
		.CPR(CPR1) ,
		.Q(numB)
	);
	 
	ADD16 add(
		.A(numA),				
		.B(numB),				
		.S0(S0),
		.S1(S1),
		.S2(S2),
		.S3(S3),
		.M(M),						
		.CN(CN) ,				
		.F(ans)
	);
	
	register16 R3(
		.D(ans) ,
		.CLR(CLR) ,
		.CPR(CPR2) ,
		.Q(Q)
	);
	
	

endmodule 