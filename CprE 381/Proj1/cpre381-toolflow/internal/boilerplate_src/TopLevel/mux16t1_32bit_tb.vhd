library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux16t1_32bit_tb is
end mux16t1_32bit_tb;

architecture testbench of mux16t1_32bit_tb is
    -- Signal Declarations
    signal i_D0, i_D1, i_D2, i_D3, i_D4, i_D5, i_D6, i_D7, i_D8, i_D9, i_D10, i_D11, i_D12, i_D13, i_D14, i_D15 : std_logic_vector(31 downto 0);
    signal i_S : std_logic_vector(3 downto 0);
    signal o_O : std_logic_vector(31 downto 0);

	component mux16t1_32bit
		port(i_D0 : in std_logic_vector(31 downto 0);
	     	     i_D1 : in std_logic_vector(31 downto 0);
	     	     i_D2 : in std_logic_vector(31 downto 0);
	     	     i_D3 : in std_logic_vector(31 downto 0);
	     	     i_D4 : in std_logic_vector(31 downto 0);
	     	     i_D5 : in std_logic_vector(31 downto 0);
	     	     i_D6 : in std_logic_vector(31 downto 0);
	     	     i_D7 : in std_logic_vector(31 downto 0);
	     	     i_D8 : in std_logic_vector(31 downto 0);
	     	     i_D9 : in std_logic_vector(31 downto 0);
	     	     i_D10 : in std_logic_vector(31 downto 0);
	     	     i_D11 : in std_logic_vector(31 downto 0);
	     	     i_D12 : in std_logic_vector(31 downto 0);
	     	     i_D13 : in std_logic_vector(31 downto 0);
	     	     i_D14 : in std_logic_vector(31 downto 0);
	     	     i_D15 : in std_logic_vector(31 downto 0);
	     	     i_S  : in std_logic_vector(3 downto 0);
	     	     o_O  : out std_logic_vector(31 downto 0));
	end component;

begin
    -- Instantiate the mux16t1_32bit component
    DUT0 : mux16t1_32bit
        port map (
            i_D0 => i_D0,
            i_D1 => i_D1,
            i_D2 => i_D2,
            i_D3 => i_D3,
            i_D4 => i_D4,
            i_D5 => i_D5,
            i_D6 => i_D6,
            i_D7 => i_D7,
            i_D8 => i_D8,
            i_D9 => i_D9,
            i_D10 => i_D10,
            i_D11 => i_D11,
            i_D12 => i_D12,
            i_D13 => i_D13,
            i_D14 => i_D14,
            i_D15 => i_D15,
            i_S => i_S,
            o_O => o_O
        );

    process
    begin

        i_S <= "0000";
        i_D0 <= x"00000000";
        i_D1 <= x"11111111";
        i_D2 <= x"22222222";
        i_D3 <= x"33333333";
        i_D4 <= x"44444444";
        i_D5 <= x"55555555";
        i_D6 <= x"66666666";
        i_D7 <= x"77777777";
        i_D8 <= x"88888888";
        i_D9 <= x"99999999";
        i_D10 <= x"AAAAAAAA";
        i_D11 <= x"BBBBBBBB";
        i_D12 <= x"CCCCCCCC";
        i_D13 <= x"DDDDDDDD";
        i_D14 <= x"EEEEEEEE";
        i_D15 <= x"FFFFFFFF";
	wait for 100 ns;
        
	i_S <= "0001";
	wait for 100 ns;

	i_S <= "0010";
	wait for 100 ns;

	i_S <= "0011";
	wait for 100 ns;

	i_S <= "0100";
	wait for 100 ns;

	i_S <= "0101";
	wait for 100 ns;

	i_S <= "0110";
	wait for 100 ns;

	i_S <= "0111";
	wait for 100 ns;

	i_S <= "1000";
	wait for 100 ns;

	i_S <= "1001";
	wait for 100 ns;

	i_S <= "1010";
	wait for 100 ns;

	i_S <= "1011";
	wait for 100 ns;

	i_S <= "1100";
	wait for 100 ns;

	i_S <= "1101";
	wait for 100 ns;

	i_S <= "1110";
	wait for 100 ns;

	i_S <= "1111";
	wait for 100 ns;

        wait;
    end process;
end testbench;
