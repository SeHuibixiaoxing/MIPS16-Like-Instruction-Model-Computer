//仿真测试完成

module ALU(
	input[4:0] S ,
	input[15:0] A ,
	input[15:0] B ,
	input CN ,
	input jumpTagCLK ,
	output[15:0] ANS ,
	output CNOUT ,
	output reg jumpTag
);

//基本逻辑运算和加减法
/*reg[15:0] ans_base;
reg CN_out;
reg S0, S1, S2, S3, M;

ADD16 add(
		.A(A),				
		.B(B),							
		.CN(CN) ,			
		.S0(S0) ,
		.S1(S1) ,
		.S2(S2) ,
		.S3(S3) ,
		.M(M) ,
		.CNOUT(CN_out) ,
		.F(ans_base)
);*/

reg[15:0] F;
reg CN4;
assign ANS = F;
assign CNOUT = CN4;


//A左移右移运算
reg shift_direction;
wire[15:0] shiftA_out;
shift16(
	.A(A) ,
	.P(shift_direction) ,
	.B(shiftA_out)
);

//B左移右移运算
wire[15:0] shiftB_out;
shift16(
	.A(B) ,
	.P(shift_direction) ,
	.B(shiftB_out)
);


//求补器
wire[15:0] A_complement, B_complement, multi_out_complement, multi_out;
complement16 complementA(
	.A(A) ,
	.B(A_complement)
);
complement16 complementB(
	.A(B) ,
	.B(B_complement)
);
complement16 complement_multi_out(
	.A(multi_out) ,
	.B(multi_out_complement)
);

//带符号数阵列乘法器
multiplication16(
	.A(A) ,
	.B(B) ,
	.C(multi_out)
);

always @(posedge jumpTagCLK) begin
	case(S[4:0])
		5'b11001: begin
			if(A >= B) begin
				jumpTag = 1;
			end
			else begin
				jumpTag = 0;
			end
		end
		5'b11010: begin
			if(A <= B) begin
				jumpTag = 1;
			end
			else begin
				jumpTag = 0;
			end
		end
		5'b11011: begin
			if(A == B) begin
				jumpTag = 1;
			end
			else begin
				jumpTag = 0;
			end
		end
	
	endcase
end


always @(A, B, S, CN, shiftA_out, shiftB_out, multi_out) begin
	case(S[4:0])
		5'b00000: begin
			F = A;
			CN4 = 0;
		end
		5'b00001: begin
			F = B;
			CN4 = 0;
		end
		5'b00010: begin
			{CN4, F} = A + B;
		end
		5'b00011: begin
			{CN4, F} = A - B;
		end
		5'b00100: begin
			{CN4, F} = A + 1;
		end
		5'b00101: begin
			{CN4, F} = A - 1;
		end
		5'b00110: begin
			{CN4, F} = B + 1;
		end
		5'b00111: begin
			{CN4, F} = B - 1;
		end
		5'b01000: begin
			{CN4, F} = A + B + 1;
		end
		5'b01001: begin
			F = multi_out;
		end
		5'b01010: begin
			shift_direction = 0;
			F = shiftA_out;
		end
		5'b01011: begin
			shift_direction = 1;
			F = shiftA_out;
		end
		5'b01100: begin
			shift_direction = 0;
			F = shiftB_out;
		end
		5'b01101: begin
			shift_direction = 1;
			F = shiftB_out;
		end
		5'b01110: begin
			F = A & B;
		end
		5'b01111: begin
			F = A | B;
		end
		5'b10000: begin
			F = A ^ B;
		end
		5'b10001: begin
			F = ~A;
		end
		5'b10010: begin
			F = ~B;
		end
		5'b10011: begin
			F = ({1'b0, A} > {1'b0, B});
		end
		5'b10100: begin
			F = ({1'b0, A} < {1'b0, B});
		end
		5'b10101: begin
			F = ({1'b0, A} == {1'b0, B});
		end
		5'b10110: begin
			F = ({1'b0, A} != {1'b0, B}) ;
		end
		5'b10111: begin
			F[15:8] = A[7:0];
			F[7:0] = B[15:8];
		end
		5'b11000: begin
			F[15:8] = A[15:8];
			F[7:0] = B[7:0];
		end
		5'b11100: begin
			if(jumpTag == 1) begin
				F = A + B;
			end
			else if(jumpTag == 0) begin
				F = A;
			end
		end
	endcase
end


endmodule
