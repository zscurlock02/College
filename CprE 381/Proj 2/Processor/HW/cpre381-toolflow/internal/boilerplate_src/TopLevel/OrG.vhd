library IEEE;
use IEEE.std_logic_1164.all;

entity OrG is
	port(input1 : in std_logic_vector(31 downto 0);
	     input2 : in std_logic_vector(31 downto 0);
	     output : out std_logic_vector(31 downto 0));
end entity OrG;

architecture dataflow of OrG is
begin
	output <= input1 or input2;
end dataflow;