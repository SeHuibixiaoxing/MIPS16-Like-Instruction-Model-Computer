-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 13.1.0 Build 162 10/23/2013 SJ Full Version"

-- DATE "04/06/2021 10:55:34"

-- 
-- Device: Altera EP4CE6E22C8 Package TQFP144
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	ex03 IS
    PORT (
	A : IN std_logic_vector(15 DOWNTO 0);
	B : OUT std_logic_vector(15 DOWNTO 0)
	);
END ex03;

-- Design Ports Information
-- B[0]	=>  Location: PIN_42,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[1]	=>  Location: PIN_58,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[2]	=>  Location: PIN_126,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[3]	=>  Location: PIN_128,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[4]	=>  Location: PIN_52,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[5]	=>  Location: PIN_141,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[6]	=>  Location: PIN_51,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[7]	=>  Location: PIN_30,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[8]	=>  Location: PIN_112,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[9]	=>  Location: PIN_120,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[10]	=>  Location: PIN_64,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[11]	=>  Location: PIN_127,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[12]	=>  Location: PIN_31,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[13]	=>  Location: PIN_28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[14]	=>  Location: PIN_33,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[15]	=>  Location: PIN_46,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[0]	=>  Location: PIN_43,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[1]	=>  Location: PIN_106,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[15]	=>  Location: PIN_69,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[2]	=>  Location: PIN_119,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[3]	=>  Location: PIN_124,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[4]	=>  Location: PIN_129,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[5]	=>  Location: PIN_135,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[6]	=>  Location: PIN_125,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[7]	=>  Location: PIN_67,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[8]	=>  Location: PIN_72,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[9]	=>  Location: PIN_83,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[10]	=>  Location: PIN_60,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[11]	=>  Location: PIN_65,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[12]	=>  Location: PIN_68,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[13]	=>  Location: PIN_50,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[14]	=>  Location: PIN_66,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF ex03 IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_A : std_logic_vector(15 DOWNTO 0);
SIGNAL ww_B : std_logic_vector(15 DOWNTO 0);
SIGNAL \B[0]~output_o\ : std_logic;
SIGNAL \B[1]~output_o\ : std_logic;
SIGNAL \B[2]~output_o\ : std_logic;
SIGNAL \B[3]~output_o\ : std_logic;
SIGNAL \B[4]~output_o\ : std_logic;
SIGNAL \B[5]~output_o\ : std_logic;
SIGNAL \B[6]~output_o\ : std_logic;
SIGNAL \B[7]~output_o\ : std_logic;
SIGNAL \B[8]~output_o\ : std_logic;
SIGNAL \B[9]~output_o\ : std_logic;
SIGNAL \B[10]~output_o\ : std_logic;
SIGNAL \B[11]~output_o\ : std_logic;
SIGNAL \B[12]~output_o\ : std_logic;
SIGNAL \B[13]~output_o\ : std_logic;
SIGNAL \B[14]~output_o\ : std_logic;
SIGNAL \B[15]~output_o\ : std_logic;
SIGNAL \A[0]~input_o\ : std_logic;
SIGNAL \A[15]~input_o\ : std_logic;
SIGNAL \A[1]~input_o\ : std_logic;
SIGNAL \A[2]~input_o\ : std_logic;
SIGNAL \A[3]~input_o\ : std_logic;
SIGNAL \complement|B~0_combout\ : std_logic;
SIGNAL \A[4]~input_o\ : std_logic;
SIGNAL \complement|C[5]~0_combout\ : std_logic;
SIGNAL \A[5]~input_o\ : std_logic;
SIGNAL \A[6]~input_o\ : std_logic;
SIGNAL \complement|B~1_combout\ : std_logic;
SIGNAL \complement|C[9]~1_combout\ : std_logic;
SIGNAL \A[7]~input_o\ : std_logic;
SIGNAL \A[8]~input_o\ : std_logic;
SIGNAL \complement|B~2_combout\ : std_logic;
SIGNAL \A[9]~input_o\ : std_logic;
SIGNAL \complement|B~3_combout\ : std_logic;
SIGNAL \A[10]~input_o\ : std_logic;
SIGNAL \A[11]~input_o\ : std_logic;
SIGNAL \complement|B~4_combout\ : std_logic;
SIGNAL \A[12]~input_o\ : std_logic;
SIGNAL \A[13]~input_o\ : std_logic;
SIGNAL \A[14]~input_o\ : std_logic;
SIGNAL \complement|C\ : std_logic_vector(16 DOWNTO 0);
SIGNAL \complement|B\ : std_logic_vector(15 DOWNTO 0);

BEGIN

ww_A <= A;
B <= ww_B;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

-- Location: IOOBUF_X3_Y0_N2
\B[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \A[0]~input_o\,
	devoe => ww_devoe,
	o => \B[0]~output_o\);

-- Location: IOOBUF_X21_Y0_N9
\B[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \complement|B\(1),
	devoe => ww_devoe,
	o => \B[1]~output_o\);

-- Location: IOOBUF_X16_Y24_N2
\B[2]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \complement|B\(2),
	devoe => ww_devoe,
	o => \B[2]~output_o\);

-- Location: IOOBUF_X16_Y24_N16
\B[3]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \complement|B\(3),
	devoe => ww_devoe,
	o => \B[3]~output_o\);

-- Location: IOOBUF_X16_Y0_N9
\B[4]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \complement|B\(4),
	devoe => ww_devoe,
	o => \B[4]~output_o\);

-- Location: IOOBUF_X5_Y24_N9
\B[5]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \complement|B\(5),
	devoe => ww_devoe,
	o => \B[5]~output_o\);

-- Location: IOOBUF_X16_Y0_N23
\B[6]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \complement|B\(6),
	devoe => ww_devoe,
	o => \B[6]~output_o\);

-- Location: IOOBUF_X0_Y8_N16
\B[7]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \complement|B\(7),
	devoe => ww_devoe,
	o => \B[7]~output_o\);

-- Location: IOOBUF_X28_Y24_N2
\B[8]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \complement|B\(8),
	devoe => ww_devoe,
	o => \B[8]~output_o\);

-- Location: IOOBUF_X23_Y24_N9
\B[9]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \complement|B\(9),
	devoe => ww_devoe,
	o => \B[9]~output_o\);

-- Location: IOOBUF_X25_Y0_N2
\B[10]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \complement|B\(10),
	devoe => ww_devoe,
	o => \B[10]~output_o\);

-- Location: IOOBUF_X16_Y24_N9
\B[11]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \complement|B\(11),
	devoe => ww_devoe,
	o => \B[11]~output_o\);

-- Location: IOOBUF_X0_Y7_N2
\B[12]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \complement|B\(12),
	devoe => ww_devoe,
	o => \B[12]~output_o\);

-- Location: IOOBUF_X0_Y9_N9
\B[13]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \complement|B\(13),
	devoe => ww_devoe,
	o => \B[13]~output_o\);

-- Location: IOOBUF_X0_Y6_N23
\B[14]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \complement|B\(14),
	devoe => ww_devoe,
	o => \B[14]~output_o\);

-- Location: IOOBUF_X7_Y0_N2
\B[15]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \A[15]~input_o\,
	devoe => ww_devoe,
	o => \B[15]~output_o\);

-- Location: IOIBUF_X5_Y0_N22
\A[0]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(0),
	o => \A[0]~input_o\);

-- Location: IOIBUF_X30_Y0_N1
\A[15]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(15),
	o => \A[15]~input_o\);

-- Location: IOIBUF_X34_Y20_N8
\A[1]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(1),
	o => \A[1]~input_o\);

-- Location: LCCOMB_X19_Y16_N16
\complement|B[1]\ : cycloneive_lcell_comb
-- Equation(s):
-- \complement|B\(1) = \A[1]~input_o\ $ (((\A[15]~input_o\ & \A[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111011110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[15]~input_o\,
	datab => \A[0]~input_o\,
	datad => \A[1]~input_o\,
	combout => \complement|B\(1));

-- Location: IOIBUF_X23_Y24_N1
\A[2]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(2),
	o => \A[2]~input_o\);

-- Location: LCCOMB_X19_Y16_N26
\complement|B[2]\ : cycloneive_lcell_comb
-- Equation(s):
-- \complement|B\(2) = \A[2]~input_o\ $ (((\A[15]~input_o\ & ((\A[0]~input_o\) # (\A[1]~input_o\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[15]~input_o\,
	datab => \A[0]~input_o\,
	datac => \A[2]~input_o\,
	datad => \A[1]~input_o\,
	combout => \complement|B\(2));

-- Location: IOIBUF_X18_Y24_N15
\A[3]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(3),
	o => \A[3]~input_o\);

-- Location: LCCOMB_X19_Y16_N12
\complement|B~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \complement|B~0_combout\ = (\A[15]~input_o\ & ((\A[0]~input_o\) # ((\A[2]~input_o\) # (\A[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101010101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[15]~input_o\,
	datab => \A[0]~input_o\,
	datac => \A[2]~input_o\,
	datad => \A[1]~input_o\,
	combout => \complement|B~0_combout\);

-- Location: LCCOMB_X19_Y16_N22
\complement|B[3]\ : cycloneive_lcell_comb
-- Equation(s):
-- \complement|B\(3) = \A[3]~input_o\ $ (\complement|B~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[3]~input_o\,
	datad => \complement|B~0_combout\,
	combout => \complement|B\(3));

-- Location: IOIBUF_X16_Y24_N22
\A[4]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(4),
	o => \A[4]~input_o\);

-- Location: LCCOMB_X19_Y16_N24
\complement|C[5]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \complement|C[5]~0_combout\ = (!\A[3]~input_o\ & (!\A[0]~input_o\ & (!\A[2]~input_o\ & !\A[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[3]~input_o\,
	datab => \A[0]~input_o\,
	datac => \A[2]~input_o\,
	datad => \A[1]~input_o\,
	combout => \complement|C[5]~0_combout\);

-- Location: LCCOMB_X19_Y16_N2
\complement|B[4]\ : cycloneive_lcell_comb
-- Equation(s):
-- \complement|B\(4) = \A[4]~input_o\ $ (((!\complement|C[5]~0_combout\ & \A[15]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001100110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[4]~input_o\,
	datab => \complement|C[5]~0_combout\,
	datad => \A[15]~input_o\,
	combout => \complement|B\(4));

-- Location: IOIBUF_X11_Y24_N15
\A[5]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(5),
	o => \A[5]~input_o\);

-- Location: LCCOMB_X19_Y16_N28
\complement|B[5]\ : cycloneive_lcell_comb
-- Equation(s):
-- \complement|B\(5) = \A[5]~input_o\ $ (((\A[15]~input_o\ & ((\A[4]~input_o\) # (!\complement|C[5]~0_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100101111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[4]~input_o\,
	datab => \complement|C[5]~0_combout\,
	datac => \A[5]~input_o\,
	datad => \A[15]~input_o\,
	combout => \complement|B\(5));

-- Location: IOIBUF_X18_Y24_N22
\A[6]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(6),
	o => \A[6]~input_o\);

-- Location: LCCOMB_X19_Y16_N6
\complement|B~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \complement|B~1_combout\ = (\A[15]~input_o\ & ((\A[4]~input_o\) # ((\A[5]~input_o\) # (!\complement|C[5]~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[4]~input_o\,
	datab => \complement|C[5]~0_combout\,
	datac => \A[5]~input_o\,
	datad => \A[15]~input_o\,
	combout => \complement|B~1_combout\);

-- Location: LCCOMB_X19_Y16_N0
\complement|B[6]\ : cycloneive_lcell_comb
-- Equation(s):
-- \complement|B\(6) = \A[6]~input_o\ $ (\complement|B~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \A[6]~input_o\,
	datad => \complement|B~1_combout\,
	combout => \complement|B\(6));

-- Location: LCCOMB_X19_Y16_N10
\complement|C[9]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \complement|C[9]~1_combout\ = (!\A[4]~input_o\ & (!\A[6]~input_o\ & (!\A[5]~input_o\ & \complement|C[5]~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[4]~input_o\,
	datab => \A[6]~input_o\,
	datac => \A[5]~input_o\,
	datad => \complement|C[5]~0_combout\,
	combout => \complement|C[9]~1_combout\);

-- Location: IOIBUF_X30_Y0_N22
\A[7]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(7),
	o => \A[7]~input_o\);

-- Location: LCCOMB_X26_Y9_N8
\complement|B[7]\ : cycloneive_lcell_comb
-- Equation(s):
-- \complement|B\(7) = \A[7]~input_o\ $ (((!\complement|C[9]~1_combout\ & \A[15]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101101000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \complement|C[9]~1_combout\,
	datab => \A[15]~input_o\,
	datad => \A[7]~input_o\,
	combout => \complement|B\(7));

-- Location: IOIBUF_X32_Y0_N8
\A[8]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(8),
	o => \A[8]~input_o\);

-- Location: LCCOMB_X26_Y9_N2
\complement|B[8]\ : cycloneive_lcell_comb
-- Equation(s):
-- \complement|B\(8) = \A[8]~input_o\ $ (((\A[15]~input_o\ & ((\A[7]~input_o\) # (!\complement|C[9]~1_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110010110100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \complement|C[9]~1_combout\,
	datab => \A[15]~input_o\,
	datac => \A[8]~input_o\,
	datad => \A[7]~input_o\,
	combout => \complement|B\(8));

-- Location: LCCOMB_X26_Y9_N12
\complement|B~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \complement|B~2_combout\ = (\A[15]~input_o\ & (((\A[8]~input_o\) # (\A[7]~input_o\)) # (!\complement|C[9]~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \complement|C[9]~1_combout\,
	datab => \A[15]~input_o\,
	datac => \A[8]~input_o\,
	datad => \A[7]~input_o\,
	combout => \complement|B~2_combout\);

-- Location: IOIBUF_X34_Y9_N22
\A[9]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(9),
	o => \A[9]~input_o\);

-- Location: LCCOMB_X26_Y9_N14
\complement|B[9]\ : cycloneive_lcell_comb
-- Equation(s):
-- \complement|B\(9) = \complement|B~2_combout\ $ (\A[9]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \complement|B~2_combout\,
	datad => \A[9]~input_o\,
	combout => \complement|B\(9));

-- Location: LCCOMB_X26_Y9_N24
\complement|B~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \complement|B~3_combout\ = (\complement|C[9]~1_combout\ & (!\A[7]~input_o\ & (!\A[8]~input_o\ & !\A[9]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \complement|C[9]~1_combout\,
	datab => \A[7]~input_o\,
	datac => \A[8]~input_o\,
	datad => \A[9]~input_o\,
	combout => \complement|B~3_combout\);

-- Location: IOIBUF_X23_Y0_N8
\A[10]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(10),
	o => \A[10]~input_o\);

-- Location: LCCOMB_X26_Y9_N18
\complement|B[10]\ : cycloneive_lcell_comb
-- Equation(s):
-- \complement|B\(10) = \A[10]~input_o\ $ (((!\complement|B~3_combout\ & \A[15]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \complement|B~3_combout\,
	datac => \A[10]~input_o\,
	datad => \A[15]~input_o\,
	combout => \complement|B\(10));

-- Location: IOIBUF_X28_Y0_N22
\A[11]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(11),
	o => \A[11]~input_o\);

-- Location: LCCOMB_X26_Y9_N28
\complement|B[11]\ : cycloneive_lcell_comb
-- Equation(s):
-- \complement|B\(11) = \A[11]~input_o\ $ (((\A[15]~input_o\ & ((\A[10]~input_o\) # (!\complement|B~3_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100101111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[10]~input_o\,
	datab => \complement|B~3_combout\,
	datac => \A[11]~input_o\,
	datad => \A[15]~input_o\,
	combout => \complement|B\(11));

-- Location: LCCOMB_X26_Y9_N6
\complement|B~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \complement|B~4_combout\ = (\A[15]~input_o\ & ((\A[10]~input_o\) # ((\A[11]~input_o\) # (!\complement|B~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[10]~input_o\,
	datab => \complement|B~3_combout\,
	datac => \A[11]~input_o\,
	datad => \A[15]~input_o\,
	combout => \complement|B~4_combout\);

-- Location: IOIBUF_X30_Y0_N8
\A[12]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(12),
	o => \A[12]~input_o\);

-- Location: LCCOMB_X26_Y9_N0
\complement|B[12]\ : cycloneive_lcell_comb
-- Equation(s):
-- \complement|B\(12) = \complement|B~4_combout\ $ (\A[12]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \complement|B~4_combout\,
	datad => \A[12]~input_o\,
	combout => \complement|B\(12));

-- Location: LCCOMB_X26_Y9_N10
\complement|C[13]\ : cycloneive_lcell_comb
-- Equation(s):
-- \complement|C\(13) = (\A[12]~input_o\) # (((\A[11]~input_o\) # (\A[10]~input_o\)) # (!\complement|B~3_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[12]~input_o\,
	datab => \complement|B~3_combout\,
	datac => \A[11]~input_o\,
	datad => \A[10]~input_o\,
	combout => \complement|C\(13));

-- Location: IOIBUF_X13_Y0_N1
\A[13]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(13),
	o => \A[13]~input_o\);

-- Location: LCCOMB_X26_Y9_N20
\complement|B[13]\ : cycloneive_lcell_comb
-- Equation(s):
-- \complement|B\(13) = \A[13]~input_o\ $ (((\complement|C\(13) & \A[15]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \complement|C\(13),
	datac => \A[13]~input_o\,
	datad => \A[15]~input_o\,
	combout => \complement|B\(13));

-- Location: IOIBUF_X28_Y0_N1
\A[14]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(14),
	o => \A[14]~input_o\);

-- Location: LCCOMB_X26_Y9_N22
\complement|B[14]\ : cycloneive_lcell_comb
-- Equation(s):
-- \complement|B\(14) = \A[14]~input_o\ $ (((\A[15]~input_o\ & ((\complement|C\(13)) # (\A[13]~input_o\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011011011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \complement|C\(13),
	datab => \A[14]~input_o\,
	datac => \A[13]~input_o\,
	datad => \A[15]~input_o\,
	combout => \complement|B\(14));

ww_B(0) <= \B[0]~output_o\;

ww_B(1) <= \B[1]~output_o\;

ww_B(2) <= \B[2]~output_o\;

ww_B(3) <= \B[3]~output_o\;

ww_B(4) <= \B[4]~output_o\;

ww_B(5) <= \B[5]~output_o\;

ww_B(6) <= \B[6]~output_o\;

ww_B(7) <= \B[7]~output_o\;

ww_B(8) <= \B[8]~output_o\;

ww_B(9) <= \B[9]~output_o\;

ww_B(10) <= \B[10]~output_o\;

ww_B(11) <= \B[11]~output_o\;

ww_B(12) <= \B[12]~output_o\;

ww_B(13) <= \B[13]~output_o\;

ww_B(14) <= \B[14]~output_o\;

ww_B(15) <= \B[15]~output_o\;
END structure;


