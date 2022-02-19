module selector8_2(
	input [15:0] D0 ,
	input [15:0] D1 ,
	input [15:0] D2 ,
	input [15:0] D3 ,
	input [15:0] D4 ,
	input [15:0] D5 ,
	input [15:0] D6 ,
	input [15:0] D7 ,
	input [7:0] Y ,
	output [15:0] Q
);

genvar i;
generate
	for(i = 0;i < 16;i = i + 1) begin:rank
		assign Q[i] = (Y[0]&D0[i]) | (Y[1]&D1[i]) | (Y[2]&D2[i]) | (Y[3]&D3[i]) | (Y[4]&D4[i]) | (Y[5]&D5[i]) | (Y[6]&D6[i]) | (Y[7]&D7[i]);  
	end
endgenerate



endmodule 