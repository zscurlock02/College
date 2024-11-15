library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Decoder5to32 is
    Port (
        input	: in STD_LOGIC_VECTOR(4 downto 0); -- 5-bit input
	enable	: in std_logic;
        output	: out STD_LOGIC_VECTOR(31 downto 0) -- 32-bit output
	
    );
end Decoder5to32;

architecture dataflow of Decoder5to32 is
begin

	process(input, enable)
	begin
	if enable = '1' then
		output(0) <= not input(4) and not input(3) and not input(2) and not input(1) and not input(0);
		output(1) <= not input(4) and not input(3) and not input(2) and not input(1) and input(0);
		output(2) <= not input(4) and not input(3) and not input(2) and input(1) and not input(0);
		output(3) <= not input(4) and not input(3) and not input(2) and input(1) and input(0);
		output(4) <= not input(4) and not input(3) and input(2) and not input(1) and not input(0);
		output(5) <= not input(4) and not input(3) and input(2) and not input(1) and input(0);
		output(6) <= not input(4) and not input(3) and input(2) and input(1) and not input(0);
		output(7) <= not input(4) and not input(3) and input(2) and input(1) and input(0);
		output(8) <= not input(4) and input(3) and not input(2) and not input(1) and not input(0);
		output(9) <= not input(4) and input(3) and not input(2) and not input(1) and input(0);
		output(10) <= not input(4) and input(3) and not input(2) and input(1) and not input(0);
		output(11) <= not input(4) and input(3) and not input(2) and input(1) and input(0);
		output(12) <= not input(4) and input(3) and input(2) and not input(1) and not input(0);
		output(13) <= not input(4) and input(3) and input(2) and not input(1) and input(0);
		output(14) <= not input(4) and input(3) and input(2) and input(1) and not input(0);
		output(15) <= not input(4) and input(3) and input(2) and input(1) and input(0);
		output(16) <= input(4) and not input(3) and not input(2) and not input(1) and not input(0);
		output(17) <= input(4) and not input(3) and not input(2) and not input(1) and input(0);
		output(18) <= input(4) and not input(3) and not input(2) and input(1) and not input(0);
		output(19) <= input(4) and not input(3) and not input(2) and input(1) and input(0);
		output(20) <= input(4) and not input(3) and input(2) and not input(1) and not input(0);
		output(21) <= input(4) and not input(3) and input(2) and not input(1) and input(0);
		output(22) <= input(4) and not input(3) and input(2) and input(1) and not input(0);
		output(23) <= input(4) and not input(3) and input(2) and input(1) and input(0);
		output(24) <= input(4) and input(3) and not input(2) and not input(1) and not input(0);
		output(25) <= input(4) and input(3) and not input(2) and not input(1) and input(0);
		output(26) <= input(4) and input(3) and not input(2) and input(1) and not input(0);
		output(27) <= input(4) and input(3) and not input(2) and input(1) and input(0);
		output(28) <= input(4) and input(3) and input(2) and not input(1) and not input(0);
		output(29) <= input(4) and input(3) and input(2) and not input(1) and input(0);
		output(30) <= input(4) and input(3) and input(2) and input(1) and not input(0);
		output(31) <= input(4) and input(3) and input(2) and input(1) and input(0);
	else
		output <= (others => '0');
	end if;
	end process;
end architecture dataflow;
