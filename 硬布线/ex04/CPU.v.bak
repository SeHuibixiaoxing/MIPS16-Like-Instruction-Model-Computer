
module CPU(
	input CLR ,
	input CLK ,
	output HaltTag ,
	
	output[15:0] q_RAMO ,
	output[15:0] selectAO ,
	output[15:0] selectBO ,
	output[15:0] RAO ,
	output[15:0] RBO ,
	output[15:0] ALU_FO ,
	output[8:0] microInstructionO ,
	output[8:0] next_micro_addressO,
	output[2:0] select_control_A0 ,
	output P_UPCO ,
	output P_RO ,
	output P_RAMO ,
	output[15:0] PCO ,
	output[15:0] IRO ,
	output[15:0] R2O ,
	output[15:0] R1O ,
	output[4:0] ALU_SO ,
	output CPIR0 ,
	output[7:0] YYAO,
	output[15:0] immediate8O,
	output CPR_PO ,
	output CPR1O ,
	output[15:0] R1_INO ,
	output CPR2O ,
	output[15:0] R0O ,
	output CPR0O ,
	output[1:0] CPR_select_control2O ,
	output[3:0] CPR_select_control4O ,
	output[15:0] R3O ,
	output[15:0] R4O ,
	output[15:0] R5O ,
	output[15:0] MARO ,
	output[15:0] R6O ,
	output[15:0] R7O ,
	output[15:0] address_RAMO ,
	output[15:0] data_RAMO ,
	output wren_RAMO ,
	output rden_RAMO ,
	output jumpTagO 
);
//测试代码
	assign jumpTagO = jumpTag;
	assign rden_RAMO = rden_RAM;
	assign wren_RAMO = wren_RAM;
	assign data_RAMO = data_RAM;
	assign address_RAMO = address_RAM;
	assign R7O = R_out[7];
	assign R6O = R_out[6];
	assign MARO = MAR_out;
	assign R5O = R_out[5];
	assign R4O = R_out[4];
	assign R3O = R_out[3];
	assign CPR_select_control4O = CPR_select_control4;
	assign CPR_select_control2O = CPR_select_control2;
	assign RAO = RA;
	assign RBO = RB;
	assign R0O = R_out[0];
	assign R2O = R_out[2];
	assign CPR2O = CPR[2];
	assign R1_INO = R_in[1];
	assign CPR0O = CPR[0];
	assign CPR1O = CPR[1];
	assign CPR_PO = CPR_P;
	assign immediate8O = immediate8;
	assign selectBO = selectB;
	assign q_RAMO = q_RAM;
	assign selectAO = selectA;
	assign ALU_FO = ALU_F;
	assign ALU_SO = ALU_S;
	assign microInstructionO = microInstruction[8:0];
	assign P_UPCO = P_UPC;
	assign PCO = pc_out;
	assign P_RO = P_R;
	assign CPIR0 = CPIR;
	assign P_RAMO = P_RAM;
	assign next_micro_addressO = next_micro_address;
	assign IRO = inst_out;
	assign R2O = R_out[2];
	assign R1O = R_out[1];
	assign select_control_A0 = select_control_A;

	//微指令
	wire[63:0] microInstruction;
	//指令
	wire[15:0] instruction;
	
	//停机
	assign HaltTag = microInstruction[3];

	//时钟脉冲发生装置
	wire P_R;			//寄存器脉冲
	wire P_RAM;			//RAM脉冲
	wire P_UPC;			//UPC脉冲
	wire [2:0] clk;
	
	clock3 make_clock3(
		.CLK(CLK) ,
		.CLR(CLR) ,
		.q(clk) 
	);
	
	assign P_R = ~clk[1];
	assign P_RAM = ~clk[0];
	assign P_UPC = clk[1];
	

	//8个寄存器的脉冲信号的选择控制
	wire[15:0] R_in[7:0], R_out[7:0];
	wire[15:0] RA, RB;
	
	wire CPR_P = microInstruction[38] & P_R;
	
	wire[7:0] CPR;										//最终CPR信号
	wire[2:0] CPR3_from_microInstruction;		//从微指令获取的3位CPR信号
	wire[2:0] CPR3_from_instruction[2:0];		//从指令获取的3位CPR信号
	wire[7:0] CPR_from_microInstruction;		//从微指令获得的8位CPR信号
	wire[7:0] CPR_from_instruction[2:0];		//从指令获得的8位CPR信号
	wire[1:0] CPR_select_control2;				//从微指令选还是指令选的2位控制信号
	wire[3:0] CPR_select_control4;				//从微指令选还是指令选的4位控制信号
	
	assign CPR3_from_microInstruction = microInstruction[35:33];
	assign CPR3_from_instruction[0] = instruction[10:8];
	assign CPR3_from_instruction[1] = instruction[7:5];
	assign CPR3_from_instruction[2] = instruction[4:2];
	assign CPR_select_control2 = microInstruction[37:36];

	threeToEight cpr_three_eight1(
		.A(CPR3_from_microInstruction) ,
		.B(CPR_from_microInstruction)
	);
	threeToEight cpr_three_eight2(
		.A(CPR3_from_instruction[0]) ,
		.B(CPR_from_instruction[0])
	);
	threeToEight cpr_three_eight3(
		.A(CPR3_from_instruction[1]) ,
		.B(CPR_from_instruction[1])
	);
	threeToEight cpr_three_eight4(
		.A(CPR3_from_instruction[2]) ,
		.B(CPR_from_instruction[2])
	);
	
	twoToFour cpr_tow_four1(
		.A(CPR_select_control2) ,
		.B(CPR_select_control4)
	);
	
	genvar j;
	generate
		for(j = 0;j < 8;j = j + 1) begin: cpr
			assign R_in[j] = ALU_F;
			assign CPR[j] = CPR_P & ((CPR_from_microInstruction[j] & CPR_select_control4[3]) |
								 (CPR_from_instruction[0][j] & CPR_select_control4[0]) |
								 (CPR_from_instruction[1][j] & CPR_select_control4[1]) |
								 (CPR_from_instruction[2][j] & CPR_select_control4[2]));
		end
	endgenerate
	
	
	//8个寄存器的选择控制器
	wire[7:0] select_control_RA, select_control_RB;//两个寄存器的最终选择控制信号
	
	wire[2:0] select_control_RA_from_microInstruction3, select_control_RB_from_microInstruction3;
	wire[2:0] select_control_RA_from_instruction3[2:0], select_control_RB_from_instruction3[2:0];
	
	wire[7:0] select_control_RA_from_microInstruction8, select_control_RB_from_microInstruction8;
	wire[7:0] select_control_RA_from_instruction8[2:0], select_control_RB_from_instruction8[2:0];
	
	wire[1:0] control_select_control_RA2, control_select_control_RB2;
	wire[3:0] control_select_control_RA4, control_select_control_RB4;
	
	assign control_select_control_RA2 = microInstruction[7:6];
	assign control_select_control_RB2 = microInstruction[9:8];
	assign select_control_RA_from_microInstruction3 = microInstruction[12:10];
	assign select_control_RB_from_microInstruction3 = microInstruction[15:13];
	
	assign select_control_RA_from_instruction3[0] = instruction[10:8];
	assign select_control_RB_from_instruction3[0] = instruction[10:8];
	assign select_control_RA_from_instruction3[1] = instruction[7:5];
	assign select_control_RB_from_instruction3[1] = instruction[7:5];	
	assign select_control_RA_from_instruction3[2] = instruction[4:2];
	assign select_control_RB_from_instruction3[2] = instruction[4:2];
	
	threeToEight select_control_three_eight1(
		.A(select_control_RA_from_microInstruction3) ,
		.B(select_control_RA_from_microInstruction8)
	);
	threeToEight select_control_three_eight2(
		.A(select_control_RB_from_microInstruction3) ,
		.B(select_control_RB_from_microInstruction8)
	);
	
	threeToEight select_control_three_eight3(
		.A(select_control_RA_from_instruction3[0]) ,
		.B(select_control_RA_from_instruction8[0])
	);
	threeToEight select_control_three_eight4(
		.A(select_control_RB_from_instruction3[0]) ,
		.B(select_control_RB_from_instruction8[0])
	);
	
	threeToEight select_control_three_eight5(
		.A(select_control_RA_from_instruction3[1]) ,
		.B(select_control_RA_from_instruction8[1])
	);
	threeToEight select_control_three_eight6(
		.A(select_control_RB_from_instruction3[1]) ,
		.B(select_control_RB_from_instruction8[1])
	);
	
	threeToEight select_control_three_eight7(
		.A(select_control_RA_from_instruction3[2]) ,
		.B(select_control_RA_from_instruction8[2])
	);
	threeToEight select_control_three_eight8(
		.A(select_control_RB_from_instruction3[2]) ,
		.B(select_control_RB_from_instruction8[2])
	);
	
	
	
	twoToFour select_control_two_Four1(
		.A(control_select_control_RA2) ,
		.B(control_select_control_RA4)
	);
	twoToFour select_control_two_Four2(
		.A(control_select_control_RB2) ,
		.B(control_select_control_RB4)
	);
	
	
	genvar k;
	generate
		for(k = 0;k < 8;k = k + 1) begin: select_control
			assign select_control_RA[k] = (control_select_control_RA4[3] & select_control_RA_from_microInstruction8[k]) |
													(control_select_control_RA4[0] & select_control_RA_from_instruction8[0][k]) |
													(control_select_control_RA4[1] & select_control_RA_from_instruction8[1][k]) |
													(control_select_control_RA4[2] & select_control_RA_from_instruction8[2][k]);
			assign select_control_RB[k] = (control_select_control_RB4[3] & select_control_RB_from_microInstruction8[k]) |
													(control_select_control_RB4[0] & select_control_RB_from_instruction8[0][k]) |
													(control_select_control_RB4[1] & select_control_RB_from_instruction8[1][k]) |
													(control_select_control_RB4[2] & select_control_RB_from_instruction8[2][k]);
		end
	endgenerate
	
	register16 R_add_register_0(
				.CLR(0) ,
				.D(R_in[0]) ,
				.Q(R_out[0]) ,
				.CPR(CPR[0])
				);
	genvar i ;
	generate
		for(i = 1;i < 8;i = i + 1) begin: add_register
			register16 R(
				.CLR(CLR) ,
				.D(R_in[i]) ,
				.Q(R_out[i]) ,
				.CPR(CPR[i])
				);
		end
	endgenerate

	
	selector8_2 select_RA(
		.D0(R_out[0]) ,
		.D1(R_out[1]) ,
		.D2(R_out[2]) ,
		.D3(R_out[3]) ,
		.D4(R_out[4]) ,
		.D5(R_out[5]) ,
		.D6(R_out[6]) ,
		.D7(R_out[7]) ,
		.Y(select_control_RA),
		.Q(RA)
	);
	
	selector8_2 select_RB(
		.D0(R_out[0]) ,
		.D1(R_out[1]) ,
		.D2(R_out[2]) ,
		.D3(R_out[3]) ,
		.D4(R_out[4]) ,
		.D5(R_out[5]) ,
		.D6(R_out[6]) ,
		.D7(R_out[7]) ,
		.Y(select_control_RB),
		.Q(RB)
	);
	
	//指令寄存器IR
	wire[15:0] inst_in, inst_out;
	wire CPIR;

	assign instruction = inst_out;
	assign CPIR = P_R & microInstruction[32];
	assign inst_in = ALU_F;
	
	register16 IR(
		.CLR(CLR) ,
		.D(inst_in) ,
		.Q(inst_out) ,
		.CPR(CPIR)
	);
		
	//RAM 1024x16
	wire[15:0] address_RAM;
	wire clk_RAM;
	wire[15:0] data_RAM, q_RAM;
	wire rden_RAM;
	wire wren_RAM;
	
	assign rden_RAM = (microInstruction[5]) && (!microInstruction[4]);
	assign wren_RAM = (microInstruction[4]) && (!microInstruction[5]);
	assign clk_RAM = P_RAM;
	assign data_RAM = ALU_F;
	assign address_RAM = MAR_out;
	
	ram RAM(
		.address(address_RAM[9:0]) ,
		.clock(clk_RAM) ,
		.data(data_RAM) ,
		.q(q_RAM) ,
		.wren(wren_RAM) ,
		.rden(rden_RAM)
	);
	
	
	//立即数
	wire[15:0] immediate8;
	wire[15:0] immediate5;
	wire[15:0] immediate11;
	
	assign immediate8 = {8'b0, instruction[7:0]};
	assign immediate5 = {11'b0, instruction[4:0]};
	assign immediate11 = {5'b0, instruction[10:0]};
	
	//MAR	
	wire[15:0] MAR_in, MAR_out;
	wire CPMAR, MAR_REST;
	
	assign CPMAR = P_R & microInstruction[28];
	assign MAR_REST = microInstruction[29];
	assign MAR_in = ALU_F;
	
	register16 MAR(
		.CLR(MAR_REST) ,
		.D(MAR_in) ,
		.Q(MAR_out) ,
		.CPR(CPMAR)
	);
	
	//PC
	wire[15:0] pc_in, pc_out;
	wire CPPC;
	wire PC_REST;
	
	assign CPPC = P_R & microInstruction[30];
	assign PC_REST = microInstruction[31];
	assign pc_in = ALU_F;
	
	
	register16 PC(
		.CLR(PC_REST) ,
		.D(pc_in) ,
		.Q(pc_out) ,
		.CPR(CPPC)
	);
	
	
	
	//A、B选择器:R,RAM,立即数1,立即数2,立即数3,MAR,PC
	wire[2:0] select_control_A, select_control_B;
	wire[15:0] selectA, selectB;
	
	assign select_control_A = microInstruction[18:16];
	assign select_control_B = microInstruction[21:19];
	
	selector8 select_A(
			.D0(RA) ,
			.D1(RB) ,
			.D2(q_RAM) ,
			.D3(immediate5) ,
			.D4(immediate8) ,
			.D5(immediate11) ,
			.D6(MAR_out) ,
			.D7(pc_out) ,
			.CPQ(select_control_A),
			.Q(selectA) ,
			.YY(YYAO)
		);
	selector8 select_B(
			.D0(RA) ,
			.D1(RB) ,
			.D2(q_RAM) ,
			.D3(immediate5) ,
			.D4(immediate8) ,
			.D5(immediate11) ,
			.D6(MAR_out) ,
			.D7(pc_out) ,
			.CPQ(select_control_B),
			.Q(selectB)
		);
		
	//ALU
	wire[4:0] ALU_S;
	wire ALU_CN, ALU_CN4;
	wire[15:0] ALU_F, ALU_A, ALU_B;
	wire jumpTag;
	
	assign ALU_S = microInstruction[26:22];
	assign ALU_CN = microInstruction[27];
	assign ALU_A = selectA;
	assign ALU_B = selectB;
	

	ALU(
		.S(ALU_S) ,
		.A(ALU_A) ,
		.B(ALU_B) ,
		.CN(ALU_CN) ,
		.CNOUT(ALU_CN4) ,
		.ANS(ALU_F) ,
		.jumpTag(jumpTag) ,
		.jumpTagCLK(P_R)
	);

	//后继地址形成
	wire[8:0] next_micro_address;
	wire[2:0] control_next_micro_address;
	wire next_micro_address_clk;
	wire[8:0] micro_address_from_UIR;
	wire[4:0] micro_address_from_OP;
	wire LOAD, JP, QJP;
	
	assign next_micro_address_clk = ~P_UPC;
	
	assign control_next_micro_address = microInstruction[2:0];
	assign micro_address_from_UIR = microInstruction[47:39];
	assign micro_address_from_OP = instruction[15:11];
	assign LOAD = (control_next_micro_address[0]) && 
					  (!control_next_micro_address[1]) && 
					  (!control_next_micro_address[2]);
	assign JP = (!control_next_micro_address[0]) && 
					(control_next_micro_address[1]) && 
					(!control_next_micro_address[2]);
	assign QJP = (control_next_micro_address[0]) && 
					 (control_next_micro_address[1]) && 
					 (!control_next_micro_address[2]);
	
	nextAddress next_micro(
		.LOAD(LOAD),
		.CLK(next_micro_address_clk) ,
		.CLR(CLR),
		.JP(JP),
		.QJP(QJP),
		.UIR(micro_address_from_UIR) ,
		.OP(micro_address_from_OP) ,
		.address(next_micro_address)
	);
	
	
	//ROM
	rom ROM1(
		.clock(P_UPC) ,
		.address(next_micro_address) ,
		.q(microInstruction)
	);
endmodule 