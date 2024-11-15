library IEEE;
use IEEE.std_logic_1164.all;

entity ControlUnit is
	port(funct : in std_logic_vector(5 downto 0);
	     OpCode : in std_logic_vector(5 downto 0);
	     ALUSrc : out std_logic;
	     ALUControl : out std_logic_vector(5 downto 0);
	     MemtoReg : out std_logic;
	     MemRead : out std_logic;
	     MemWrite : out std_logic;
	     RegWrite : out std_logic;
	     RegDst : out std_logic;
	     Jal : out std_logic;
	     Jr : out std_logic;
	     Jump : out std_logic;
	     Branch : out std_logic;
	     SignExt : out std_logic;
	     Bne : out std_logic;
	     halt: out std_logic);
end ControlUnit;

architecture behavioral of ControlUnit is
begin
	process(funct, OpCode)
	begin
		--Default Everything to 0
		ALUSrc <= '0';
		ALUControl <= "000000";
		MemtoReg <= '0';
		MemRead <= '0';
		MemWrite <= '0';
		RegWrite <= '0';
		RegDst <= '0';
		Jal <= '0';
		Jr <= '0';
		Jump <= '0';
		Branch <= '0';
		SignExt <= '0';
		Bne <= '0';
		halt <= '0';

		--If statemente for each case
		if OpCode = "000000" and funct = "100000" then --add
			RegWrite <= '1';
			RegDst <= '1';
		elsif OpCode = "001000" then --addi
			ALUSrc <= '1';
			RegWrite <= '1';
			SignExt <= '1';
		elsif OpCode = "001001" then --addiu
			ALUSrc <= '1';
			ALUControl <= "000100";
			RegWrite <= '1';
			SignExt <= '1';
		elsif OpCode = "000000" and funct = "100001" then --addu
			ALUControl <= "000100";
			RegWrite <= '1';
			RegDst <= '1';
		elsif OpCode = "000000" and funct = "100100" then --and
			ALUControl <= "010000";
			RegWrite <= '1';
			RegDst <= '1';
		elsif OpCode = "001100" then --andi
			ALUSrc <= '1';
			ALUControl <= "010000";
			RegWrite <= '1';
		elsif OpCode = "001111" then --lui
			ALUSrc <= '1';
			ALUControl <= "101000";
			RegWrite <= '1';
		elsif OpCode = "100011" then --lw
			ALUSrc <= '1';
			MemtoReg <= '1';
			MemRead <= '1';
			RegWrite <= '1';
			SignExt <= '1';
		elsif OpCode = "000000" and funct = "100111" then --nor
			ALUControl <= "010100";
			RegWrite <= '1';
			RegDst <= '1';
		elsif OpCode = "000000" and funct = "100110" then --xor
			ALUControl <= "011000";
			RegWrite <= '1';
			RegDst <= '1';
		elsif OpCode = "001110" then --xori
			ALUSrc <= '1';
			ALUControl <= "011000";
			RegWrite <= '1';
		elsif OpCode = "000000" and funct = "100101" then --or
			ALUControl <= "011100";
			RegWrite <= '1';
			RegDst <= '1';
		elsif OpCode = "001101" then --ori
			ALUSrc <= '1';
			ALUControl <= "011100";
			RegWrite <= '1';
		elsif OpCode = "000000" and funct = "101010" then --slt
			ALUControl <= "100000";
			RegWrite <= '1';
			RegDst <= '1';
		elsif OpCode = "001010" then --slti
			ALUSrc <= '1';
			ALUControl <= "100000";
			RegWrite <= '1';
			SignExt <= '1';
		elsif OpCode = "000000" and funct = "000000" then --sll
			ALUControl <= "100101";
			RegWrite <= '1';
			RegDst <= '1';
		elsif OpCode = "000000" and funct = "000010" then --srl
			ALUControl <= "100110";
			RegWrite <= '1';
			RegDst <= '1';
		elsif OpCode = "000000" and funct = "000011" then --sra
			ALUControl <= "100111";
			RegWrite <= '1';
			RegDst <= '1';
		elsif OpCode = "101011" then --sw
			ALUSrc <= '1';
			MemWrite <= '1';
			SignExt <= '1';
		elsif OpCode = "000000" and funct = "100010" then --sub
			ALUControl <= "001000";
			RegWrite <= '1';
			RegDst <= '1';
		elsif OpCode = "000000" and funct = "100011" then --subu
			ALUControl <= "001100";
			RegWrite <= '1';
			RegDst <= '1';
		elsif OpCode = "000100" then --beq
			ALUControl <= "001000";
			Branch <= '1';
		elsif OpCode = "000101" then --bne
			ALUControl <= "001000";
			Branch <= '1';
			Bne <= '1';
		elsif OpCode = "000010" then --j
			Jump <= '1';
		elsif OpCode = "000011" then --jal
			RegWrite <= '1';
			Jal <= '1';
			Jump <= '1';
		elsif OpCode = "000000" and funct = "001000" then --jr
			Jr <= '1';
			Jump <= '1';
		elsif OpCode = "010100" then 
			halt <= '1';
		end if;
	end process;
end behavioral;