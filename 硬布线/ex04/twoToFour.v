module twoToFour(
	input[1:0] A,
	output[3:0] B
);

	assign B[0] = (!A[0]) && (!A[1]);
	assign B[1] = (A[0]) && (!A[1]);
	assign B[2] = (!A[0]) && (A[1]);
	assign B[3] = (A[0]) && (A[1]);
endmodule 