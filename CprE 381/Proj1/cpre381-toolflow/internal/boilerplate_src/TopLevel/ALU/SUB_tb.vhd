library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SUB_tb is
end SUB_tb;

architecture testbench of SUB_tb is
    signal A : std_logic_vector(31 downto 0);
    signal B : std_logic_vector(31 downto 0);
    signal output : std_logic_vector(31 downto 0);
    signal ovf : std_logic;

	component SUB
		port(A : in std_logic_vector(31 downto 0);
	     	     B : in std_logic_vector(31 downto 0);
             	     output : out std_logic_vector(31 downto 0);
		     ovf : out std_logic);
	end component;

begin
    DUT0: SUB
        port map (
            A => A,
            B => B,
            output => output,
	    ovf => ovf
        );

    process
    begin
        -- Test case 1: -3 - 5 = -8
        A <= "11111111111111111111111111111101"; 
        B <= "00000000000000000000000000000101";
        wait for 100 ns;

        -- Test case 2: 5 - - 3 = 8
        A <= "00000000000000000000000000000101";
        B <= "11111111111111111111111111111101";
        wait for 100 ns;

	--Test case 3: should cause overflow
        A <= x"80000000";
	B <= x"7FFFFFFF";
	wait for 100 ns;

	--Test case 4: should cause overflow
	A <= x"7FFFFFFF";
	B <= x"80000000";
	wait for 100 ns;

        wait;
    end process;

end testbench;