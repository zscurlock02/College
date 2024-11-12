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
// CREATED		"Thu Oct 27 08:39:07 2022"

module lab8step2(
	x3,
	x2,
	x1,
	x0,
	xc1,
	xc2,
	xc3,
	S,
	F
);


input wire	x3;
input wire	x2;
input wire	x1;
input wire	x0;
input wire	xc1;
input wire	xc2;
input wire	xc3;
input wire	[1:0] S;
output wire	[3:0] F;

wire	[3:0] F_ALTERA_SYNTHESIZED;





mux4to1	b2v_inst(
	.w0(x3),
	.w1(x2),
	.w2(x1),
	.w3(x0),
	.s(S),
	.f(F_ALTERA_SYNTHESIZED[3]));


mux4to1	b2v_inst1(
	.w0(x2),
	.w1(x1),
	.w2(x0),
	.w3(xc1),
	.s(S),
	.f(F_ALTERA_SYNTHESIZED[2]));


mux4to1	b2v_inst2(
	.w0(x1),
	.w1(x0),
	.w2(xc1),
	.w3(xc2),
	.s(S),
	.f(F_ALTERA_SYNTHESIZED[1]));


mux4to1	b2v_inst3(
	.w0(x0),
	.w1(xc1),
	.w2(xc2),
	.w3(xc3),
	.s(S),
	.f(F_ALTERA_SYNTHESIZED[0]));

assign	F = F_ALTERA_SYNTHESIZED;

endmodule
