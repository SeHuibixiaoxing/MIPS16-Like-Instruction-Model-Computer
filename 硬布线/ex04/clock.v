module clock(
	input CLK ,
	input CLR ,
	input[4:0] OP ,
	
	output P_R ,
	output P_RAM ,
	output T0 ,
	output T1 ,
	output T2 ,
	output T3 ,
	output W0 ,
	output W1
);

	reg[3:0] num_P = 4'b1111; 
	reg[1:0] num_P_down = 2'b11;
	
	
	
	assign P_R = num_P[1];
	//assign P_RAM = ~num_P[1];
	assign P_RAM = ~num_P_down[1];
	
	reg[3:0] Tx = 4'b0000;
	reg[1:0] Wx = 2'b01;
	
	assign T0 = Tx[0];
	assign T1 = Tx[1];
	assign T2 = Tx[2];
	assign T3 = Tx[3];
	
	assign W0 = Wx[0];
	assign W1 = Wx[1];
	
	always @(negedge CLK) begin
		num_P_down = num_P_down + 2'b01;
	end
	
	always @(posedge CLK/* or CLR*/) begin
		/*if(CLR == 0) begin
			num_P = 4'b1111;
			Tx = 4'b0000;
			Wx = 2'b00;
		end
		else begin*/
			if(num_P == 4'b1011 && Wx[0]) begin
				Wx = 2'b10;
				num_P = 4'b1111;		
			end
			else if(num_P == 4'b1111 && Wx[1]) begin
				Wx = 2'b01;			
			end
			if((num_P == 4'b0011) && Wx[1] && (OP == 5'b00001 || OP == 5'b00010 || OP == 5'b00011 || OP == 5'b00100 || OP == 5'b00101 || OP == 5'b01010 || OP == 5'b01011 || OP == 5'b01100 || OP == 5'b01101 || OP == 5'b01110 || OP == 5'b01111 || OP == 5'b10000 || OP == 5'b10001 || OP == 5'b10111 || OP == 5'b11000 || OP == 5'b11011 || OP == 5'b11111)) begin
				num_P = 4'b1111;	
				Wx = 2'b01;	
			end
			if((num_P == 4'b0111) && Wx[1] && (OP == 5'b00110 || OP == 5'b00111 || OP == 5'b01000 || OP == 5'b01001 || OP == 5'b10010 || OP == 5'b10011 || OP == 5'b10100 || OP == 5'b10101)) begin
				num_P = 4'b1111;	
				Wx = 2'b01;	
			end
			if((num_P == 4'b1011) && Wx[1] && (OP == 5'b11001 || OP == 5'b11010 || OP == 5'b11110)) begin
				num_P = 4'b1111;	
				Wx = 2'b01;	
			end
			
		
			num_P = num_P + 4'b0001;
			
			
			if(num_P[3:1] == 3'b000) begin
				Tx = 4'b0001;
			end
			else if(num_P[3:1] == 3'b010) begin
				Tx = 4'b0010;
			end
			else if(num_P[3:1] == 3'b100) begin
				Tx = 4'b0100;
			end
			else if(num_P[3:1] == 3'b110) begin
				Tx = 4'b1000;
			end	
		//end
	end

	
endmodule 