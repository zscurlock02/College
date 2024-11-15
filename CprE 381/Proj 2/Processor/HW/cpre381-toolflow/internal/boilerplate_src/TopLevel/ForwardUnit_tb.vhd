library IEEE;
use IEEE.std_logic_1164.all;

entity ForwardingUnit_tb is
end ForwardingUnit_tb;

architecture testbench of ForwardingUnit_tb is
    signal ReadAddr1, ReadAddr2, WriteAddr : std_logic_vector(4 downto 0) := "00000";
    signal WriteEnable, FwdSel1, FwdSel2 : std_logic;

    component ForwardingUnit
        port(ReadAddr1, ReadAddr2, WriteAddr : in std_logic_vector(4 downto 0);
             WriteEnable : in std_logic;
             FwdSel1, FwdSel2 : out std_logic);
    end component;

begin
    DUT0: ForwardingUnit
        port map(ReadAddr1, ReadAddr2, WriteAddr, WriteEnable, FwdSel1, FwdSel2);

    process
    begin
        -- Test case 1: No forwarding
        WriteEnable <= '0';
        wait for 100 ns;

        -- Test case 2: Forwarding to ReadAddr1
        WriteEnable <= '1';
        WriteAddr <= "01010";
        ReadAddr1 <= "01010";
        wait for 100 ns;

        -- Test case 3: No Forwarding
        WriteEnable <= '0';
	WriteAddr <= "11111";
        wait for 100 ns;

        -- Test case 4: Forwarding to ReadAddr2
	WriteEnable <= '1';
	ReadAddr2 <= "11111";
	wait for 100 ns;

	-- Test case 5: Forwarding to borth
	ReadAddr1 <= "11111";
	wait for 100 ns;

        wait;
    end process;

end testbench;
