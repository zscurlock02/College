library IEEE;
use IEEE.std_logic_1164.all;

entity decoder5x32_tb is
end decoder5x32_tb;

architecture testbench of decoder5x32_tb is

	--Signals for TB
	signal input_tb : std_logic_vector(4 downto 0);
	signal enable_tb : std_logic;
	signal output_tb : std_logic_Vector(31 downto 0);

	component Decoder5to32
		port (input 	: in std_logic_vector(4 downto 0);
		      enable	: in std_logic;
		      output 	: out std_logic_vector(31 downto 0));
	end component;

begin
	DUT0: Decoder5to32
		port map(input 	=> input_tb,
			 enable => enable_tb,
			 output => output_tb);

	Decoder5to32_proc: process
	begin
		--Test case 1
		enable_tb <= '1';
		input_tb <= "00000";
		wait for 100 ns;

		--Test case 2
		input_tb <= "11111";
		wait for 100 ns;

		--Test case 3
		input_tb <= "00001";
		wait for 100 ns;

		--Test case 4
		input_tb <= "01100";
		wait for 100 ns;

		--Test case 5
	 	enable_tb <= '0';
		wait for 100 ns;

	wait;
	end process;
end testbench;
