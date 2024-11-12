library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity BranchChecker is
	port(A : in std_logic_vector(31 downto 0);
	     B : in std_logic_vector(31 downto 0);
	     bne: in std_logic;
	     output : out std_logic);
end BranchChecker;

architecture dataflow of BranchChecker is
	begin
		output <= '1' when A = B and bne = '0' else
		'1' when A /= B and bne = '1' else '0';
end dataflow;