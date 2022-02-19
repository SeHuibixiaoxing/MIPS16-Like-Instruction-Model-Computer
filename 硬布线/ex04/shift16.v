//仿真验证通过
module shift16 (
	input[15:0] A,
	input P ,		//P=0 左移   P=1右移
	output reg[15:0] B
);


always @(*) begin
	if(P == 1) begin
		integer i;
		for(i = 0;i < 15;i = i + 1) begin
			B[i] <= A[i+1];
		end
		B[15] <= 0;
	end
	else begin
		integer j;
		for(j = 1;j < 16;j = j + 1) begin
				B[j] <= A[j - 1];
		end
		B[0] <= 0;
	end
end

endmodule
