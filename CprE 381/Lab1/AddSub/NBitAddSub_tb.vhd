library IEEE;
use IEEE.std_logic_1164.all;

entity NBitAddSub_tb is
end NBitAddSub_tb;

architecture testbench of NBitAddSub_tb is

	signal i_A_tb	: std_logic_vector(7 downto 0) := (others => '0');
	signal i_B_tb	: std_logic_vector(7 downto 0) := (others => '0');
	signal nAdd_Sub_tb	: std_logic := '0';
	signal o_F_tb	: std_logic_vector(7 downto 0);

	component NBitAddSub
		generic(N : integer := 16);
		port(i_A	: in std_logic_vector(N-1 downto 0);
		     i_B	: in std_logic_vector(N-1 downto 0);
		     nAdd_Sub	: in std_logic;
		     o_F	: out std_logic_vector(N-1 downto 0));
	end component;

	begin
		DUT0: NBitAddSub
			generic map(N => 8)
			port map(i_A => i_A_tb,
				 i_B => i_B_tb,
				 nAdd_Sub => nAdd_Sub_tb,
				 o_F => o_F_tb);

		NBitAddSub_proc: process
		begin

		--Test 1--
		i_A_tb <= "10101010";
		i_B_tb <= "01010101";
		wait for 100 ns;

		--Test 2--
		i_A_tb <= x"AC";
		i_B_tb <= x"10";
		wait for 100 ns;

		--Test 3--
		i_A_tb <= "00110111";
		i_B_tb <= "11111111";
		nAdd_Sub_tb <= '1';
		wait for 100 ns;

		--Test 4--
		i_A_tb <= x"A6";
		i_B_tb <= x"09";
		wait for 100 ns;

	wait;
	end process;
end testbench;