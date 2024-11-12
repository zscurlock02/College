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
// CREATED		"Thu Nov 10 08:03:31 2022"

module lab10step1(
	IN,
	CLK,
	Q1,
	Q2,
	Q3,
	Q4
);


input wire	IN;
input wire	CLK;
output wire	Q1;
output wire	Q2;
output wire	Q3;
output reg	Q4;

wire	SYNTHESIZED_WIRE_8;
reg	DFF_inst;
reg	DFF_inst1;
reg	DFF_inst2;

assign	Q1 = DFF_inst;
assign	Q2 = DFF_inst1;
assign	Q3 = DFF_inst2;
assign	SYNTHESIZED_WIRE_8 = 1;




always@(posedge CLK or negedge SYNTHESIZED_WIRE_8 or negedge SYNTHESIZED_WIRE_8)
begin
if (!SYNTHESIZED_WIRE_8)
	begin
	DFF_inst <= 0;
	end
else
if (!SYNTHESIZED_WIRE_8)
	begin
	DFF_inst <= 1;
	end
else
	begin
	DFF_inst <= IN;
	end
end


always@(posedge CLK or negedge SYNTHESIZED_WIRE_8 or negedge SYNTHESIZED_WIRE_8)
begin
if (!SYNTHESIZED_WIRE_8)
	begin
	DFF_inst1 <= 0;
	end
else
if (!SYNTHESIZED_WIRE_8)
	begin
	DFF_inst1 <= 1;
	end
else
	begin
	DFF_inst1 <= DFF_inst;
	end
end


always@(posedge CLK or negedge SYNTHESIZED_WIRE_8 or negedge SYNTHESIZED_WIRE_8)
begin
if (!SYNTHESIZED_WIRE_8)
	begin
	DFF_inst2 <= 0;
	end
else
if (!SYNTHESIZED_WIRE_8)
	begin
	DFF_inst2 <= 1;
	end
else
	begin
	DFF_inst2 <= DFF_inst1;
	end
end


always@(posedge CLK or negedge SYNTHESIZED_WIRE_8 or negedge SYNTHESIZED_WIRE_8)
begin
if (!SYNTHESIZED_WIRE_8)
	begin
	Q4 <= 0;
	end
else
if (!SYNTHESIZED_WIRE_8)
	begin
	Q4 <= 1;
	end
else
	begin
	Q4 <= DFF_inst2;
	end
end



endmodule
