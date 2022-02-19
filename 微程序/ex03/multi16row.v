module multi16row(
	input[15:0] A ,
	input B,		
	input[15:0] M,		//部分积输入
	
	output[15:0] M4,	//部分积输出
	output P				//结果输出
);
	
	wire[16:0] C;
	wire[15:0] MT;
	assign P = MT[0];
	assign M4 = {C[16], MT[15:1]};
	assign C[0] = 0;
	genvar i;
	generate
		for(i = 0;i < 16;i = i + 1) begin: union
			multiunit unit(
				.A(A[i]),		
				.B(B),		
				.C(C[i]),	//进位输入
				.M(M[i]),		//部分积输入
				
				.C4(C[i + 1]),	
				.M4(MT[i]),	//部分积输出
			);
		end
	endgenerate


endmodule
