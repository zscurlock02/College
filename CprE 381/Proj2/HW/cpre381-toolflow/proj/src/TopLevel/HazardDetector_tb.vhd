library IEEE;
use IEEE.std_logic_1164.all;

entity HazardDetector_tb is
end HazardDetector_tb;

architecture testbench of HazardDetector_tb is
    signal Jump, Branch, Jal_ID, Jal_EX, Jal_MEM : std_logic := '0';
    signal ReadAddr1, ReadAddr2, WriteAddr_ID, WriteAddr_EX : std_logic_vector(4 downto 0) := "00000";
    signal WriteEn_ID, WriteEn_EX, stall : std_logic;

    component HazardDetector
        port(Jump, Branch, Jal_ID, Jal_EX, Jal_MEM : in std_logic;
             ReadAddr1, ReadAddr2, WriteAddr_ID, WriteAddr_EX : in std_logic_vector(4 downto 0);
             WriteEn_ID, WriteEn_EX : in std_logic;
             stall : out std_logic);
    end component;

begin
    DUT0: HazardDetector
        port map(Jump, Branch, Jal_ID, Jal_EX, Jal_MEM, ReadAddr1, ReadAddr2,
                 WriteAddr_ID, WriteAddr_EX, WriteEn_ID, WriteEn_EX, stall);

    process
    begin
        -- Test case 1: No hazard
        Jump <= '0';
        Branch <= '0';
        Jal_ID <= '0';
        Jal_EX <= '0';
        Jal_MEM <= '0';
        ReadAddr1 <= "00000";
        ReadAddr2 <= "00000";
        WriteAddr_ID <= "00000";
        WriteAddr_EX <= "00000";
        WriteEn_ID <= '0';
        WriteEn_EX <= '0';
        wait for 100 ns;

        -- Test case 2: WriteRead1 Data Hazard
        WriteEn_ID <= '1';
        ReadAddr1 <= "01010";
	WriteAddr_ID <= "01010";
        wait for 100 ns;

        -- Test case 3: Branching or Jumping Hazard
	WriteEn_ID <= '0';
        ReadAddr1 <= "00000";
	WriteAddr_ID <= "00000";
        Jump <= '1';
        wait for 100 ns;

        -- Test case 4: WriteRead2 Data Hazard
	WriteEn_EX <= '1';
	ReadAddr2 <= "01011";
	WriteAddr_EX <= "01011";
	Jump <= '0';
	wait for 100 ns;

        wait;
    end process;

end testbench;
