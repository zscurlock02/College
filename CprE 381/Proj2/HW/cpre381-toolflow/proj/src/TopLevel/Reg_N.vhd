library IEEE;
use IEEE.std_logic_1164.all;

entity Reg_N is
	generic(N : integer := 32);
	port(write_data 	: in std_logic_vector(N-1 downto 0);
		write_en 	: in std_logic;
		i_CLK 		: in std_logic;
		i_RST 		: in std_logic;
		read_data 	: out std_logic_vector(N-1 downto 0));
end Reg_N;

architecture structural of Reg_N is
	component dffg is
		port(i_CLK 	: in std_logic;
			i_RST 	: in std_logic;
			i_WE	: in std_logic;
			i_D	: in std_logic;
			o_Q	: out std_logic);
	end component;

	begin
		NBit_Reg: for i in 0 to N-1 generate
			dffI: dffg port map(i_CLK 	=> i_CLK,
						i_RST	=> i_RST,
						i_WE	=> write_en,
						i_D	=> write_data(i),
						o_Q	=> read_data(i));
		end generate NBit_Reg;
end structural;
			