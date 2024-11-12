library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SUBU_tb is
end SUBU_tb;

architecture testbench of SUBU_tb is
    signal A : std_logic_vector(31 downto 0);
    signal B : std_logic_vector(31 downto 0);
    signal output : std_logic_vector(31 downto 0);

	component SUBU
		port(A : in std_logic_vector(31 downto 0);
	     	     B : in std_logic_vector(31 downto 0);
             	     output : out std_logic_vector(31 downto 0));
	end component;

begin
    DUT0: SUBU
        port map (
            A => A,
            B => B,
            output => output
        );

    process
    begin
        -- Test case 1
        A <= "11111111111111111111111111111101";
        B <= "00000000000001111110000000000010";
        wait for 100 ns;

        -- Test case 2
        A <= "00000011110000100000001100000001";
        B <= "11111111111111111111111111111101";
        wait for 100 ns;

	--Test case 3
        A <= x"80000000";
	B <= x"80000000";
	wait for 100 ns;

	--Test case 4
	A <= x"7FFFFFFF";
	B <= x"7FFFFFFF";
	wait for 100 ns;

        wait;
    end process;

end testbench;