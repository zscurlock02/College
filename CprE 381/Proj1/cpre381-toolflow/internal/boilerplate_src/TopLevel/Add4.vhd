library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity Add4 is
	port(input : in std_logic_vector(31 downto 0);
	     output : out std_logic_vector(31 downto 0));
end Add4;

architecture dataflow of Add4 is

	signal four : std_logic_vector(31 downto 0);

begin
	four <= x"00000004";
	output <= signed(input) + signed(four);
end dataflow;