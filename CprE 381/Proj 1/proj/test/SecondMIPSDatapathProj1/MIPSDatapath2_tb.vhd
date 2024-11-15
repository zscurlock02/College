library IEEE;
use IEEE.std_logic_1164.all;
use work.bus_array.all;

entity MIPSDatapath2_tb is
	generic(gCLK_HPER : time := 50 ns);
end MIPSDatapath2_tb;

architecture testbench of MIPSDatapath2_tb is

	--Signals for TB
	signal CLK_tb 			: std_logic;
	signal RST_tb 			: std_logic;
	signal write_en_tb 		: std_logic;
	signal ALUSrc_tb 		: std_logic;
	signal ALUControl_tb		: std_logic_vector(5 downto 0);
	signal shamt_tb			: std_logic_vector(4 downto 0);
	signal memwrite_en_tb 		: std_logic;
	signal write_from_mem_tb 	: std_logic;
	signal zeroextend_tb 		: std_logic;
	signal source_reg1_tb 		: std_logic_vector(4 downto 0);
	signal source_reg2_tb 		: std_logic_vector(4 downto 0);
	signal dest_reg_tb 		: std_logic_vector(4 downto 0);
	signal immediate_val_tb 	: std_logic_vector(15 downto 0);
	signal all_registers_tb 	: twodarray;
	signal zero_tb			: std_logic;
	signal ovf_tb			: std_logic;

	component MIPSDatapath2
		port(CLK 		: in std_logic;
	     	     RST 		: in std_logic;
	     	     write_en 		: in std_logic;
	     	     ALUSrc 		: in std_logic;
	     	     ALUControl		: in std_logic_vector(5 downto 0);
		     shamt		: in std_logic_vector(4 downto 0);
	     	     memwrite_en 	: in std_logic;
	     	     write_from_mem 	: in std_logic;
	     	     zeroextend 	: in std_logic;
	     	     source_reg1 	: in std_logic_vector(4 downto 0);
	     	     source_reg2 	: in std_logic_vector(4 downto 0);
	     	     dest_reg 		: in std_logic_vector(4 downto 0);
	     	     immediate_val 	: in std_logic_vector(15 downto 0);
	     	     all_registers 	: out twodarray;
		     zero		: out std_logic;
		     ovf		: out std_logic);
	end component;

begin

	DUT0: MIPSDatapath2
	port map(CLK => CLK_tb,
	     	 RST => RST_tb,
	     	 write_en => write_en_tb,
	     	 ALUSrc => ALUSrc_tb,
	     	 ALUControl => ALUControl_tb,
		 shamt => shamt_tb,
	     	 memwrite_en => memwrite_en_tb,
	     	 write_from_mem => write_from_mem_tb,
	     	 zeroextend => zeroextend_tb,
	     	 source_reg1 => source_reg1_tb,
	     	 source_reg2 => source_reg2_tb,
	     	 dest_reg => dest_reg_tb,
	     	 immediate_val => immediate_val_tb,
	     	 all_registers => all_registers_tb,
		 zero => zero_tb,
		 ovf => ovf_tb);

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
		RST_tb <= '1';
		wait for 10 ns;
		RST_tb <= '0';
		wait for 30 ns;

		--addi $1, $0, 15
		write_en_tb <= '1';
		ALUSrc_tb <= '1';
		ALUControl_tb <= "000000";
		shamt_tb <= "00000";
		memwrite_en_tb <= '0';
		write_from_mem_tb <= '0';
		zeroextend_tb <= '0';
		source_reg1_tb <= "00000";
		source_reg2_tb <= "00000";
		dest_reg_tb <= "00001";
		immediate_val_tb <= x"000F";
		wait for 100 ns;

		--sll $2, $1, 1
		write_en_tb <= '1';
		ALUSrc_tb <= '0';
		ALUControl_tb <= "100101";
		shamt_tb <= "00001";
		memwrite_en_tb <= '0';
		write_from_mem_tb <= '0';
		zeroextend_tb <= '0';
		source_reg1_tb <= "00000";
		source_reg2_tb <= "00001";
		dest_reg_tb <= "00010";
		immediate_val_tb <= x"0000";
		wait for 100 ns;

		--addu $3, $1, $2
		write_en_tb <= '1';
		ALUSrc_tb <= '0';
		ALUControl_tb <= "000100";
		shamt_tb <= "00000";
		memwrite_en_tb <= '0';
		write_from_mem_tb <= '0';
		zeroextend_tb <= '0';
		source_reg1_tb <= "00001";
		source_reg2_tb <= "00010";
		dest_reg_tb <= "00011";
		immediate_val_tb <= x"0000";
		wait for 100 ns;

		--srl $4, $2, 1
		write_en_tb <= '1';
		ALUSrc_tb <= '0';
		ALUControl_tb <= "100110";
		shamt_tb <= "00001";
		memwrite_en_tb <= '0';
		write_from_mem_tb <= '0';
		zeroextend_tb <= '0';
		source_reg1_tb <= "00000";
		source_reg2_tb <= "00010";
		dest_reg_tb <= "00100";
		immediate_val_tb <= x"0000";
		wait for 100 ns;

		--sub $5, $3, $1
		write_en_tb <= '1';
		ALUSrc_tb <= '0';
		ALUControl_tb <= "001000";
		shamt_tb <= "00000";
		memwrite_en_tb <= '0';
		write_from_mem_tb <= '0';
		zeroextend_tb <= '0';
		source_reg1_tb <= "00011";
		source_reg2_tb <= "00001";
		dest_reg_tb <= "00101";
		immediate_val_tb <= x"0000";
		wait for 100 ns;

		--subu $6, $4, $5
		write_en_tb <= '1';
		ALUSrc_tb <= '0';
		ALUControl_tb <= "001100";
		shamt_tb <= "00000";
		memwrite_en_tb <= '0';
		write_from_mem_tb <= '0';
		zeroextend_tb <= '0';
		source_reg1_tb <= "00100";
		source_reg2_tb <= "00101";
		dest_reg_tb <= "00110";
		immediate_val_tb <= x"0000";
		wait for 100 ns;

		--and $7, $6, $2
		write_en_tb <= '1';
		ALUSrc_tb <= '0';
		ALUControl_tb <= "010000";
		shamt_tb <= "00000";
		memwrite_en_tb <= '0';
		write_from_mem_tb <= '0';
		zeroextend_tb <= '0';
		source_reg1_tb <= "00110";
		source_reg2_tb <= "00010";
		dest_reg_tb <= "00111";
		immediate_val_tb <= x"0000";
		wait for 100 ns;

		--nor $8, $2, $3
		write_en_tb <= '1';
		ALUSrc_tb <= '0';
		ALUControl_tb <= "010100";
		shamt_tb <= "00000";
		memwrite_en_tb <= '0';
		write_from_mem_tb <= '0';
		zeroextend_tb <= '0';
		source_reg1_tb <= "00010";
		source_reg2_tb <= "00011";
		dest_reg_tb <= "01000";
		immediate_val_tb <= x"0000";
		wait for 100 ns;

		--xor $9, $5, $6
		write_en_tb <= '1';
		ALUSrc_tb <= '0';
		ALUControl_tb <= "011000";
		shamt_tb <= "00000";
		memwrite_en_tb <= '0';
		write_from_mem_tb <= '0';
		zeroextend_tb <= '0';
		source_reg1_tb <= "00101";
		source_reg2_tb <= "00110";
		dest_reg_tb <= "01001";
		immediate_val_tb <= x"0000";
		wait for 100 ns;

		--or $10, $6, $1
		write_en_tb <= '1';
		ALUSrc_tb <= '0';
		ALUControl_tb <= "011100";
		shamt_tb <= "00000";
		memwrite_en_tb <= '0';
		write_from_mem_tb <= '0';
		zeroextend_tb <= '0';
		source_reg1_tb <= "00110";
		source_reg2_tb <= "00001";
		dest_reg_tb <= "01010";
		immediate_val_tb <= x"0000";
		wait for 100 ns;

		--slt $11, $6, $1
		write_en_tb <= '1';
		ALUSrc_tb <= '0';
		ALUControl_tb <= "100000";
		shamt_tb <= "00000";
		memwrite_en_tb <= '0';
		write_from_mem_tb <= '0';
		zeroextend_tb <= '0';
		source_reg1_tb <= "00110";
		source_reg2_tb <= "00001";
		dest_reg_tb <= "01011";
		immediate_val_tb <= x"0000";
		wait for 100 ns;

		--lui $12, 0x1001
		write_en_tb <= '1';
		ALUSrc_tb <= '1';
		ALUControl_tb <= "101000";
		shamt_tb <= "00000";
		memwrite_en_tb <= '0';
		write_from_mem_tb <= '0';
		zeroextend_tb <= '0';
		source_reg1_tb <= "00000";
		source_reg2_tb <= "00000";
		dest_reg_tb <= "01100";
		immediate_val_tb <= x"1001";
		wait for 100 ns;

		memwrite_en_tb <= '0';
		write_en_tb <= '0';
		wait for 60 ns;

		wait;
	end process;
end testbench;