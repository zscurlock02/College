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
// CREATED		"Thu Sep  8 09:36:34 2022"

module lab2step2(
	Wolf,
	Goat,
	Cabbage,
	ALARM
);


input wire	Wolf;
input wire	Goat;
input wire	Cabbage;
output wire	ALARM;

wire	SYNTHESIZED_WIRE_15;
wire	SYNTHESIZED_WIRE_16;
wire	SYNTHESIZED_WIRE_17;
wire	SYNTHESIZED_WIRE_9;
wire	SYNTHESIZED_WIRE_10;
wire	SYNTHESIZED_WIRE_11;
wire	SYNTHESIZED_WIRE_12;
wire	SYNTHESIZED_WIRE_13;
wire	SYNTHESIZED_WIRE_14;




assign	SYNTHESIZED_WIRE_12 = Cabbage & SYNTHESIZED_WIRE_15 & SYNTHESIZED_WIRE_16;

assign	SYNTHESIZED_WIRE_17 =  ~Cabbage;

assign	SYNTHESIZED_WIRE_15 =  ~Goat;

assign	SYNTHESIZED_WIRE_16 =  ~Wolf;

assign	SYNTHESIZED_WIRE_14 = Cabbage & Goat & Wolf;

assign	SYNTHESIZED_WIRE_13 = Cabbage & Goat & SYNTHESIZED_WIRE_16;

assign	SYNTHESIZED_WIRE_11 = SYNTHESIZED_WIRE_17 & SYNTHESIZED_WIRE_15 & Wolf;

assign	SYNTHESIZED_WIRE_9 = SYNTHESIZED_WIRE_17 & SYNTHESIZED_WIRE_15 & SYNTHESIZED_WIRE_16;

assign	SYNTHESIZED_WIRE_10 = SYNTHESIZED_WIRE_17 & Goat & Wolf;

assign	ALARM = SYNTHESIZED_WIRE_9 | SYNTHESIZED_WIRE_10 | SYNTHESIZED_WIRE_11 | SYNTHESIZED_WIRE_12 | SYNTHESIZED_WIRE_13 | SYNTHESIZED_WIRE_14;


endmodule
