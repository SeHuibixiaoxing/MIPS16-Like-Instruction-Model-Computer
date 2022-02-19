
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
	output[2:0] select_control_A0 ,
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
	output jumpTagO ,
	output CPPCO ,
	
	output T0O ,
	output T1O ,
	output T2O ,
	output T3O ,
	output W0O ,
	output W1O 
);
//测试代码
	assign CPPCO = CPPC;
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
	assign PCO = pc_out;
	assign P_RO = P_R;
	assign CPIR0 = CPIR;
	assign P_RAMO = P_RAM;
	assign IRO = inst_out;
	assign R2O = R_out[2];
	assign R1O = R_out[1];
	assign select_control_A0 = select_control_A;
	assign T0O = T0;
	assign T1O = T1;
	assign T2O = T2;
	assign T3O = T3;
	assign W0O = W0;
	assign W1O = W1;
	
	//控制信号
	wire[35:0] control_singal;
	
	//指令
	wire[15:0] instruction;
	
	//停机
	assign HaltTag = control_singal[0];

	//节拍发生器
	wire P_R;			//寄存器脉冲
	wire P_RAM;			//RAM脉冲
	wire T0, T1, T2, T3;
	wire W0, W1;
	
	clock make_clock(
		.OP(instruction[15:11]) ,
		.CLK(CLK) ,
		.CLR(CLR) ,
		.P_R(P_R)  ,
		.P_RAM(P_RAM) ,
		.T0(T0) ,
		.T1(T1) ,
		.T2(T2) ,
		.T3(T3) ,
		.W0(W0) ,
		.W1(W1)
	);
	
	

	//8个寄存器的脉冲信号的选择控制
	wire[15:0] R_in[7:0], R_out[7:0];
	wire[15:0] RA, RB;
	
	wire CPR_P = control_singal[35] & P_R;
	
	wire[7:0] CPR;										//最终CPR信号
	wire[2:0] CPR3_from_microInstruction;		//从微指令获取的3位CPR信号
	wire[2:0] CPR3_from_instruction[2:0];		//从指令获取的3位CPR信号
	wire[7:0] CPR_from_microInstruction;		//从微指令获得的8位CPR信号
	wire[7:0] CPR_from_instruction[2:0];		//从指令获得的8位CPR信号
	wire[1:0] CPR_select_control2;				//从微指令选还是指令选的2位控制信号
	wire[3:0] CPR_select_control4;				//从微指令选还是指令选的4位控制信号
	
	assign CPR3_from_microInstruction = control_singal[32:30];
	assign CPR3_from_instruction[0] = instruction[10:8];
	assign CPR3_from_instruction[1] = instruction[7:5];
	assign CPR3_from_instruction[2] = instruction[4:2];
	assign CPR_select_control2 = control_singal[34:33];

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
	
	assign control_select_control_RA2 = control_singal[4:3];
	assign control_select_control_RB2 = control_singal[6:5];
	assign select_control_RA_from_microInstruction3 = control_singal[9:7];
	assign select_control_RB_from_microInstruction3 = control_singal[12:10];
	
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
	assign CPIR = P_R & control_singal[29];
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
	
	assign rden_RAM = (control_singal[2]) && (!control_singal[1]);
	assign wren_RAM = (control_singal[1]) && (!control_singal[2]);
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
	
	assign CPMAR = P_R & control_singal[25];
	assign MAR_REST = control_singal[26];
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
	
	assign CPPC = P_R & control_singal[27];
	assign PC_REST = control_singal[28];
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
	
	assign select_control_A = control_singal[15:13];
	assign select_control_B = control_singal[18:16];
	
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
	
	assign ALU_S = control_singal[23:19];
	assign ALU_CN = control_singal[24];
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

	
/*	assign control_singal[0] = 0;
	assign control_singal[1] = 0;
	assign control_singal[2] = ((W0) && (T1)) || 0;
	assign control_singal[3] = ((W0) && (T0)) || ((W0) && (T1)) || ((W0) && (T2)) || 0;
	assign control_singal[4] = ((W0) && (T0)) || ((W0) && (T1)) || ((W0) && (T2)) || 0;
	assign control_singal[5] = ((W0) && (T0)) || ((W0) && (T1)) || ((W0) && (T2)) || 0;
	assign control_singal[6] = ((W0) && (T0)) || ((W0) && (T1)) || ((W0) && (T2)) || 0;
	assign control_singal[7] = 0;
	assign control_singal[8] = 0;
	assign control_singal[9] = 0;
	assign control_singal[10] = 0;
	assign control_singal[11] = 0;
	assign control_singal[12] = 0;
	assign control_singal[13] = ((W0) && (T0)) || ((W0) && (T2)) || 0;
	assign control_singal[14] = ((W0) && (T0)) || ((W0) && (T1)) || ((W0) && (T2)) || 0;
	assign control_singal[15] = ((W0) && (T0)) || ((W0) && (T2)) || 0;
	assign control_singal[16] = 0;
	assign control_singal[17] = 0;
	assign control_singal[18] = 0;
	assign control_singal[19] = 0;
	assign control_singal[20] = 0;
	assign control_singal[21] = ((W0) && (T2)) || 0;
	assign control_singal[22] = 0;
	assign control_singal[23] = 0;
	assign control_singal[24] = 0;
	assign control_singal[25] = ((W0) && (T0)) || 0;
	assign control_singal[26] = 1
	assign control_singal[27] = ((W0) && (T2)) || 0;
	assign control_singal[28] = 1;
	assign control_singal[29] = ((W0) && (T1)) || 0;
	assign control_singal[30] = 0;	
	assign control_singal[31] = 0;	
	assign control_singal[32] = 0;
	assign control_singal[33] = ((W0) && (T0)) || ((W0) && (T1)) || ((W0) && (T2)) || 0;
	assign control_singal[34] = ((W0) && (T0)) || ((W0) && (T1)) || ((W0) && (T2)) || 0;
	assign control_singal[35] = 0;*/
	assign control_singal[0] = ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || 0;
assign control_singal[1] = ((T1) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T2) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || 0;
assign control_singal[2] = ((T1) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((W0) && (T1)) || 0;
assign control_singal[3] = ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T3) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T3) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((W0) && (T0)) || ((W0) && (T1)) || ((W0) && (T2)) || 0;
assign control_singal[4] = ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T3) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T3) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((W0) && (T0)) || ((W0) && (T1)) || ((W0) && (T2)) || 0;
assign control_singal[5] = ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T3) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T3) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T3) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((W0) && (T0)) || ((W0) && (T1)) || ((W0) && (T2)) || 0;
assign control_singal[6] = ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T3) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T3) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T3) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((W0) && (T0)) || ((W0) && (T1)) || ((W0) && (T2)) || 0;
assign control_singal[7] = ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || 0;
assign control_singal[8] = ((T1) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || 0;
assign control_singal[9] = ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || 0;
assign control_singal[10] = 0;
assign control_singal[11] = 0;
assign control_singal[12] = 0;
assign control_singal[13] = ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T3) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((W0) && (T0)) || ((W0) && (T2)) || 0;
assign control_singal[14] = ((T1) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T3) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((W0) && (T0)) || ((W0) && (T1)) || ((W0) && (T2)) || 0;
assign control_singal[15] = ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T3) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((W0) && (T0)) || ((W0) && (T2)) || 0;
assign control_singal[16] = ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T3) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T3) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || 0;
assign control_singal[17] = ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || 0;
assign control_singal[18] = ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T3) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || 0;
assign control_singal[19] = ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || 0;
assign control_singal[20] = ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T3) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || 0;
assign control_singal[21] = ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((W0) && (T2)) || 0;
assign control_singal[22] = ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || 0;
assign control_singal[23] = ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || 0;
assign control_singal[24] = 0;
assign control_singal[25] = ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((W0) && (T0)) || 0;
assign control_singal[26] = ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T3) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T3) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T3) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || 1;
assign control_singal[27] = ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T3) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T3) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((W0) && (T2)) || 0;
assign control_singal[28] = ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T3) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T3) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T3) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || 1;
assign control_singal[29] = ((W0) && (T1)) || 0;
assign control_singal[30] = ((T1) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || 0;
assign control_singal[31] = ((T1) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || 0;
assign control_singal[32] = ((T1) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || 0;
assign control_singal[33] = ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T3) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T3) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T3) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((W0) && (T0)) || ((W0) && (T1)) || ((W0) && (T2)) || 0;
assign control_singal[34] = ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T3) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T3) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T3) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((W0) && (T0)) || ((W0) && (T1)) || ((W0) && (T2)) || 0;
assign control_singal[35] = ((T0) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (!instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (!instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (instruction[13]) && (!instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T2) && (!instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (instruction[11]) && (instruction[12]) && (!instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (!instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T1) && (instruction[11]) && (!instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || ((T0) && (!instruction[11]) && (instruction[12]) && (instruction[13]) && (instruction[14]) && (instruction[15]) && (W1)) || 0;
	
	
	
endmodule 