library ieee;
use ieee.std_logic_1164.all;

entity tb_dmem is
	generic(gCLK_HPER : time := 50 ns);
end tb_dmem;

architecture testbench of tb_dmem is

	--Signals for TB
	signal clk_tb	: std_logic;
	signal addr_tb	: std_logic_vector(9 downto 0);
	signal data_tb	: std_logic_vector(31 downto 0);
	signal we_tb	: std_logic := '1';
	signal q_tb	: std_logic_vector(31 downto 0);

	component mem
		generic(DATA_WIDTH : natural := 32;
			ADDR_WIDTH : natural := 10);
		port(clk	: in std_logic;
		     addr	: in std_logic_vector((ADDR_WIDTH-1) downto 0);
		     data	: in std_logic_vector((DATA_WIDTH-1) downto 0);
		     we		: in std_logic := '1';
		     q		: out std_logic_vector((DATA_WIDTH -1) downto 0));
	end component;

begin

	dmem: mem
	generic map(DATA_WIDTH => 32,
		    ADDR_WIDTH => 10)
	port map(clk => clk_tb,
		 addr => addr_tb,
		 data => data_tb,
		 we => we_tb,
		 q => q_tb);

	CLK_proc: process
	begin
		clk_tb <= '0';
		wait for gCLK_HPER;
		clk_tb <= '1';
		wait for gCLK_HPER;
	end process;

	dmem_proc: process
	begin

		--Read initial 10 values
		we_tb <= '0';
		addr_tb <= "0000000000";
		data_tb <= x"00000000";
		wait for 20 ns;

		addr_tb <= "0000000001";
		wait for 20 ns;

		addr_tb <= "0000000010";
		wait for 20 ns;

		addr_tb <= "0000000011";
		wait for 20 ns;

		addr_tb <= "0000000100";
		wait for 20 ns;

		addr_tb <= "0000000101";
		wait for 20 ns;

		addr_tb <= "0000000110";
		wait for 20 ns;

		addr_tb <= "0000000111";
		wait for 20 ns;

		addr_tb <= "0000001000";
		wait for 20 ns;

		addr_tb <= "0000001001";
		wait for 70 ns;

		--Store the 10 values
		we_tb <= '1';
		addr_tb <= "0100000000";
		data_tb <= x"FFFFFFFF";
		wait for 100 ns;

		addr_tb <= "0100000001";
		data_tb <= x"00000002";
		wait for 100 ns;

		addr_tb <= "0100000010";
		data_tb <= x"FFFFFFFD";
		wait for 100 ns;

		addr_tb <= "0100000011";
		data_tb <= x"00000004";
		wait for 100 ns;

		addr_tb <= "0100000100";
		data_tb <= x"00000005";
		wait for 100 ns;

		addr_tb <= "0100000101";
		data_tb <= x"00000006";
		wait for 100 ns;

		addr_tb <= "0100000110";
		data_tb <= x"FFFFFFF9";
		wait for 100 ns;

		addr_tb <= "0100000111";
		data_tb <= x"FFFFFFF8";
		wait for 100 ns;

		addr_tb <= "0100001000";
		data_tb <= x"00000009";
		wait for 100 ns;

		addr_tb <= "0100001001";
		data_tb <= x"FFFFFFF6";
		wait for 100 ns;
		we_tb <= '0';

		--Read back the values from the new memory location
		addr_tb <= "0100000000";
		wait for 20 ns;

		addr_tb <= "0100000001";
		wait for 20 ns;

		addr_tb <= "0100000010";
		wait for 20 ns;

		addr_tb <= "0100000011";
		wait for 20 ns;

		addr_tb <= "0100000100";
		wait for 20 ns;

		addr_tb <= "0100000101";
		wait for 20 ns;

		addr_tb <= "0100000110";
		wait for 20 ns;

		addr_tb <= "0100000111";
		wait for 20 ns;

		addr_tb <= "0100001000";
		wait for 20 ns;

		addr_tb <= "0100001001";
		wait for 20 ns;

	wait;
	end process;
end testbench;
