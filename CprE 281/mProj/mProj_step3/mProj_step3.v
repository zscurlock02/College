// Copyright (C) 2022  Intel Corporation. All rights reserved.
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
// VERSION		"Version 21.1.1 Build 850 06/23/2022 SJ Standard Edition"
// CREATED		"Thu Oct  6 08:58:28 2022"

module mProj_step3(
	W,
	X,
	Y,
	Z,
	B
);


input wire	W;
input wire	X;
input wire	Y;
input wire	Z;
output wire	B;

wire	SYNTHESIZED_WIRE_12;
wire	SYNTHESIZED_WIRE_13;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_7;
wire	SYNTHESIZED_WIRE_8;
wire	SYNTHESIZED_WIRE_9;
wire	SYNTHESIZED_WIRE_10;




assign	SYNTHESIZED_WIRE_6 = SYNTHESIZED_WIRE_12 & SYNTHESIZED_WIRE_13 & Y & Z;

assign	SYNTHESIZED_WIRE_10 = SYNTHESIZED_WIRE_12 | SYNTHESIZED_WIRE_3 | SYNTHESIZED_WIRE_4 | SYNTHESIZED_WIRE_13;

assign	SYNTHESIZED_WIRE_9 = SYNTHESIZED_WIRE_6 | SYNTHESIZED_WIRE_7 | SYNTHESIZED_WIRE_8;


mProj	b2v_E(
	.W(W),
	.X(X),
	.Y(Y),
	.Z(Z),
	.B(SYNTHESIZED_WIRE_8));

assign	SYNTHESIZED_WIRE_12 =  ~W;

assign	SYNTHESIZED_WIRE_13 =  ~X;

assign	SYNTHESIZED_WIRE_3 =  ~Y;

assign	SYNTHESIZED_WIRE_4 =  ~Z;

assign	B = SYNTHESIZED_WIRE_9 & SYNTHESIZED_WIRE_10;

assign	SYNTHESIZED_WIRE_7 = SYNTHESIZED_WIRE_12 & X & Y & Z;


endmodule
