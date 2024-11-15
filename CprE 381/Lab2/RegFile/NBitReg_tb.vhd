library IEEE;
use IEEE.std_logic_1164.all;

entity NBitReg_tb is 
	generic(gCLK_HPER	: time := 50ns);
end NBitReg_tb;

architecture structural of NBitReg_tb is
	
	constant cCLK_PER	: time := gCLK_HPER * 2;

	signal s_Clk_tb		: std_logic;
	signal s_Reset_tb	: std_logic := '0';
	signal s_Write_tb	: std_logic := '0';
	signal s_WData_tb		: std_logic_vector(31 downto 0) := (others => '0');
	signal s_ReadData_tb		: std_logic_vector(31 downto 0) := (others => '1');

	component NBitReg is
		generic(N : integer := 32);
		port(i_Clk	: in std_logic;
		     i_Reset	: in std_logic;
		     i_Write	: in std_logic;
		     i_WData	: in std_logic_vector(N-1 downto 0);
		     o_ReadData	: out std_logic_vector(N-1 downto 0));
	end component;

begin

	DUT0: NBitReg
	port map(i_Clk		=> s_Clk_tb,
		 i_Reset	=> s_Reset_tb,
		 i_Write	=> s_Write_tb,
		 i_WData	=> s_WData_tb,
		 o_ReadData	=> s_ReadData_tb); 

CLK_proc: process
begin

	s_Clk_tb <= '0';
	wait for gCLK_HPER;
	s_Clk_tb <= '1';
	wait for gCLK_HPER;

end process;

TB_proc: process
begin

	wait for 40 ns;
	s_Write_tb <= '1';
	wait for 10 ns;

	wait for 140 ns;
	s_WData_tb <= x"0A456FEB";
	s_Write_tb <= '0';
	wait for 10 ns;

	wait for 190 ns;
	s_Write_tb <= '1';
	wait for 10 ns;

	wait for 240 ns;
	s_Reset_tb <= '1';
	wait for 20 ns;
	s_Reset_tb <= '0';
	wait for 40 ns;

	wait;
end process;
end structural;