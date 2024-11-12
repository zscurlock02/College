library IEEE;
use IEEE.std_logic_1164.all;

entity mux16t1 is
	port(i_D0 : in std_logic;
	     i_D1 : in std_logic;
	     i_D2 : in std_logic;
	     i_D3 : in std_logic;
	     i_D4 : in std_logic;
	     i_D5 : in std_logic;
	     i_D6 : in std_logic;
	     i_D7 : in std_logic;
	     i_D8 : in std_logic;
	     i_D9 : in std_logic;
	     i_D10 : in std_logic;
	     i_D11 : in std_logic;
	     i_D12 : in std_logic;
	     i_D13 : in std_logic;
	     i_D14 : in std_logic;
	     i_D15 : in std_logic;
	     i_S  : in std_logic_vector(3 downto 0);
	     o_O  : out std_logic);
end mux16t1;

architecture dataflow of mux16t1 is
begin

	o_O <= i_D0 when i_S = "0000" else
	       i_D1 when i_S = "0001" else
	       i_D2 when i_S = "0010" else
	       i_D3 when i_S = "0011" else
	       i_D4 when i_S = "0100" else
	       i_D5 when i_S = "0101" else
	       i_D6 when i_S = "0110" else
	       i_D7 when i_S = "0111" else
	       i_D8 when i_S = "1000" else
	       i_D9 when i_S = "1001" else
	       i_D10 when i_S = "1010" else
	       i_D11 when i_S = "1011" else
	       i_D12 when i_S = "1100" else
	       i_D13 when i_S = "1101" else
	       i_D14 when i_S = "1110" else
	       i_D15 when i_S = "1111";

end dataflow;