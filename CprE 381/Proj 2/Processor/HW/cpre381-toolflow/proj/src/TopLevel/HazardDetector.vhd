library IEEE;
use IEEE.std_logic_1164.all;

entity HazardDetector is
	port(Jump		: in std_logic;
	     Branch		: in std_logic;
	     Jal_ID		: in std_logic;
	     Jal_EX		: in std_logic;
	     Jal_MEM		: in std_logic;
	     FReadAddr1		: in std_logic_vector(4 downto 0);
	     FReadAddr2		: in std_logic_vector(4 downto 0);
	     DReadAddr1		: in std_logic_vector(4 downto 0);
	     DReadAddr2		: in std_logic_vector(4 downto 0);
	     WriteAddr_ID	: in std_logic_vector(4 downto 0);
	     WriteAddr_EX	: in std_logic_vector(4 downto 0);
	     WriteAddr_DM	: in std_logic_vector(4 downto 0);
	     WriteEn_ID		: in std_logic;
	     WriteEn_EX		: in std_logic;
	     WriteEn_DM		: in std_logic;
	     Inst		: in std_logic_vector(31 downto 0);
	     stall		: out std_logic;
	     PCen		: out std_logic);
end HazardDetector;

architecture behavioral of HazardDetector is
begin
	process (Inst, Jump, Branch, Jal_ID, Jal_EX, Jal_MEM, DReadAddr1, DReadAddr2, FReadAddr1, FReadAddr2, WriteAddr_ID, WriteAddr_DM, WriteAddr_EX, WriteEn_ID, WriteEn_DM, WriteEn_EX)
	begin
		if (Inst(31 downto 26) /= "000010" and Inst(31 downto 26) /= "000011" and Inst(5 downto 0) /= "001000") then
			if ((WriteEn_DM = '1' and FReadAddr1 = WriteAddr_DM and FReadAddr1 /= "00000") or		--RegRead1 Data Hazard
		       		(WriteEn_EX = '1' and FReadAddr1 = WriteAddr_EX and FReadAddr1 /= "00000") or
				(WriteEn_ID = '1' and FReadAddr1 = WriteAddr_ID and FReadAddr1 /= "00000")) then
					stall <= '1';
					PCen <= '1';
			elsif ((WriteEn_DM = '1' and FReadAddr2 = WriteAddr_DM and FReadAddr2 /= "00000") or	--ReadRead2 Data Hazard
		      		 (WriteEn_EX = '1' and FReadAddr2 = WriteAddr_EX and FReadAddr2 /= "00000") or
				(WriteEn_ID = '1' and FReadAddr2 = WriteAddr_ID and FReadAddr2 /= "00000")) then
					stall <= '1';
					PCen <= '1';
			end if;
		else
			PCen <= '1';
			stall <= '0';
		end if;

		if ((WriteEn_DM = '1' and DReadAddr1 = WriteAddr_DM and DReadAddr1 /= "00000") or		--RegRead1 Data Hazard
		    (WriteEn_EX = '1' and DReadAddr1 = WriteAddr_EX and DReadAddr1 /= "00000")) then
			stall <= '1';
			PCen <= '1';
		elsif ((WriteEn_DM = '1' and DReadAddr2 = WriteAddr_DM and DReadAddr2 /= "00000") or	--ReadRead2 Data Hazard
		       (WriteEn_EX = '1' and DReadAddr2 = WriteAddr_EX and DReadAddr2 /= "00000")) then
			stall <= '1';
			PCen <= '1';
		elsif (Jump = '1' or Branch = '1' or Jal_ID = '1') then	--Branching or Jumping
			stall <= '1';
			PCen <= '1';
		elsif (Jal_EX = '1' or Jal_MEM = '1') then
			PCen <= '0';
			stall <= '1';
		else
			PCen <= '1';
			stall <= '0';
		end if;
	end process;
end behavioral;