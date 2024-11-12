library IEEE;
use IEEE.std_logic_1164.all;

entity ZeroExtender is
	port(input16 : in std_logic_vector(15 downto 0);
	     output32 : out std_logic_vector(31 downto 0));
end ZeroExtender;

architecture behavioral of ZeroExtender is
begin
	output32 <= (15 downto 0 => '0') & input16;
end behavioral;