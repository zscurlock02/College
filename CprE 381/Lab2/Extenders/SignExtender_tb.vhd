library IEEE;
use IEEE.std_logic_1164.all;

entity SignExtender_tb is
end SignExtender_tb;

architecture testbench of SignExtender_tb is
	
	signal input_tb : std_logic_vector(15 downto 0);
	signal output_tb : std_logic_vector(31 downto 0);

	component SignExtender
		port(input : in std_logic_vector(15 downto 0);
	     	     output : out std_logic_vector(31 downto 0));
	end component;

	begin
		DUT0: SignExtender
		port map(input => input_tb,
			 output => output_tb);

		SignExtender_proc: process
		begin
		
			input_tb <= x"0BCD";
			wait for 100 ns;

			input_tb <= x"8189";
			wait for 100 ns;

	wait;
	end process;
end testbench;