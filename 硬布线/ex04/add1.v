module add1(
	input A ,
	input B ,
	input C ,
	output S ,
	output C4
);
	assign S = A ^ B ^ C;
	assign C4 = (A & B) | ((A | B) & C);

endmodule
