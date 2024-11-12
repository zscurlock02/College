library IEEE;
use IEEE.std_logic_1164.all;

entity NBitRippleCarryAdder_tb is
end NBitRippleCarryAdder_tb;

architecture testbench of NBitRippleCarryAdder_tb is
	
	
	signal i_A_tb : std_logic_vector(31 downto 0) := (others => '0');
	signal i_B_tb : std_logic_vector(31 downto 0) := (others => '0');
	signal i_Cin_tb : std_logic := '0';
	signal o_Sum_tb : std_logic_vector(31 downto 0);
	signal o_Cout_tb : std_logic;


	component NBitRippleCarryAdder
		generic(N : integer := 16);
		port(i_A : in std_logic_vector(N-1 downto 0);
		     i_B : in std_logic_vector(N-1 downto 0);
		     i_Cin : in std_logic;
		     o_Sum : out std_logic_vector(N-1 downto 0);
		     o_Cout : out std_logic);
	end component;

	begin
		DUT0: NBitRippleCarryAdder
			generic map(N => 32)
			port map(i_A => i_A_tb,
				 i_B => i_B_tb,
				 i_Cin => i_Cin_tb,
				 o_Sum => o_Sum_tb,
				 o_Cout => o_Cout_tb);

		NBitRippleCarryAdder_proc: process
		begin

	-- Test 1 --

	i_A_tb <= "10101010101010101010101010101010";
	i_B_tb <= "01010101010101010101010101010101";
	i_Cin_tb <= '0';
	wait for 100 ns;

	-- Test 2 --

	i_A_tb <= "11101110111011101110111011101110";
	i_B_tb <= "01010101010101010101010101010101";
	i_Cin_tb <= '1';
	wait for 100 ns;

	-- Test 3 --

	i_A_tb <= "11111111111111111111111111111111";
	i_B_tb <= "00000000000000000000000000000010";
	i_Cin_tb <= '0';
	wait for 100 ns;

	wait;
	end process;
end testbench;

	
		 	  

