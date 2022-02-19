module clock3(
	input CLK ,
	input CLR ,
	output[2:0] q
);

	reg[2:0] i = 3'b111;
	assign q[0] = ~i[0];
	assign q[1] = ~i[1];
	assign q[2] = ~i[2];
	
	always @(posedge CLK or negedge CLR) begin
		if (CLR == 1'b0)
			i <= 3'b111;
		else
			i <= i + 3'b001;		
	end


endmodule 