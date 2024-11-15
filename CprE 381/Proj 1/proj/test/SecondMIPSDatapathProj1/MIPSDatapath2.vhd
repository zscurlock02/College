library IEEE;
use IEEE.std_logic_1164.all;
use work.bus_array.all;

entity MIPSDatapath2 is
	port(CLK : in std_logic;
	     RST : in std_logic;
	     write_en : in std_logic;
	     ALUSrc : in std_logic;
	     ALUControl : in std_logic_vector(5 downto 0);
	     shamt : in std_logic_vector(4 downto 0);
	     memwrite_en : in std_logic;
	     write_from_mem : in std_logic;
	     zeroextend : in std_logic;
	     source_reg1 : in std_logic_vector(4 downto 0);
	     source_reg2 : in std_logic_vector(4 downto 0);
	     dest_reg : in std_logic_vector(4 downto 0);
	     immediate_val : in std_logic_vector(15 downto 0);
	     all_registers : out twodarray;
	     zero : out std_logic;
	     ovf : out std_logic);
end MIPSDatapath2;

architecture structural of MIPSDatapath2 is
	component RegFile
		port(i_CLK 	 : in std_logic;
	      	     i_RST 	 : in std_logic;
	      	     write_en   : in std_logic;
	      	     read_sel1  : in std_logic_vector(4 downto 0);
	      	     read_sel2  : in std_logic_vector(4 downto 0);
	      	     write_sel  : in std_logic_vector(4 downto 0);
	      	     write_data : in std_logic_vector(31 downto 0);
		     read_data1 : out std_logic_vector(31 downto 0);
	      	     read_data2 : out std_logic_vector(31 downto 0);
	      	     all_registers : out twodarray);
	end component;

	component mux2t1_32bit
		port(i_D0 : in std_logic_vector(31 downto 0);
	     	     i_D1 : in std_logic_vector(31 downto 0);
	     	     i_S  : in std_logic;
	     	     o_O  : out std_logic_vector(31 downto 0));
	end component;

	component ALU
		port(A : in std_logic_vector(31 downto 0);
	     	     B : in std_logic_vector(31 downto 0);
	     	     shamt : in std_logic_vector(4 downto 0);
	     	     ALUControl : in std_logic_vector(5 downto 0);
	     	     ALUOut : out std_logic_vector(31 downto 0);
	     	     zero : out std_logic;
	     	     ovf : out std_logic);
	end component;

	component mem
		generic(DATA_WIDTH : natural := 32;
			ADDR_WIDTH : natural := 10);
		port(clk		: in std_logic;
	     	     addr	        : in std_logic_vector((ADDR_WIDTH-1) downto 0);
	     	     data	        : in std_logic_vector((DATA_WIDTH-1) downto 0);
	     	     we		: in std_logic := '1';
	     	     q		: out std_logic_vector((DATA_WIDTH -1) downto 0));
	end component;

	component ZeroExtender
		port(input16 : in std_logic_vector(15 downto 0);
	     	     output32 : out std_logic_vector(31 downto 0));
	end component;

	component SignExtender
		port(input16 : in std_logic_vector(15 downto 0);
	     	     output32 : out std_logic_vector(31 downto 0));
	end component;

	--Signals
	signal s_MUX1_Out : std_logic_vector(31 downto 0);
	signal s_MUX2_Out : std_logic_vector(31 downto 0);
	signal s_MUX3_Out : std_logic_vector(31 downto 0);
	signal s_read_data1 : std_logic_vector(31 downto 0);
	signal s_read_data2 : std_logic_vector(31 downto 0);
	signal s_AddSubOut : std_logic_vector(31 downto 0);
	signal s_MemOut : std_logic_vector(31 downto 0);
	signal s_ZExtendOut : std_logic_vector(31 downto 0);
	signal s_SExtendOut : std_logic_vector(31 downto 0);
	signal s_ReduceTo10Bits : std_logic_vector(9 downto 0);

begin

	--Register File
	RegisterFile: RegFile
		port map(i_CLK => CLK,
			 i_RST => RST,
			 write_en => write_en,
			 read_sel1 => source_reg1,
			 read_sel2 => source_reg2,
			 write_sel => dest_reg,
			 write_data => s_MUX1_Out,
			 read_data1 => s_read_data1,
	      		 read_data2 => s_read_data2,
			 all_registers => all_registers);

	--32 Bit 2:1 MUXes
	MUX1: mux2t1_32bit
		port map(i_D0 => s_AddSubOut,
			 i_D1 => s_MemOut,
			 i_S => write_from_mem,
			 o_O => s_MUX1_Out);

	MUX2: mux2t1_32bit
		port map(i_D0 => s_SExtendOut,
			 i_D1 => s_ZExtendOut,
			 i_S => zeroextend,
			 o_O => s_MUX2_Out);

	MUX3: mux2t1_32bit
		port map(i_D0 => s_read_data2,
			 i_D1 => s_MUX2_Out,
			 i_S => ALUSrc,
			 o_O => s_MUX3_Out);

	--Zero Extender
	ZeroExtenderComponent: ZeroExtender
		port map(input16 => immediate_val,
			 output32 => s_ZExtendOut);

	--Sign Extender
	SignExtend: SignExtender
		port map(input16 => immediate_val,
			 output32 => s_SExtendOut);


	--ALU
	ArithmeticLogicUnit: ALU
		port map(A => s_read_data1,
			 B => s_MUX3_Out,
			 shamt => shamt,
			 ALUControl => ALUControl,
			 ALUOut => s_AddSubOut,
			 zero => zero,
			 ovf => ovf);

	s_ReduceTo10Bits <= s_AddSubOut(9 downto 0);

	--Memory
	dmem: mem
		generic map(DATA_WIDTH => 32,
		    	    ADDR_WIDTH => 10)
		port map(clk => CLK,
		 	 addr => s_ReduceTo10Bits,
		 	 data => s_read_data2,
		 	 we => memwrite_en,
		 	 q => s_MemOut);

end structural;

