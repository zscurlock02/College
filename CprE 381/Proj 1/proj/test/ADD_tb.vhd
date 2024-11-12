library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ADD_tb is
end ADD_tb;

architecture testbench of ADD_tb is
    signal A : std_logic_vector(31 downto 0);
    signal B : std_logic_vector(31 downto 0);
    signal output : std_logic_vector(31 downto 0);
    signal ovf : std_logic;

	component ADD
		port(A : in std_logic_vector(31 downto 0);
	     	     B : in std_logic_vector(31 downto 0);
             	     output : out std_logic_vector(31 downto 0);
		     ovf : out std_logic);
	end component;

begin
    DUT0: ADD
        port map (
            A => A,
            B => B,
            output => output,
	    ovf => ovf
        );

    process
    begin
        -- Test case 1: A < B (A = -3, B = 5)
        A <= "11111111111111111111111111111101"; -- -3 in two's complement
        B <= "00000000000000000000000000000101"; -- 5 in two's complement
        wait for 100 ns;

        -- Test case 2: A >= B (A = 5, B = -3)
        A <= "00000000000000000000000000000101"; -- 5 in two's complement
        B <= "11111111111111111111111111111101"; -- -3 in two's complement
        wait for 100 ns;

	--Test case 3: should cause negative overflow
        A <= x"80000000";
	B <= x"80000000";
	wait for 100 ns;

	--Test case 4: should cause positive overflow
	A <= x"7FFFFFFF";
	B <= x"7FFFFFFF";
	wait for 100 ns;

        wait;
    end process;

end testbench;