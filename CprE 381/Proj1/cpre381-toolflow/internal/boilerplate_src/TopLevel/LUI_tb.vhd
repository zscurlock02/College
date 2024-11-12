library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity LUI_tb is
end LUI_tb;

architecture testbench of LUI_tb is
    signal A_tb : std_logic_vector(31 downto 0);
    signal output_tb : std_logic_vector(31 downto 0);

	component LUI
		port(A : in std_logic_vector(31 downto 0);
	     	     output : out std_logic_vector(31 downto 0));
	end component;

begin
	DUT0: LUI
	port map(A => A_tb,
		 output => output_tb);

	process
	begin
		--Test case 1
		A_tb <= x"0000ABCD";
		wait for 100 ns;

		--Test case 2
		A_tb <= x"FFFF0000";
		wait for 100 ns;

		wait;
	end process;
end testbench;