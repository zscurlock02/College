library IEEE;
use IEEE.std_logic_1164.all;
use work.bus_array.all;

entity RegisterFile is

	port (i_Clk 	 : in std_logic;
	      i_Reset 	 : in std_logic;
	      write_enable   : in std_logic;
	      read_select1  : in std_logic_vector(4 downto 0);
	      read_select2  : in std_logic_vector(4 downto 0);
	      write_select  : in std_logic_vector(4 downto 0);
	      write_data    : in std_logic_vector(31 downto 0);
	      read_data1 : out std_logic_vector(31 downto 0);
	      read_data2 : out std_logic_vector(31 downto 0);
	      all_registers : out h);

end RegisterFile;

architecture structural of RegisterFile is
	component Decoder5to32
		port (input 	: in std_logic_vector(4 downto 0);
		      enable	: in std_logic;
        	      output 	: out std_logic_vector(31 downto 0));
	end component;

	component mux32x1
		port (input  : in h;
		      sel    : in std_logic_vector(4 downto 0);
		      output : out std_logic_vector(31 downto 0));
	end component;

	component NBitReg
		generic(N : integer := 32);
		port (i_WData	: in std_logic_vector(N-1 downto 0);
		      i_Write		: in std_logic;
		      i_Clk 		: in std_logic;
		      i_Reset 		: in std_logic;
		      o_ReadData 	: out std_logic_vector(N-1 downto 0));
	end component;

	--Signals
	signal s_decoderOut 	: std_logic_vector(31 downto 0);
	signal s_registerReads 	: h;

begin
	--Decoder
	Decoder: Decoder5to32
		port map (input  => write_select,
			  enable => write_enable,
			  output => s_decoderOut);

	--Zero Register
	ZeroReg: NBitReg
		port map (i_WData => write_data,
			  i_Write   => s_decoderOut(0),
			  i_Clk      => i_Clk,
			  i_Reset      => '1',
			  o_ReadData  => s_registerReads(0));
	
	--Other 31 Registers
	Registers: for i in 1 to 31 generate
		RegisterI: NBitReg port map (i_WData	=> write_data,
					   i_Write   	=> s_decoderOut(i),
					   i_Clk	=> i_Clk,
					   i_Reset	=> i_Reset,
					   o_ReadData	=> s_registerReads(i));
	end generate Registers;

	--Muxes
	Mux1: mux32x1
		port map (input  => s_registerReads,
			  sel	 => read_select1,
			  output => read_data1);

	Mux2: mux32x1
		port map (input  => s_registerReads,
			  sel	 => read_select2,
			  output => read_data2);

	all_registers <= s_registerReads;
end structural;