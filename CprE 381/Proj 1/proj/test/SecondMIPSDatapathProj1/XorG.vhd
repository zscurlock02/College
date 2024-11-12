library IEEE;
use IEEE.std_logic_1164.all;

entity XorG is
	port(input1 : in std_logic_vector(31 downto 0);
	     input2 : in std_logic_vector(31 downto 0);
	     output : out std_logic_vector(31 downto 0));
end entity XorG;

architecture dataflow of XorG is
begin
	output <= input1 xor input2;
end dataflow;