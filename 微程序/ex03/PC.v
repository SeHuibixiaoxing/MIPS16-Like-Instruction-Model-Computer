module PC (
	input CLK ,				//时钟信号
	input LOAD ,			//置数端，低电平有效
	input ET ,				
	input EP ,				//当CLR=1, LOAD=1, ET=1, EP=1时增1计数
	input CLR ,				//清零端
	input[16:0] D,
	output[16:0] Q
);
	
	wire RCO[3:0];


	\74161 F74161_1(
		.LDN(LOAD) ,
		.A(D[0]) ,
		.B(D[1]) ,
		.C(D[2]) ,
		.D(D[3]) ,
		.ENT(ET) ,
		.ENP(EP) ,
		.CLRN(CLR) ,
		.CLK(CLK) ,
		.QA(Q[0]) ,
		.QB(Q[1]) ,
		.QC(Q[2]) ,
		.QD(Q[3]) ,
		.RCO(RCO[0])		
	);
	
	\74161 F74161_2(
		.LDN(LOAD) ,
		.A(D[4]) ,
		.B(D[5]) ,
		.C(D[6]) ,
		.D(D[7]) ,
		.ENT(RCO[0]) ,
		.ENP(RCO[0]) ,
		.CLRN(CLR) ,
		.CLK(CLK) ,
		.QA(Q[4]) ,
		.QB(Q[5]) ,
		.QC(Q[6]) ,
		.QD(Q[7]) ,
		.RCO(RCO[1])		
	);
	
	\74161 F74161_3(
		.LDN(LOAD) ,
		.A(D[8]) ,
		.B(D[9]) ,
		.C(D[10]) ,
		.D(D[11]) ,
		.ENT(RCO[1]) ,
		.ENP(RCO[1]) ,
		.CLRN(CLR) ,
		.CLK(CLK) ,
		.QA(Q[8]) ,
		.QB(Q[9]) ,
		.QC(Q[10]) ,
		.QD(Q[11]) ,
		.RCO(RCO[2])		
	);
	
	\74161 F74161_4(
		.LDN(LOAD) ,
		.A(D[12]) ,
		.B(D[13]) ,
		.C(D[14]) ,
		.D(D[15]) ,
		.ENT(RCO[2]) ,
		.ENP(RCO[2]) ,
		.CLRN(CLR) ,
		.CLK(CLK) ,
		.QA(Q[12]) ,
		.QB(Q[13]) ,
		.QC(Q[14]) ,
		.QD(Q[15]) ,
		.RCO(RCO[3])		
	);
	
	

endmodule 