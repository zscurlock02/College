library IEEE;
use IEEE.std_logic_1164.all;

entity AndG is
	port(input1 : in std_logic_vector(31 downto 0);
	     input2 : in std_logic_vector(31 downto 0);
	     output : out std_logic_vector(31 downto 0));
end entity AndG;

architecture dataflow of AndG is
begin
	output <= input1 and input2;
end dataflow;