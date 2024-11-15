library IEEE;
use IEEE.std_logic_1164.all;

entity ZeroExtender_tb is
end ZeroExtender_tb;

architecture testbench of ZeroExtender_tb is
	
	signal input_tb : std_logic_vector(15 downto 0);
	signal output_tb : std_logic_vector(31 downto 0);

	component ZeroExtender
		port(input : in std_logic_vector(15 downto 0);
	     	     output : out std_logic_vector(31 downto 0));
	end component;

	begin
		DUT0: ZeroExtender
		port map(input => input_tb,
			 output => output_tb);

		ZeroExtender_proc: process
		begin
		
			input_tb <= x"FFFF";
			wait for 100 ns;

			input_tb <= x"0000";
			wait for 100 ns;

	wait;
	end process;
end testbench;