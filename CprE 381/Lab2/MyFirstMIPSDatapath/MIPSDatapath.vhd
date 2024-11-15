library IEEE;
use IEEE.std_logic_1164.all;
use work.bus_array.all;

entity MIPSDatapath is
	port(Clk 		: in std_logic;
	     Reset 		: in std_logic;
	     write_enable 	: in std_logic;
	     ALUSrc 		: in std_logic;
	     nAdd_Sub 		: in std_logic;
	     source_register1 	: in std_logic_vector(4 downto 0);
	     source_register2 	: in std_logic_vector(4 downto 0);
	     dest_register 	: in std_logic_vector(4 downto 0);
	     immediate_value 	: in std_logic_vector(31 downto 0);
	     all_registers 	: out h);
end MIPSDatapath;

architecture structural of MIPSDatapath is
	component RegisterFile
		port(i_Clk 	 : in std_logic;
	      	     i_Reset 	 : in std_logic;
	      	     write_enable  : in std_logic;
	      	     read_select1  : in std_logic_vector(4 downto 0);
	      	     read_select2  : in std_logic_vector(4 downto 0);
	      	     write_select  : in std_logic_vector(4 downto 0);
	      	     write_data : in std_logic_vector(31 downto 0);
		     read_data1 : out std_logic_vector(31 downto 0);
	      	     read_data2 : out std_logic_vector(31 downto 0);
	      	     all_registers : out h);
	end component;

	component mux2t1_32bit
		port(i_D0 : in std_logic_vector(31 downto 0);
	     	     i_D1 : in std_logic_vector(31 downto 0);
	     	     i_S  : in std_logic;
	     	     o_O  : out std_logic_vector(31 downto 0));
	end component;

	component NBitAddSub
		generic(N : integer := 32);
		port(i_A 		: in std_logic_vector(N-1 downto 0);
		     i_B 		: in std_logic_vector(N-1 downto 0);
		     nAdd_Sub 		: in std_logic;
		     o_F 		: out std_logic_vector(N-1 downto 0));
	end component;

	--Signals
	signal s_AddSubOutput : std_logic_vector(31 downto 0);
	signal s_read_data1 : std_logic_vector(31 downto 0);
	signal s_read_data2 : std_logic_vector(31 downto 0);
	signal s_MUXout : std_logic_vector(31 downto 0);

begin
	--Register File
	RegFile: RegisterFile
		port map(i_Clk => Clk,
			 i_Reset => Reset,
			 write_enable => write_enable,
			 read_select1 => source_register1,
			 read_select2 => source_register2,
			 write_select => dest_register,
			 write_data => s_AddSubOutput,
			 read_data1 => s_read_data1,
	      		 read_data2 => s_read_data2,
			 all_registers => all_registers);

	--32 Bit 2:1 MUX
	MUX: mux2t1_32bit
		port map(i_D0 => s_read_data2,
			 i_D1 => immediate_value,
			 i_S => ALUSrc,
			 o_O => s_MUXout);

	--Adder/Subtractor
	AdderSubtractor: NBitAddSub
		port map(i_A => s_read_data1,
			 i_B => s_MUXout,
			 nAdd_Sub => nAdd_Sub,
			 o_F => s_AddSubOutput);

end structural;