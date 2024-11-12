library IEEE;
use IEEE.std_logic_1164.all;

entity SignExtender is
	port(input16 : in std_logic_vector(15 downto 0);
	     output32 : out std_logic_vector(31 downto 0));
end SignExtender;

architecture behavioral of SignExtender is
begin
	process(input16)
	begin
		if input16(15) = '0' then
			output32 <= (15 downto 0 => '0') & input16;
		else
			output32 <= (15 downto 0 => '1') & input16;
		end if;
	end process;
end behavioral;