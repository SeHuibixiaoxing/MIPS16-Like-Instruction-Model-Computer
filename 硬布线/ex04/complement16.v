//仿真检测正确
module complement16(
	input wire[15:0] A,
	output reg[15:0] B
);


reg C[16:0];
reg E ;

always @(*) begin
	integer i;
	B[15] = A[15];
	E = A[15];
	C[0] = 0 ;
	for(i = 0;i < 15;i = i + 1) begin
		B[i] = (E & C[i]) ^ A[i];
		C[i + 1] = C[i] | A[i];
	end
end

endmodule

