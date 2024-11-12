library IEEE;
use IEEE.std_logic_1164.all;

entity SignExtender is
	port(input : in std_logic_vector(15 downto 0);
	     output : out std_logic_vector(31 downto 0));
end SignExtender;

architecture behavioral of SignExtender is
begin
	process(input)
	begin
		if input(15) = '0' then
			output <= (15 downto 0 => '0') & input;
		else
			output <= (15 downto 0 => '1') & input;
		end if;
	end process;
end behavioral;