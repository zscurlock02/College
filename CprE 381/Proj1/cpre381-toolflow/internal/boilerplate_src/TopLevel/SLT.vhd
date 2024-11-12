library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity SLT is
	port(A : in std_logic_vector(31 downto 0);
	     B : in std_logic_vector(31 downto 0);
             SLT_result : out std_logic_vector(31 downto 0));
end SLT;

architecture dataflow of SLT is
begin
    	SLT_result <= x"00000001" when (signed(A) < signed(B)) else x"00000000";
end dataflow;