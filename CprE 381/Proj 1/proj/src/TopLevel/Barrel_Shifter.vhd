library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Barrel_Shifter is 

	port(input	: in std_logic_vector(31 downto 0);
	     sType	: in std_logic_vector(1 downto 0);
	     shamt	: in std_logic_vector(4 downto 0);
	     output	: out std_logic_vector(31 downto 0));

end Barrel_Shifter;

architecture dataflow of Barrel_Shifter is

signal shift1	: std_logic_vector(31 downto 0);
signal shift2	: std_logic_vector(31 downto 0);
signal shift3	: std_logic_vector(31 downto 0);
signal shift4	: std_logic_vector(31 downto 0);
signal shift5	: std_logic_vector(31 downto 0);

signal out_shift1 : std_logic_vector(31 downto 0);
signal out_shift2 : std_logic_vector(31 downto 0);
signal out_shift3 : std_logic_vector(31 downto 0);
signal out_shift4 : std_logic_vector(31 downto 0);

begin
	
	shift1 <= input when sType = "00" else
		input(30 downto 0) & '0' when sType = "01" else
		'0' & input(31 downto 1) when sType = "10" else
		'0' & input(31 downto 1) when sType = "11" and input(31) = '0' else
		'1' & input(31 downto 1) when sType = "11" and input(31) = '1';
	out_shift1 <= shift1 when shamt(0) = '1' else input;

	shift2 <= out_shift1 when sType = "00" else
		out_shift1(29 downto 0) & "00" when sType = "01" else
		"00" & out_shift1(31 downto 2) when sType = "10" else
		"00" & out_shift1(31 downto 2) when sType = "11" and out_shift1(31) = '0' else
		"11" & out_shift1(31 downto 2) when sType = "11" and out_shift1(31) = '1';
	out_shift2 <= shift2 when shamt(1) = '1' else out_shift1;

	shift3 <= out_shift2 when sType = "00" else
		out_shift2(27 downto 0) & "0000" when sType = "01" else
		"0000" & out_shift2(31 downto 4) when sType = "10" else
		"0000" & out_shift2(31 downto 4) when sType = "11" and out_shift2(31) = '0' else
		"1111" & out_shift2(31 downto 4) when sType = "11" and out_shift2(31) = '1';
	out_shift3 <= shift3 when shamt(2) = '1' else out_shift2;

	shift4 <= out_shift3 when sType = "00" else
		out_shift3(23 downto 0) & "00000000" when sType = "01" else
		"00000000" & out_shift3(31 downto 8) when sType = "10" else
		"00000000" & out_shift3(31 downto 8) when sType = "11" and out_shift3(31) = '0' else
		"11111111" & out_shift3(31 downto 8) when sType = "11" and out_shift3(31) = '1';
	out_shift4 <= shift4 when shamt(3) = '1' else out_shift3;

	shift5 <= out_shift4 when sType = "00" else
		out_shift4(15 downto 0) & "0000000000000000" when sType = "01" else
		"0000000000000000" & out_shift4(31 downto 16) when sType = "10" else
		"0000000000000000" & out_shift4(31 downto 16) when sType = "11" and out_shift4(31) = '0' else
		"1111111111111111" & out_shift4(31 downto 16) when sType = "11" and out_shift4(31) = '1';
	output <= shift5 when shamt(4) = '1' else out_shift4;
	
	

end dataflow;