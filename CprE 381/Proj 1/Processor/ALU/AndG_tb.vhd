library IEEE;
use IEEE.std_logic_1164.all;

entity AndG_tb is
end entity AndG_tb;

architecture testbench of AndG_tb is
    signal input1 : std_logic_vector(31 downto 0);
    signal input2 : std_logic_vector(31 downto 0);
    signal output : std_logic_vector(31 downto 0);

    component AndG
        port(
            input1 : in std_logic_vector(31 downto 0);
            input2 : in std_logic_vector(31 downto 0);
            output : out std_logic_vector(31 downto 0));
    end component;

begin
    	DUT0: AndG 
	port map(input1 => input1,
		 input2 => input2,
		 output => output);

    	process
    	begin
        	input1 <= "11000000111100001111000011110000";
        	input2 <= "10101010101010101010101010101010";
        	wait for 100 ns;

		input1 <= "10101010101010101010101010101010";
		input2 <= "01010101010101010101010101010101";
		wait for 100 ns;

		input1 <= "10101010101010101010101010101010";
		input2 <= "10101010101010101010101010101010";
		wait for 100 ns;
        	wait;
    	end process;

end testbench;
