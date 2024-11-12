library IEEE;
use IEEE.std_logic_1164.all;

entity HazardDetector is
	port(Jump		: in std_logic;
	     Branch		: in std_logic;
	     Jal_ID		: in std_logic;
	     Jal_EX		: in std_logic;
	     Jal_MEM		: in std_logic;
	     ReadAddr1		: in std_logic_vector(4 downto 0);
	     ReadAddr2		: in std_logic_vector(4 downto 0);
	     WriteAddr_ID	: in std_logic_vector(4 downto 0);
	     WriteAddr_EX	: in std_logic_vector(4 downto 0);
	     WriteEn_ID		: in std_logic;
	     WriteEn_EX		: in std_logic;
	     stall		: out std_logic);
end HazardDetector;

architecture behavioral of HazardDetector is
begin
	process (Jump, Branch, Jal_ID, Jal_EX, Jal_MEM, ReadAddr1, ReadAddr2, WriteAddr_ID, WriteAddr_EX, WriteEn_ID, WriteEn_EX)
	begin
		if ((WriteEn_ID = '1' and ReadAddr1 = WriteAddr_ID and ReadAddr1 /= "00000") or		--RegRead1 Data Hazard
		    (WriteEn_EX = '1' and ReadAddr1 = WriteAddr_EX and ReadAddr1 /= "00000")) then
			stall <= '1';
		elsif ((WriteEn_ID = '1' and ReadAddr2 = WriteAddr_ID and ReadAddr2 /= "00000") or	--ReadRead2 Data Hazard
		       (WriteEn_EX = '1' and ReadAddr2 = WriteAddr_EX and ReadAddr2 /= "00000")) then
			stall <= '1';
		elsif (Jump = '1' or Branch = '1' or Jal_ID = '1' or Jal_EX = '1' or Jal_MEM = '1') then	--Branching or Jumping
			stall <= '1';
		else
			stall <= '0';
		end if;
	end process;
end behavioral;