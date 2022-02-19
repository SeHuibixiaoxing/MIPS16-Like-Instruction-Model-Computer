//仿真测试完成

module nextAddress(
	input LOAD ,
	input CLK ,
	input CLR ,
	input JP ,
	input QJP ,
	input[8:0] UIR ,
	input[4:0] OP ,
	output[8:0] address
);

reg[8:0] next_address = 9'b0;

assign address = next_address;

always @(posedge CLK or negedge CLR) begin
	if(CLR == 0) begin
		next_address = 0;
	end
	else if(CLR && LOAD == 1) begin
		next_address = next_address + 1;
	end
	else if(CLR && LOAD == 0 && JP == 1) begin
		next_address = UIR;
	end
	else if(CLR && LOAD == 0 && QJP == 1) begin
		next_address = {OP, 4'b0000};
	end	
end


endmodule 
