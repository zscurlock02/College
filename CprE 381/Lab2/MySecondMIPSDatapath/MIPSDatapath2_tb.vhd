library IEEE;
use IEEE.std_logic_1164.all;
use work.bus_array.all;

entity MIPSDatapath2_tb is
	generic(gCLK_HPER : time := 50 ns);
end MIPSDatapath2_tb;

architecture testbench of MIPSDatapath2_tb is

	--Signals for TB
	signal Clk_tb 			: std_logic;
	signal Reset_tb 		: std_logic;
	signal write_enable_tb 		: std_logic;
	signal ALUSrc_tb 		: std_logic;
	signal nAdd_Sub_tb 		: std_logic;
	signal memwrite_enable_tb 	: std_logic;
	signal write_from_mem_tb 	: std_logic;
	signal zeroextend_tb 		: std_logic;
	signal source_register1_tb 	: std_logic_vector(4 downto 0);
	signal source_register2_tb 	: std_logic_vector(4 downto 0);
	signal dest_register_tb 	: std_logic_vector(4 downto 0);
	signal immediate_value_tb 	: std_logic_vector(15 downto 0);
	signal all_registers_tb 	: h;

	component MIPSDatapath2
		port(Clk 		: in std_logic;
	     	     Reset 		: in std_logic;
	     	     write_enable 	: in std_logic;
	     	     ALUSrc 		: in std_logic;
	     	     nAdd_Sub 		: in std_logic;
	     	     memwrite_enable 	: in std_logic;
	     	     write_from_mem 	: in std_logic;
	     	     zeroextend 	: in std_logic;
	     	     source_register1 	: in std_logic_vector(4 downto 0);
	     	     source_register2 	: in std_logic_vector(4 downto 0);
	     	     dest_register 	: in std_logic_vector(4 downto 0);
	     	     immediate_value 	: in std_logic_vector(15 downto 0);
	     	     all_registers 	: out h);
	end component;

begin

	DUT0: MIPSDatapath2
	port map(Clk 			=> Clk_tb,
	     	 Reset 			=> Reset_tb,
	     	 write_enable 		=> write_enable_tb,
	     	 ALUSrc 		=> ALUSrc_tb,
	     	 nAdd_Sub 		=> nAdd_Sub_tb,
	     	 memwrite_enable 	=> memwrite_enable_tb,
	     	 write_from_mem 	=> write_from_mem_tb,
	     	 zeroextend 		=> zeroextend_tb,
	     	 source_register1 	=> source_register1_tb,
	     	 source_register2 	=> source_register2_tb,
	     	 dest_register 		=> dest_register_tb,
	     	 immediate_value 	=> immediate_value_tb,
	     	 all_registers 		=> all_registers_tb);

	CLK_proc: process
	begin
		CLK_tb <= '0';
		wait for gCLK_HPER;
		CLK_tb <= '1';
		wait for gCLK_HPER;
	end process;
	
	MIPSDatapath2_proc: process
	begin

		--Set up values
		Reset_tb <= '1';
		wait for 10 ns;
		Reset_tb <= '0';
		wait for 30 ns;

		--addi $25, $0, 0
		write_enable_tb <= '1';
		ALUSrc_tb <= '1';
		nAdd_Sub_tb <= '0';
		zeroextend_tb <= '0';
		memwrite_enable_tb <= '0';
		write_from_mem_tb <= '0';
		source_register1_tb <= "00000";
		source_register2_tb <= "00000";
		dest_register_tb <= "11001";
		immediate_value_tb <= x"0000";
		wait for 100 ns;

		--addi $26, $0, 256
		dest_register_tb <= "11010";
		immediate_value_tb <= x"0100";
		wait for 100 ns;

		--lw $1, 0($25)
		write_enable_tb <= '1';
		ALUSrc_tb <= '1';
		nAdd_Sub_tb <= '0';
		zeroextend_tb <= '0';
		memwrite_enable_tb <= '0';
		write_from_mem_tb <= '1';
		source_register1_tb <= "11001";
		dest_register_tb <= "00001";
		immediate_value_tb <= x"0000";
		wait for 100 ns;

		--lw $2, 4($25)
		write_enable_tb <= '1';
		ALUSrc_tb <= '1';
		nAdd_Sub_tb <= '0';
		zeroextend_tb <= '0';
		memwrite_enable_tb <= '0';
		write_from_mem_tb <= '1';
		source_register1_tb <= "11001";
		dest_register_tb <= "00010";
		immediate_value_tb <= x"0001";
		wait for 100 ns;

		--add $1, $1, $2
		write_enable_tb <= '1';
		ALUSrc_tb <= '0';
		nAdd_Sub_tb <= '0';
		memwrite_enable_tb <= '0';
		write_from_mem_tb <= '0';
		source_register1_tb <= "00001";
		source_register2_tb <= "00010";
		dest_register_tb <= "00001";
		wait for 100 ns;

		--sw $1, 0($26)
		write_enable_tb <= '0';
		ALUSrc_tb <= '1';
		nAdd_Sub_tb <= '0';
		memwrite_enable_tb <= '1';
		source_register1_tb <= "11010";
		source_register2_tb <= "00001";
		immediate_value_tb <= x"0000";
		wait for 100 ns;

		--lw $2, 8($25)
		write_enable_tb <= '1';
		ALUSrc_tb <= '1';
		nAdd_Sub_tb <= '0';
		zeroextend_tb <= '0';
		memwrite_enable_tb <= '0';
		write_from_mem_tb <= '1';
		source_register1_tb <= "11001";
		dest_register_tb <= "00010";
		immediate_value_tb <= x"0002";
		wait for 100 ns;

		--add $1, $1, $2
		write_enable_tb <= '1';
		ALUSrc_tb <= '0';
		nAdd_Sub_tb <= '0';
		memwrite_enable_tb <= '0';
		write_from_mem_tb <= '0';
		source_register1_tb <= "00001";
		source_register2_tb <= "00010";
		dest_register_tb <= "00001";
		wait for 100 ns;

		--sw $1, 4($26)
		write_enable_tb <= '0';
		ALUSrc_tb <= '1';
		nAdd_Sub_tb <= '0';
		memwrite_enable_tb <= '1';
		source_register1_tb <= "11010";
		source_register2_tb <= "00001";
		immediate_value_tb <= x"0001";
		wait for 100 ns;

		--lw $2, 12($25)
		write_enable_tb <= '1';
		ALUSrc_tb <= '1';
		nAdd_Sub_tb <= '0';
		zeroextend_tb <= '0';
		memwrite_enable_tb <= '0';
		write_from_mem_tb <= '1';
		source_register1_tb <= "11001";
		dest_register_tb <= "00010";
		immediate_value_tb <= x"0003";
		wait for 100 ns;

		--add $1, $1, $2
		write_enable_tb <= '1';
		ALUSrc_tb <= '0';
		nAdd_Sub_tb <= '0';
		memwrite_enable_tb <= '0';
		write_from_mem_tb <= '0';
		source_register1_tb <= "00001";
		source_register2_tb <= "00010";
		dest_register_tb <= "00001";
		wait for 100 ns;

		--sw $1, 8($26)
		write_enable_tb <= '0';
		ALUSrc_tb <= '1';
		nAdd_Sub_tb <= '0';
		memwrite_enable_tb <= '1';
		source_register1_tb <= "11010";
		source_register2_tb <= "00001";
		immediate_value_tb <= x"0002";
		wait for 100 ns;
	
		--lw $2, 16($25)
		write_enable_tb <= '1';
		ALUSrc_tb <= '1';
		nAdd_Sub_tb <= '0';
		zeroextend_tb <= '0';
		memwrite_enable_tb <= '0';
		write_from_mem_tb <= '1';
		source_register1_tb <= "11001";
		dest_register_tb <= "00010";
		immediate_value_tb <= x"0004";
		wait for 100 ns;

		--add $1, $1, $2
		write_enable_tb <= '1';
		ALUSrc_tb <= '0';
		nAdd_Sub_tb <= '0';
		memwrite_enable_tb <= '0';
		write_from_mem_tb <= '0';
		source_register1_tb <= "00001";
		source_register2_tb <= "00010";
		dest_register_tb <= "00001";
		wait for 100 ns;

		--sw $1, 12($26)
		write_enable_tb <= '0';
		ALUSrc_tb <= '1';
		nAdd_Sub_tb <= '0';
		memwrite_enable_tb <= '1';
		source_register1_tb <= "11010";
		source_register2_tb <= "00001";
		immediate_value_tb <= x"0003";
		wait for 100 ns;

		--lw $2, 20($25)
		write_enable_tb <= '1';
		ALUSrc_tb <= '1';
		nAdd_Sub_tb <= '0';
		zeroextend_tb <= '0';
		memwrite_enable_tb <= '0';
		write_from_mem_tb <= '1';
		source_register1_tb <= "11001";
		dest_register_tb <= "00010";
		immediate_value_tb <= x"0005";
		wait for 100 ns;

		--add $1, $1, $2
		write_enable_tb <= '1';
		ALUSrc_tb <= '0';
		nAdd_Sub_tb <= '0';
		memwrite_enable_tb <= '0';
		write_from_mem_tb <= '0';
		source_register1_tb <= "00001";
		source_register2_tb <= "00010";
		dest_register_tb <= "00001";
		wait for 100 ns;

		--sw $1, 16($26)
		write_enable_tb <= '0';
		ALUSrc_tb <= '1';
		nAdd_Sub_tb <= '0';
		memwrite_enable_tb <= '1';
		source_register1_tb <= "11010";
		source_register2_tb <= "00001";
		immediate_value_tb <= x"0004";
		wait for 100 ns;

		--lw $2, 24($25)
		write_enable_tb <= '1';
		ALUSrc_tb <= '1';
		nAdd_Sub_tb <= '0';
		zeroextend_tb <= '0';
		memwrite_enable_tb <= '0';
		write_from_mem_tb <= '1';
		source_register1_tb <= "11001";
		dest_register_tb <= "00010";
		immediate_value_tb <= x"0006";
		wait for 100 ns;

		--add $1, $1, $2
		write_enable_tb <= '1';
		ALUSrc_tb <= '0';
		nAdd_Sub_tb <= '0';
		memwrite_enable_tb <= '0';
		write_from_mem_tb <= '0';
		source_register1_tb <= "00001";
		source_register2_tb <= "00010";
		dest_register_tb <= "00001";
		wait for 100 ns;

		--addi $27, $0, 512
		write_enable_tb <= '1';
		ALUSrc_tb <= '1';
		nAdd_Sub_tb <= '0';
		zeroextend_tb <= '0';
		memwrite_enable_tb <= '0';
		write_from_mem_tb <= '0';
		source_register1_tb <= "00000";
		dest_register_tb <= "11011";
		immediate_value_tb <= x"0200";
		wait for 100 ns;

		--sw $1, -4($27)
		write_enable_tb <= '0';
		ALUSrc_tb <= '1';
		nAdd_Sub_tb <= '0';
		memwrite_enable_tb <= '1';
		source_register1_tb <= "11011";
		source_register2_tb <= "00001";
		immediate_value_tb <= x"FFFC";
		wait for 100 ns;

		memwrite_enable_tb <= '0';
		write_enable_tb <= '0';
		wait for 60 ns;

		wait;
	end process;
end testbench;