library IEEE;
use IEEE.std_logic_1164.all;
use work.bus_array.all;

entity RegisterFileTB is
	generic(gCLK_HPER : time := 50 ns);
end RegisterFileTB;

architecture testbench of RegisterFileTB is

	constant cCLK_per : time := gCLK_HPER * 2;

	--Signals for TB--
	signal i_Clk_tb      : std_logic;
	signal i_Reset_tb      : std_logic;
	signal write_enable_tb   : std_logic;
	signal read_select1_tb  : std_logic_vector(4 downto 0);
	signal read_select2_tb  : std_logic_vector(4 downto 0);
	signal write_select_tb  : std_logic_vector(4 downto 0);
	signal write_data_tb : std_logic_vector(31 downto 0);
	signal read_data1_tb : std_logic_vector(31 downto 0);
	signal read_data2_tb : std_logic_vector(31 downto 0);
	signal all_registers_tb : h;

	component RegisterFile
		port (i_Clk 	 : in std_logic;
	      	      i_Reset 	 : in std_logic;
	      	      write_enable   : in std_logic;
	      	      read_select1  : in std_logic_vector(4 downto 0);
	      	      read_select2  : in std_logic_vector(4 downto 0);
	      	      write_select  : in std_logic_vector(4 downto 0);
	      	      write_data : in std_logic_vector(31 downto 0);
	      	      read_data1 : out std_logic_vector(31 downto 0);
	      	      read_data2 : out std_logic_vector(31 downto 0);
		      all_registers : out h);
	end component;

begin
	DUT0: RegisterFile
	port map (i_Clk      => i_Clk_tb,
		  i_Reset      => i_Reset_tb,
		  write_enable   => write_enable_tb,
		  read_select1  => read_select1_tb,
		  read_select2  => read_select2_tb,
		  write_select  => write_select_tb,
		  write_data => write_data_tb,
		  read_data1 => read_data1_tb,
		  read_data2 => read_data2_tb,
		  all_registers => all_registers_tb);

	CLK_proc: process
	begin
		i_Clk_tb <= '0';
		wait for gCLK_HPER;
		i_Clk_tb <= '1';
		wait for gCLK_HPER;
	end process;

	RegisterFile_proc: process
	begin

		--Set up values--
		i_Reset_tb <= '0';
		write_enable_tb <= '0';
		read_select1_tb <= "00000";
		read_select2_tb <= "00000";
		write_select_tb <= "00000";
		write_data_tb <= x"FFFFFFFF";

		--Test case 1--
		wait for 140 ns;

		--Test case 2-- 
		write_enable_tb <= '1';
		write_select_tb <= "00001";
		read_select1_tb <= "00001";
		wait for 100 ns;
		write_data_tb <= x"00000001";
		write_select_tb <= "11000";
		read_select2_tb <= "11000";
		wait for 100 ns;

		--Test case 3--
		write_enable_tb <= '0';
		write_data_tb <= x"ABCDEF01";
		wait for 100 ns;
		write_enable_tb <= '1';
		wait for 100 ns;

		--Test case 4--
		i_Reset_tb <= '1';
		wait for 100 ns;
		i_Reset_tb <= '0';
		
		--Test case 5--
		write_select_tb <= "00000";
		write_data_tb <= x"FFFFFFFF";
		read_select1_tb <= "00000";
		wait for 160 ns;

		wait;
	end process;
end testbench;