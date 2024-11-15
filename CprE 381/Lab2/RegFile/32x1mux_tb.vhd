library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.bus_array.all;

entity mux32x1_tb is
end mux32x1_tb;

architecture structural of mux32x1_tb is

	signal s_input_tb	: h;
	signal s_sel_tb		: std_logic_vector(4 downto 0) := (others => '0');
	signal s_output_tb	: std_logic_vector(31 downto 0);
	
	component mux32x1
		port(input	: in h;
		     sel	: in std_logic_vector(4 downto 0);
		     output	: out std_logic_vector(31 downto 0));
	end component;

begin
	
	DUT0: mux32x1

		port map (input => s_input_tb,
			  sel   => s_sel_tb,
			  output => s_output_tb);

	mux32x1_proc: process

	begin
	
	--Test case 1--
	s_input_tb(0) <= x"00000000";
	s_sel_tb <= "00000";
	wait for 100 ns;

	--Test case 2--
	s_input_tb(10) <= x"AAAAAAAA";
	s_sel_tb <= "01010";
	wait for 100 ns;

	--Test case 3--
	s_input_tb(16) <= x"12345678";
	s_sel_tb <= "10000";
	wait for 100 ns;

	--Test case 4--
	s_input_tb(31) <= x"FFFFFFFF";
	s_sel_tb <= "11111";
	wait for 100 ns;
	
	
	end process mux32x1_proc;
end structural;