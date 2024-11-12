library IEEE;
use IEEE.std_logic_1164.all;

entity ForwardingUnit is
	port(ReadAddr1	: in std_logic_vector(4 downto 0);
	     ReadAddr2	: in std_logic_vector(4 downto 0);
	     WriteAddr	: in std_logic_vector(4 downto 0);
	     WriteEnable : in std_logic;
	     FwdSel1	: out std_logic;
	     FwdSel2	: out std_logic);
end ForwardingUnit;

architecture behavioral of ForwardingUnit is
begin
	process(ReadAddr1, ReadAddr2, WriteAddr)
	begin
		if (WriteEnable = '1' and ReadAddr1 = WriteAddr and WriteAddr /= "00000") then
			FwdSel1 <= '1';
		else
			FwdSel1 <= '0';
		end if;
		if (WriteEnable = '1' and ReadAddr2 = WriteAddr and WriteAddr /= "00000") then
			FwdSel2 <= '1';
		else
			FwdSel2 <= '0';
		end if;
	end process;
end behavioral;