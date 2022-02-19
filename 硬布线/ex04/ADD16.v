
module ADD16 (
		input[15:0] A,				// 数值A
		input[15:0] B,				// 数值B		
		input CN ,					//进位
		input S0 ,
		input S1 ,
		input S2 ,
		input S3 ,
		input M ,
		output[15:0] F ,
		output CNOUT
);					
		
		wire GN[3:0], PN[3:0], AEQB[3:0], CN4[3:0] ;
		wire C[2:0];
		
		assign CNOUT = CN4[3]; 
		
		\74182	F74182(
				.GN0(GN[0]) ,
				.GN1(GN[1]) ,
				.GN2(GN[2]) ,
				.GN3(GN[3]) ,
				.PN0(PN[0]) ,
				.PN1(PN[1]) ,
				.PN2(PN[2]) ,
				.PN3(PN[3]) ,
				.CI(CN) ,
				.CX(C[0]) ,
				.CY(C[1]) ,
				.CZ(C[2])
		) ;
		
		
		
		\74181 	F74181_1(
				.B0N(B[0]),
				.A0N(A[0]),
				.A1N(A[1]),
				.B1N(B[1]),
				.A3N(A[3]),
				.B2N(B[2]),
				.A2N(A[2]),
				.M(M),
				.CN(CN),
				.B3N(B[3]),
				.S2(S2),
				.S1(S1),
				.S0(S0),
				.S3(S3),
				.PN(PN[0]),
				.GN(GN[0]),
				.F3N(F[3]),
				.F1N(F[1]),
				.F0N(F[0]),
				.AEQB(AEQB[0]),
				.CN4(CN4[0]),
				.F2N(F[2])) ;
		\74181 	F74181_2(
				.B0N(B[4]),
				.A0N(A[4]),
				.A1N(A[5]),
				.B1N(B[5]),
				.A3N(A[7]),
				.B2N(B[6]),
				.A2N(A[6]),
				.M(M),
				.CN(C[0]),
				.B3N(B[7]),
				.S2(S2),
				.S1(S1),
				.S0(S0),
				.S3(S3),
				.PN(PN[1]),
				.GN(GN[1]),
				.F3N(F[7]),
				.F1N(F[5]),
				.F0N(F[4]),
				.AEQB(AEQB[1]),
				.CN4(CN4[1]),
				.F2N(F[6])) ;
		\74181 	F74181_3(
				.B0N(B[8]),
				.A0N(A[8]),
				.A1N(A[9]),
				.B1N(B[9]),
				.A3N(A[11]),
				.B2N(B[10]),
				.A2N(A[10]),
				.M(M),
				.CN(C[1]),
				.B3N(B[11]),
				.S2(S2),
				.S1(S1),
				.S0(S0),
				.S3(S3),
				.PN(PN[2]),
				.GN(GN[2]),
				.F3N(F[11]),
				.F1N(F[9]),
				.F0N(F[8]),
				.AEQB(AEQB[2]),
				.CN4(CN4[2]),
				.F2N(F[10])) ;
		\74181 	F74181_4(
				.B0N(B[12]),
				.A0N(A[12]),
				.A1N(A[13]),
				.B1N(B[13]),
				.A3N(A[15]),
				.B2N(B[14]),
				.A2N(A[14]),
				.M(M),
				.CN(C[2]),
				.B3N(B[15]),
				.S2(S2),
				.S1(S1),
				.S0(S0),
				.S3(S3),
				.PN(PN[3]),
				.GN(GN[3]),
				.F3N(F[15]),
				.F1N(F[13]),
				.F0N(F[12]),
				.AEQB(AEQB[3]),
				.CN4(CN4[3]),
				.F2N(F[14])) ;
				
				

endmodule
		
