library IEEE;
use IEEE.std_logic_1164.all;

entity NBitReg is
	
	generic(N	: integer := 16);

	port(i_Clk	: in std_logic;
	     i_Reset	: in std_logic;
	     i_Write	: in std_logic;
	     i_WData	: in std_logic_vector(N-1 downto 0);
	     o_ReadData	: out std_logic_vector(N-1 downto 0));

end NBitReg;

architecture structural of NBitReg is 
	
	component dffg is
		port(i_CLK	: in std_logic;
		     i_RST	: in std_logic;
		     i_WE	: in std_logic;
		     i_D	: in std_logic;
		     o_Q	: out std_logic);
	end component;

	--Signals?--

	begin
		NBitReg: for i in 0 to N-1 generate
			dff: dffg port map(i_CLK	=> i_Clk,
					   i_RST 	=> i_Reset,
					   i_WE		=> i_Write,
					   i_D		=> i_WData(i),
					   o_Q		=> o_ReadData(i));
		end generate NBitReg;
		
end structural;