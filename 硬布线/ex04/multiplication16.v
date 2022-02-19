// 仿真测试完成
module multiplication16(
	input[15:0] A ,
	input[15:0] B,
	output[15:0] C
);
	wire[31:0] ans;
	wire[15:0] line[16:0];
	
	assign C = ans[15:0];
	assign line[0] = 16'b0;
	assign ans[31:16] = line[16];
	
	genvar i;
	generate
		for(i = 0;i < 16;i = i + 1) begin: union
			multi16row row(
				.A(A),
				.B(B[i]),		
				.M(line[i]),		//部分积输入
				
				.M4(line[i+1]),	//部分积输出
				.P(ans[i])			//结果输出
			);			
		end
	endgenerate

endmodule 