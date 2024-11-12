library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity SUBU is
	port(A : in std_logic_vector(31 downto 0);
	     B : in std_logic_vector(31 downto 0);
	     output : out std_logic_vector(31 downto 0));
end SUBU;

architecture dataflow of SUBU is
begin
	output <= unsigned(A) - unsigned(B);
end dataflow;