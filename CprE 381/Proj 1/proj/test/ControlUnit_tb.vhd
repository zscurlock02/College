library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity ControlUnit_tb is
end ControlUnit_tb;

architecture testbench of ControlUnit_tb is
    signal funct, OpCode : std_logic_vector(5 downto 0);
    signal ALUSrc, MemtoReg, MemRead, MemWrite, RegWrite, RegDst, Jal, Jr, Jump, Branch, SignExt, Bne : std_logic;
    signal ALUControl : std_logic_vector(5 downto 0);

    component ControlUnit
        port(funct, OpCode : in std_logic_vector(5 downto 0);
             ALUSrc, MemtoReg, MemRead, MemWrite, RegWrite, RegDst, Jal, Jr, Jump, Branch, SignExt, Bne : out std_logic;
             ALUControl : out std_logic_vector(5 downto 0));
    end component;

begin
    DUT0: ControlUnit
        port map(funct => funct,
            	 OpCode => OpCode,
            	 ALUSrc => ALUSrc,
            	 MemtoReg => MemtoReg,
            	 MemRead => MemRead,
            	 MemWrite => MemWrite,
            	 RegWrite => RegWrite,
            	 RegDst => RegDst,
            	 Jal => Jal,
            	 Jr => Jr,
            	 Jump => Jump,
            	 Branch => Branch,
            	 SignExt => SignExt,
            	 Bne => Bne,
            	 ALUControl => ALUControl);

    process
    begin
        -- Test 1: OpCode = "000000", funct = "100000" (add)
        OpCode <= "000000";
        funct <= "100000";
        wait for 100 ns;

        -- Test 2: OpCode = "001000" (addi)
        OpCode <= "001000";
        wait for 100 ns;

        -- Test 3: OpCode = "001111" (lui)
        OpCode <= "001111";
        wait for 100 ns;

        -- Test 4: OpCode = "000000", funct = "100101" (or)
	OpCode <= "000000";
	funct <= "100101";
	wait for 100 ns;

	-- Test 5: OpCode = "000000", funct = "100010" (sub)
	OpCode <= "000000";
	funct <= "100010";
	wait for 100 ns;

	-- Test 6: OpCode = "000010" (j)
	OpCode <= "000010";
	wait for 100 ns;

	-- Test 7: OpCode = "000000", funct = "001000" (jr)
	OpCode <= "000000";
	funct <= "001000";
	wait for 100 ns;

        wait;
    end process;

end testbench;