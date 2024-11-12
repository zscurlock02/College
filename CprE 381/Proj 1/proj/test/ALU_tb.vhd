library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU_tb is
end ALU_tb;

architecture testbench of ALU_tb is
    signal A, B, ALUOut : std_logic_vector(31 downto 0);
    signal shamt : std_logic_vector(4 downto 0);
    signal ALUControl : std_logic_vector(5 downto 0);
    signal zero, ovf : std_logic;

    -- Component instantiation for ALU
    component ALU
        port (
            A : in std_logic_vector(31 downto 0);
            B : in std_logic_vector(31 downto 0);
            shamt : in std_logic_vector(4 downto 0);
            ALUControl : in std_logic_vector(5 downto 0);
            ALUOut : out std_logic_vector(31 downto 0);
            zero : out std_logic;
            ovf : out std_logic
        );
    end component;

begin
    -- Instantiate the ALU
    DUT0: ALU
        port map (
            A => A,
            B => B,
            shamt => shamt,
            ALUControl => ALUControl,
            ALUOut => ALUOut,
            zero => zero,
            ovf => ovf
        );

    process
    begin

	--Test case 1 ADD X
        A <= x"00FE07A3";
        B <= x"00000002";
        shamt <= "00000";
        ALUControl <= "000000";
	wait for 100 ns;

	--Test case 2 ADD w/ Ovf X
	A <= x"7FFFFFFF";
	B <= x"7FFFFFFF";
	ALUControl <= "000000";
	wait for 100 ns;

	--Test case 3 ADDU X
	A <= x"006482FF";
	B <= x"00000065";
	ALUControl <= "000100";
	wait for 100 ns;

	--Test case 4 SUB X
	A <= x"00000067";
	B <= x"00FEA671";
	ALUControl <= "001000";
	wait for 100 ns;

	--Test case 5 SUB w/ Ovf X
	A <= x"7FFFFFFF";
	B <= x"80000000";
	ALUControl <= "001000";
	wait for 100 ns;

	--Test case 6 SUBU X
	A <= x"FFFFFF65";
	B <= x"00000781";
	ALUControl <= "001100";
	wait for 100 ns;

	--Test case 7 AND X
	A <= x"FFFF0000";
	B <= x"FFFFFFFF";
	ALUControl <= "010000";
	wait for 100 ns;

	--Test case 8 NOR X
	A <= x"FFFF0000";
	B <= x"00000000";
	ALUControl <= "010100";
	wait for 100 ns;

	--Test case 9 XOR X
	A <= x"FFFFFFFF";
	B <= x"0F0F0F0F";
	ALUControl <= "011000";
	wait for 100 ns;

	--Test case 10 OR X
	A <= x"F0F0FFFF";
	B <= x"0F0FFFFF";
	ALUControl <= "011100";
	wait for 100 ns;

	--Test case 11 SLT (A > B) X
	A <= x"0000FFFF";
	B <= x"000000FF";
	ALUControl <= "100000";
	wait for 100 ns;

	--Test case 11.2 SLT (A < B) X
	A <= x"0000FFFF";
	B <= x"00FFFFFF";
	ALUControl <= "100000";
	wait for 100 ns;

	--Test case 12 SRA X
	A <= x"00000000";
	B <= x"F0000000";
	shamt <= "00101";
	ALUControl <= "100111";
	wait for 100 ns;

	--Test case 13 SRL X
	B <= x"F0000000";
	shamt <= "00011";
	ALUControl <= "100110";
	wait for 100 ns;

	--Test case 14 SLL X
	B <= x"00ABCDFF";
	shamt <= "00100";
	ALUControl <= "100101";
	wait for 100 ns;

	--Test case 15 LUI X
	B <= x"0000FABC";
	ALUControl <= "101000";
	wait for 100 ns;

        wait;
    end process;

end testbench;
