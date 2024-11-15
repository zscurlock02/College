library IEEE;
use IEEE.std_logic_1164.all;
use work.bus_array.all;

entity MIPSDatapath_tb is
	generic(gCLK_HPER : time := 50 ns);
end MIPSDatapath_tb;

architecture testbench of MIPSDatapath_tb is

	constant cCLK_per : time := gCLK_HPER * 2;

	--Signals for TB
	signal Clk_tb 			: std_logic;
	signal Reset_tb 		: std_logic;
	signal write_enable_tb 		: std_logic;
	signal ALUSrc_tb 		: std_logic;
	signal nAdd_Sub_tb 		: std_logic;
	signal source_register1_tb 	: std_logic_vector(4 downto 0);
	signal source_register2_tb 	: std_logic_vector(4 downto 0);
 	signal dest_register_tb 	: std_logic_vector(4 downto 0);
	signal immediate_value_tb 	: std_logic_vector(31 downto 0);
	signal all_registers_tb 	: h;

	component MIPSDatapath
		port(Clk 		: in std_logic;
	     	     Reset		: in std_logic;
		     write_enable 	: in std_logic;
		     ALUSrc 		: in std_logic;
		     nAdd_Sub 		: in std_logic;
		     source_register1 	: in std_logic_vector(4 downto 0);
	     	     source_register2 	: in std_logic_vector(4 downto 0);
	     	     dest_register 	: in std_logic_vector(4 downto 0);
	     	     immediate_value 	: in std_logic_vector(31 downto 0);
	     	     all_registers	: out h);
	end component;

begin

	DUT0: MIPSDatapath
	port map(Clk 			=> Clk_tb,
		 Reset 			=> Reset_tb,
		 write_enable 		=> write_enable_tb,
		 ALUSrc 		=> ALUSrc_tb,
		 nAdd_Sub 		=> nAdd_Sub_tb,
		 source_register1 	=> source_register1_tb,
		 source_register2 	=> source_register2_tb,
		 dest_register 		=> dest_register_tb,
		 immediate_value 	=> immediate_value_tb,
		 all_registers 		=> all_registers_tb);

	CLK_proc: process
	begin
		Clk_tb <= '0';
		wait for gCLK_HPER;
		Clk_tb <= '1';
		wait for gCLK_HPER;
	end process;
	
	MIPSDatapath_proc: process
	begin

		--Set up values
		Reset_tb <= '1';
		wait for 10 ns;
		Reset_tb <= '0';
		wait for 30 ns;

		--addi $1, $0, 1
		write_enable_tb <= '1';
		ALUSrc_tb <= '1';
		nAdd_Sub_tb <= '0';
		source_register1_tb <= "00000";
		source_register2_tb <= "00000";
		dest_register_tb <= "00001";
		immediate_value_tb <= x"00000001";
		wait for 100 ns;

		--addi $2, $0, 2
		dest_register_tb <= "00010";
		immediate_value_tb <= x"00000002";
		wait for 100 ns;

		--addi $3, $0, 3
		dest_register_tb <= "00011";
		immediate_value_tb <= x"00000003";
		wait for 100 ns;

		--addi $4, $0, 4
		dest_register_tb <= "00100";
		immediate_value_tb <= x"00000004";
		wait for 100 ns;

		--addi $5, $0, 5
		dest_register_tb <= "00101";
		immediate_value_tb <= x"00000005";
		wait for 100 ns;

		--addi $6, $0, 6
		dest_register_tb <= "00110";
		immediate_value_tb <= x"00000006";
		wait for 100 ns;

		--addi $7, $0, 7
		dest_register_tb <= "00111";
		immediate_value_tb <= x"00000007";
		wait for 100 ns;

		--addi $8, $0, 8
		dest_register_tb <= "01000";
		immediate_value_tb <= x"00000008";
		wait for 100 ns;

		--addi $9, $0, 9
		dest_register_tb <= "01001";
		immediate_value_tb <= x"00000009";
		wait for 100 ns;

		--addi $10, $0, 10
		dest_register_tb <= "01010";
		immediate_value_tb <= x"0000000A";
		wait for 100 ns;

		--add $11, $1, $2
		ALUSrc_tb <= '0';
		source_register1_tb <= "00001";
		source_register2_tb <= "00010";
		dest_register_tb <= "01011";
		wait for 100 ns;

		--sub $12, $11, $3
		nAdd_Sub_tb <= '1';
		source_register1_tb <= "01011";
		source_register2_tb <= "00011";
		dest_register_tb <= "01100";
		wait for 100 ns;

		--add $13, $12, $4
		nAdd_Sub_tb <= '0';
		source_register1_tb <= "01100";
		source_register2_tb <= "00100";
		dest_register_tb <= "01101";
		wait for 100 ns;

		--sub $14, $13, $5
		nAdd_Sub_tb <= '1';
		source_register1_tb <= "01101";
		source_register2_tb <= "00101";
		dest_register_tb <= "01110";
		wait for 100 ns;

		--add $15, $14, $6
		nAdd_Sub_tb <= '0';
		source_register1_tb <= "01110";
		source_register2_tb <= "00110";
		dest_register_tb <= "01111";
		wait for 100 ns;

		--sub $16, $15, $7
		nAdd_Sub_tb <= '1';
		source_register1_tb <= "01111";
		source_register2_tb <= "00111";
		dest_register_tb <= "10000";
		wait for 100 ns;

		--add $17, $16, $8
		nAdd_Sub_tb <= '0';
		source_register1_tb <= "10000";
		source_register2_tb <= "01000";
		dest_register_tb <= "10001";
		wait for 100 ns;

		--sub $18, $17, $9
		nAdd_Sub_tb <= '1';
		source_register1_tb <= "10001";
		source_register2_tb <= "01001";
		dest_register_tb <= "10010";
		wait for 100 ns;

		--add $19, $18, $10
		nAdd_Sub_tb <= '0';
		source_register1_tb <= "10010";
		source_register2_tb <= "01010";
		dest_register_tb <= "10011";
		wait for 100 ns;

		--addi $20, $0, -35
		ALUSrc_tb <= '1';
		source_register1_tb <= "00000";
		immediate_value_tb <= x"FFFFFFDD";
		dest_register_tb <= "10100";
		wait for 100 ns;

		--add $21, $19, $20
		ALUSrc_tb <= '0';
		source_register1_tb <= "10011";
		source_register2_tb <= "10100";
		dest_register_tb <= "10101";
		wait for 100 ns;

		write_enable_tb <= '0';
		wait for 60 ns;

		wait;
	end process;
end testbench;