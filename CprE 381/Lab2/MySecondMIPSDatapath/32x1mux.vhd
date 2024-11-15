library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.bus_array.all;

entity mux32x1 is
	port (
        	input : in h;
        	sel     : in STD_LOGIC_VECTOR(4 downto 0);
        	output       : out STD_LOGIC_VECTOR(31 downto 0));
end mux32x1;

architecture dataflow of mux32x1 is
begin
	output <= input(to_integer(unsigned(sel)));
end dataflow;