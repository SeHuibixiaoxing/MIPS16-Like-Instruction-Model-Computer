// Copyright (C) 2020  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition"
// CREATED		"Tue Mar 16 14:06:28 2021"

module \74173 (
	CLR,
	CLK,
	G2N,
	G1N,
	NN,
	MN,
	D1,
	D2,
	D3,
	D4,
	Q4,
	Q3,
	Q2,
	Q1
);


input wire	CLR;
input wire	CLK;
input wire	G2N;
input wire	G1N;
input wire	NN;
input wire	MN;
input wire	D1;
input wire	D2;
input wire	D3;
input wire	D4;
output wire	Q4;
output wire	Q3;
output wire	Q2;
output wire	Q1;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_7;
wire	SYNTHESIZED_WIRE_29;
reg	SYNTHESIZED_WIRE_30;
wire	SYNTHESIZED_WIRE_31;
reg	SYNTHESIZED_WIRE_32;
reg	SYNTHESIZED_WIRE_33;
reg	SYNTHESIZED_WIRE_34;
wire	SYNTHESIZED_WIRE_35;
wire	SYNTHESIZED_WIRE_36;
wire	SYNTHESIZED_WIRE_22;
wire	SYNTHESIZED_WIRE_24;
wire	SYNTHESIZED_WIRE_26;
wire	SYNTHESIZED_WIRE_28;




assign	SYNTHESIZED_WIRE_22 = SYNTHESIZED_WIRE_0 | SYNTHESIZED_WIRE_1;

assign	SYNTHESIZED_WIRE_24 = SYNTHESIZED_WIRE_2 | SYNTHESIZED_WIRE_3;

assign	SYNTHESIZED_WIRE_26 = SYNTHESIZED_WIRE_4 | SYNTHESIZED_WIRE_5;

assign	SYNTHESIZED_WIRE_28 = SYNTHESIZED_WIRE_6 | SYNTHESIZED_WIRE_7;

assign	SYNTHESIZED_WIRE_1 = D4 & SYNTHESIZED_WIRE_29;

assign	SYNTHESIZED_WIRE_0 = SYNTHESIZED_WIRE_30 & SYNTHESIZED_WIRE_31;

assign	SYNTHESIZED_WIRE_3 = D3 & SYNTHESIZED_WIRE_29;

assign	SYNTHESIZED_WIRE_2 = SYNTHESIZED_WIRE_32 & SYNTHESIZED_WIRE_31;

assign	SYNTHESIZED_WIRE_5 = D2 & SYNTHESIZED_WIRE_29;

assign	SYNTHESIZED_WIRE_4 = SYNTHESIZED_WIRE_33 & SYNTHESIZED_WIRE_31;

assign	SYNTHESIZED_WIRE_7 = D1 & SYNTHESIZED_WIRE_29;

assign	SYNTHESIZED_WIRE_6 = SYNTHESIZED_WIRE_34 & SYNTHESIZED_WIRE_31;

assign	SYNTHESIZED_WIRE_36 =  ~CLR;

assign	SYNTHESIZED_WIRE_31 =  ~SYNTHESIZED_WIRE_29;

assign	SYNTHESIZED_WIRE_35 = ~(MN | NN);

assign	SYNTHESIZED_WIRE_29 = ~(G1N | G2N);

assign	Q1 = SYNTHESIZED_WIRE_35 ? SYNTHESIZED_WIRE_34 : 1'bz;

assign	Q2 = SYNTHESIZED_WIRE_35 ? SYNTHESIZED_WIRE_33 : 1'bz;

assign	Q3 = SYNTHESIZED_WIRE_35 ? SYNTHESIZED_WIRE_32 : 1'bz;

assign	Q4 = SYNTHESIZED_WIRE_35 ? SYNTHESIZED_WIRE_30 : 1'bz;


always@(posedge CLK or negedge SYNTHESIZED_WIRE_36)
begin
if (!SYNTHESIZED_WIRE_36)
	begin
	SYNTHESIZED_WIRE_30 <= 0;
	end
else
	begin
	SYNTHESIZED_WIRE_30 <= SYNTHESIZED_WIRE_22;
	end
end


always@(posedge CLK or negedge SYNTHESIZED_WIRE_36)
begin
if (!SYNTHESIZED_WIRE_36)
	begin
	SYNTHESIZED_WIRE_32 <= 0;
	end
else
	begin
	SYNTHESIZED_WIRE_32 <= SYNTHESIZED_WIRE_24;
	end
end


always@(posedge CLK or negedge SYNTHESIZED_WIRE_36)
begin
if (!SYNTHESIZED_WIRE_36)
	begin
	SYNTHESIZED_WIRE_33 <= 0;
	end
else
	begin
	SYNTHESIZED_WIRE_33 <= SYNTHESIZED_WIRE_26;
	end
end


always@(posedge CLK or negedge SYNTHESIZED_WIRE_36)
begin
if (!SYNTHESIZED_WIRE_36)
	begin
	SYNTHESIZED_WIRE_34 <= 0;
	end
else
	begin
	SYNTHESIZED_WIRE_34 <= SYNTHESIZED_WIRE_28;
	end
end


endmodule
