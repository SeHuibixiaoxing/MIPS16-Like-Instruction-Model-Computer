module threeToEight(
	input[2:0] A,
	output[7:0] B
);

wire[7:0] T;

genvar i;
generate 
	for(i = 0;i < 8;i = i + 1) begin: aa
		assign B[i] = ~T[i];
	end
endgenerate

\74138 three_eight_translator1(
		.G1(1) ,
		.G2AN(0) ,
		.G2BN(0) ,
		.A(A[0]) ,
		.B(A[1]) ,
		.C(A[2]) ,
		.Y7N(T[7]) ,	
		.Y6N(T[6]) ,	
		.Y5N(T[5]) ,	
		.Y4N(T[4]) ,	
		.Y3N(T[3]) ,	
		.Y2N(T[2]) ,	
		.Y1N(T[1]) ,	
		.Y0N(T[0]) 
	);
	
	
endmodule 


