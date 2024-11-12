library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SLT_tb is
end SLT_tb;

architecture testbench of SLT_tb is
    signal A : std_logic_vector(31 downto 0);
    signal B : std_logic_vector(31 downto 0);
    signal SLT_result : std_logic_vector(31 downto 0);

	component SLT
		port(A : in std_logic_vector(31 downto 0);
	     	     B : in std_logic_vector(31 downto 0);
             	     SLT_result : out std_logic_vector(31 downto 0));
	end component;

begin
    DUT0: SLT
        port map (
            A => A,
            B => B,
            SLT_result => SLT_result
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

        -- Add more test cases here as needed

        wait;
    end process;

end testbench;
