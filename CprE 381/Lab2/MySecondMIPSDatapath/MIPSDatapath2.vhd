library IEEE;
use IEEE.std_logic_1164.all;
use work.bus_array.all;

entity MIPSDatapath2 is
	port(Clk		: in std_logic;
	     Reset		: in std_logic;
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
end MIPSDatapath2;

architecture structural of MIPSDatapath2 is
	component RegisterFile
		port(i_Clk		: in std_logic;
	      	     i_Reset		: in std_logic;
	      	     write_enable	: in std_logic;
	      	     read_select1	: in std_logic_vector(4 downto 0);
	      	     read_select2	: in std_logic_vector(4 downto 0);
	      	     write_select	: in std_logic_vector(4 downto 0);
	      	     write_data		: in std_logic_vector(31 downto 0);
		     read_data1		: out std_logic_vector(31 downto 0);
	      	     read_data2		: out std_logic_vector(31 downto 0);
	      	     all_registers	: out h);
	end component;

	component mux2t1_32bit
		port(i_D0 	: in std_logic_vector(31 downto 0);
	     	     i_D1 	: in std_logic_vector(31 downto 0);
	     	     i_S  	: in std_logic;
	     	     o_O  	: out std_logic_vector(31 downto 0));
	end component;

	component NBitAddSub
		generic(N : integer := 32);
		port(i_A 		: in std_logic_vector(N-1 downto 0);
		     i_B 		: in std_logic_vector(N-1 downto 0);
		     nAdd_Sub 		: in std_logic;
		     o_F 		: out std_logic_vector(N-1 downto 0));
	end component;

	component mem
		generic(DATA_WIDTH : natural := 32;
			ADDR_WIDTH : natural := 10);
		port(clk		: in std_logic;
	     	     addr	        : in std_logic_vector((ADDR_WIDTH-1) downto 0);
	     	     data	        : in std_logic_vector((DATA_WIDTH-1) downto 0);
	     	     we			: in std_logic := '1';
	     	     q			: out std_logic_vector((DATA_WIDTH -1) downto 0));
	end component;

	component ZeroExtender
		port(input : in std_logic_vector(15 downto 0);
	     	     output : out std_logic_vector(31 downto 0));
	end component;

	component SignExtender
		port(input : in std_logic_vector(15 downto 0);
	     	     output : out std_logic_vector(31 downto 0));
	end component;

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

	RegFile: RegisterFile
		port map(i_Clk 		=> Clk,
			 i_Reset 	=> Reset,
			 write_enable 	=> write_enable,
			 read_select1 	=> source_register1,
			 read_select2 	=> source_register2,
			 write_select 	=> dest_register,
			 write_data 	=> s_MUX1_Out,
			 read_data1 	=> s_read_data1,
	      		 read_data2 	=> s_read_data2,
			 all_registers 	=> all_registers);

	MUX1: mux2t1_32bit
		port map(i_D0 		=> s_AddSubOut,
			 i_D1 		=> s_MemOut,
			 i_S 		=> write_from_mem,
			 o_O 		=> s_MUX1_Out);

	MUX2: mux2t1_32bit
		port map(i_D0 		=> s_SExtendOut,
			 i_D1 		=> s_ZExtendOut,
			 i_S 		=> zeroextend,
			 o_O 		=> s_MUX2_Out);

	MUX3: mux2t1_32bit
		port map(i_D0 		=> s_read_data2,
			 i_D1 		=> s_MUX2_Out,
			 i_S 		=> ALUSrc,
			 o_O 		=> s_MUX3_Out);


	ZeroExtenderComponent: ZeroExtender
		port map(input		=> immediate_value,
			 output 	=> s_ZExtendOut);

	
	SignExtend: SignExtender
		port map(input 		=> immediate_value,
			 output 	=> s_SExtendOut);

	
	AdderSubtractor: NBitAddSub
		port map(i_A => s_read_data1,
			 i_B => s_MUX3_Out,
			 nAdd_Sub => nAdd_Sub,
			 o_F => s_AddSubOut);

	s_ReduceTo10Bits <= s_AddSubOut(9 downto 0);

	
	dmem: mem
		generic map(DATA_WIDTH => 32,
		    	    ADDR_WIDTH => 10)
		port map(clk => Clk,
		 	 addr => s_ReduceTo10Bits,
		 	 data => s_read_data2,
		 	 we => memwrite_enable,
		 	 q => s_MemOut);

end structural;