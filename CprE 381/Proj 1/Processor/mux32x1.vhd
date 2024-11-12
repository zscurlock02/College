library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.bus_array.all;

entity mux32x1 is
	port (inputs : in twodarray;
	      sel    : in std_logic_vector(4 downto 0);
	      output : out std_logic_vector(31 downto 0));
end entity mux32x1;

architecture dataflow of mux32x1 is
begin
	output <= inputs(to_integer(unsigned(sel)));
end dataflow;