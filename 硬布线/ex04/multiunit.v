module multiunit(
	input A,		
	input B,		
	input C,		//进位输入
	input M,		//部分积输入
	
	output C4,	
	output M4	//部分积输出
);

	add1 add(
		.A(M),
		.B(A&B),
		.C(C),
		.S(M4) ,
		.C4(C4)
	);


endmodule