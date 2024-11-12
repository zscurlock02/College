library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity ADD is
	port(A : in std_logic_vector(31 downto 0);
	     B : in std_logic_vector(31 downto 0);
	     output : out std_logic_vector(31 downto 0);
	     ovf : out std_logic);
end ADD;

architecture dataflow of ADD is

	signal output2 : std_logic_vector(31 downto 0);

begin
	output <= signed(A) + signed(B);
	output2 <= signed(A) + signed(B);
	ovf <= '1' when A(31) = '1' and B(31) = '1' and output2(31) = '0' else
	       '1' when A(31) = '0' and B(31) = '0' and output2(31) = '1' else
	       '0';
end dataflow;