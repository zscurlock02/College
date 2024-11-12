library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity Adder_32bits is
	port(A : in std_logic_vector(31 downto 0);
	     B : in std_logic_vector(31 downto 0);
	     output : out std_logic_vector(31 downto 0));
end Adder_32bits;

architecture dataflow of Adder_32bits is
begin
	output <= signed(A) + signed(B);
end dataflow;