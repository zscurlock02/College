library IEEE;
use IEEE.std_logic_1164.all;

entity mux2t1_32bit is
	port(i_D0 : in std_logic_vector(31 downto 0);
	     i_D1 : in std_logic_vector(31 downto 0);
	     i_S  : in std_logic;
	     o_O  : out std_logic_vector(31 downto 0));
end mux2t1_32bit;

architecture behavioral of mux2t1_32bit is
begin
	process(i_D0, i_D1, i_S)
	begin
		if i_S = '0' then
			o_O <= i_D0;
		else
			o_O <= i_D1;
		end if;
	end process;
end architecture behavioral;