
module selector8(
	input [15:0] D0 ,
	input [15:0] D1 ,
	input [15:0] D2 ,
	input [15:0] D3 ,
	input [15:0] D4 ,
	input [15:0] D5 ,
	input [15:0] D6 ,
	input [15:0] D7 ,
	input [2:0] CPQ ,
	output [15:0] Q ,
	output[7:0] YY
);

wire[7:0] PY;
wire[7:0] Y;
assign YY = PY;

\74138 three_two_translator(
	.G1(1) ,
	.G2AN(0) ,
	.G2BN(0) ,
	.A(CPQ[0]) ,
	.B(CPQ[1]) ,
	.C(CPQ[2]) ,
	.Y7N(Y[7]) ,	
	.Y6N(Y[6]) ,	
	.Y5N(Y[5]) ,	
	.Y4N(Y[4]) ,	
	.Y3N(Y[3]) ,	
	.Y2N(Y[2]) ,	
	.Y1N(Y[1]) ,	
	.Y0N(Y[0]) 
);


genvar i;
generate
	for(i = 0;i < 8;i = i + 1) begin:rank
		assign PY[i] = ~Y[i];
	end
	for(i = 0;i < 16;i = i + 1) begin:rank4
		assign Q[i] = (PY[0]&D0[i]) | 
						  (PY[1]&D1[i]) | 
						  (PY[2]&D2[i]) | 
						  (PY[3]&D3[i]) | 
						  (PY[4]&D4[i]) | 
						  (PY[5]&D5[i]) | 
						  (PY[6]&D6[i]) | 
						  (PY[7]&D7[i]);  
	end
endgenerate



endmodule 