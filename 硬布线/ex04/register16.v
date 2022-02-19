module register16(
	input[15:0] D ,
	input CLR ,
	input CPR ,
	output[15:0] Q
);
	
	wire CLRN = ~CLR;
	
	\74173 register8_1(
		.D1(D[0]) ,
		.D2(D[1]) ,
		.D3(D[2]) ,
		.D4(D[3]) ,
		.G1N(0) ,
		.G2N(0) ,
		.MN(0) ,
		.NN(0) ,
		.CLR(CLRN) ,
		.CLK(CPR) ,
		.Q1(Q[0]) ,
		.Q2(Q[1]) ,
		.Q3(Q[2]) ,
		.Q4(Q[3])
	) ;
	
	\74173 register8_2(
		.D1(D[4]) ,
		.D2(D[5]) ,
		.D3(D[6]) ,
		.D4(D[7]) ,
		.G1N(0) ,
		.G2N(0) ,
		.MN(0) ,
		.NN(0) ,
		.CLR(CLRN) ,
		.CLK(CPR) ,
		.Q1(Q[4]) ,
		.Q2(Q[5]) ,
		.Q3(Q[6]) ,
		.Q4(Q[7])	
	) ;
	\74173 register8_3(
		.D1(D[8]) ,
		.D2(D[9]) ,
		.D3(D[10]) ,
		.D4(D[11]) ,
		.G1N(0) ,
		.G2N(0) ,
		.MN(0) ,
		.NN(0) ,
		.CLR(CLRN) ,
		.CLK(CPR) ,
		.Q1(Q[8]) ,
		.Q2(Q[9]) ,
		.Q3(Q[10]) ,
		.Q4(Q[11])	
	) ;
	\74173 register8_4(
		.D1(D[12]) ,
		.D2(D[13]) ,
		.D3(D[14]) ,
		.D4(D[15]) ,
		.G1N(0) ,
		.G2N(0) ,
		.MN(0) ,
		.NN(0) ,
		.CLR(CLRN) ,
		.CLK(CPR) ,
		.Q1(Q[12]) ,
		.Q2(Q[13]) ,
		.Q3(Q[14]) ,
		.Q4(Q[15])	
	) ;

endmodule 