module ex03(
//	output[15:0] q_RAMO ,
//	output[15:0] selectAO ,
//	output[15:0] selectBO ,
//	output[15:0] ALU_FO ,
//	output[8:0] microInstructionO ,
//	output[8:0] next_micro_addressO,
//	output[15:0] R1_INO ,
	output P_UPCO ,
	output P_RO ,
	output P_RAMO ,
//	output[15:0] immediate8O ,
//	output[15:0] IRO ,
	output[15:0] PCO ,
//	output jumpTagO ,
//	output[15:0] address_RAMO ,
//	output[15:0] data_RAMO ,
//	output wren_RAMO ,
//	output rden_RAMO ,
	output[15:0] R2O ,
//	output[15:0] R1O ,
//	output[15:0] R3O ,
//	output[15:0] R4O ,
//	output[15:0] R5O ,
	output[15:0] R6O ,
	output[15:0] R7O ,
//	output[15:0] MARO ,
//	output[15:0] RAO ,
//	output[15:0] RBO ,
//	output[15:0] R0O ,
//	output CPR_PO ,
//	output CPR1O , 
//	output CPR2O ,
//	output CPR0O ,
//	output[3:0] CPR_select_control4O ,
//	output[1:0] CPR_select_control2O ,
//	output[4:0] ALU_SO ,
//	output CPIR0 ,
//	output[2:0] select_control_A0 ,
//	output[7:0] YYAO ,

	input G ,			//G=1:连续脉冲,G=0:单步脉冲
	input OPEN ,		//开机标志
	input CLK_CONTINUOUS,
	input CLK_SINGLESTEP
);
	
	wire CLK, HaltTag;
	
	assign CLR = OPEN;
	assign CLK = (~HaltTag) & ((G & CLK_CONTINUOUS) | ((!G) & CLK_SINGLESTEP));
	
	CPU cpu(
		.jumpTagO(jumpTagO) ,
		.rden_RAMO(rden_RAMO) ,
		.wren_RAMO(wren_RAMO) ,
		.data_RAMO(data_RAMO) ,
		.address_RAMO(address_RAMO) ,
		.MARO(MARO) ,
		.R7O(R7O) ,
		.R6O(R6O) ,
		.R5O(R5O) ,
		.R4O(R4O) ,
		.R3O(R3O) ,
		.RAO(RAO) ,
		.RBO(RBO) ,
		.CPR_select_control4O(CPR_select_control4O) ,
		.CPR_select_control2O(CPR_select_control2O) ,
		.CPR0O(CPR0O) ,
		.CPR2O(CPR2O) ,
		.R0O(R0O) ,
		.q_RAMO(q_RAMO) ,
		.selectAO(selectAO) ,
		.selectBO(selectBO) ,
		.ALU_FO(ALU_FO) ,
		.microInstructionO(microInstructionO) ,
		.P_UPCO (P_UPCO),
		.P_RO (P_RO),
		.next_micro_addressO(next_micro_addressO),
		.P_RAMO (P_RAMO) ,
		.immediate8O(immediate8O) ,
		.PCO(PCO) ,
		.ALU_SO(ALU_SO) ,
		.R2O(R2O) ,
		.IRO(IRO) ,
		.R1O(R1O) ,
		.CPIR0(CPIR0) ,
		.select_control_A0(select_control_A0) ,	
		.YYAO(YYAO) ,
		.CPR_PO(CPR_PO) ,
		.CPR1O(CPR1O) ,
		.R1_INO(R1_INO) ,
		
		
		.HaltTag(HaltTag) ,
		
		.CLR(CLR) ,			
		.CLK(CLK) ,
	);
	

endmodule