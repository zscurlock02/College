library IEEE;
use IEEE.std_logic_1164.all;

entity SLL2_32bits is
	port(input : in std_logic_vector(31 downto 0);
	     output : out std_logic_vector(31 downto 0));
end SLL2_32bits;

architecture dataflow of SLL2_32bits is
begin
	output <= input(29 downto 0) & "00";
end dataflow;