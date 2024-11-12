library IEEE;
use IEEE.std_logic_1164.all;
use work.MIPS_types.all;

entity RegFile is
	port (i_CLK 	 : in std_logic;
	      i_RST 	 : in std_logic;
	      write_en   : in std_logic;
	      read_sel1  : in std_logic_vector(4 downto 0);
	      read_sel2  : in std_logic_vector(4 downto 0);
	      write_sel  : in std_logic_vector(4 downto 0);
	      write_data : in std_logic_vector(31 downto 0);
	      read_data1 : out std_logic_vector(31 downto 0);
	      read_data2 : out std_logic_vector(31 downto 0));
end RegFile;

architecture structural of RegFile is
	component decoder5x32
		port (input 	: in std_logic_vector(4 downto 0);
		      enable	: in std_logic;
        	      output 	: out std_logic_vector(31 downto 0));
	end component;

	component mux32x1
		port (inputs : in twodarray;
		      sel    : in std_logic_vector(4 downto 0);
		      output : out std_logic_vector(31 downto 0));
	end component;

	component Reg_N
		generic(N : integer := 32);
		port (write_data 	: in std_logic_vector(N-1 downto 0);
		      write_en 		: in std_logic;
		      i_CLK 		: in std_logic;
		      i_RST 		: in std_logic;
		      read_data 	: out std_logic_vector(N-1 downto 0));
	end component;

	--Signals
	signal s_decoderOut 	: std_logic_vector(31 downto 0);
	signal s_registerReads 	: twodarray;

begin
	--Decoder
	Decoder: decoder5x32
		port map (input  => write_sel,
			  enable => write_en,
			  output => s_decoderOut);

	--Zero Register
	ZeroReg: Reg_N
		port map (write_data => write_data,
			  write_en   => s_decoderOut(0),
			  i_CLK      => i_CLK,
			  i_RST      => '1',
			  read_data  => s_registerReads(0));
	
	--Other 31 Registers
	Registers: for i in 1 to 31 generate
		RegisterI: Reg_N port map (write_data 	=> write_data,
					   write_en   	=> s_decoderOut(i),
					   i_CLK	=> i_CLK,
					   i_RST	=> i_RST,
					   read_data	=> s_registerReads(i));
	end generate Registers;

	--Muxes
	Mux1: mux32x1
		port map (inputs => s_registerReads,
			  sel	 => read_sel1,
			  output => read_data1);

	Mux2: mux32x1
		port map (inputs => s_registerReads,
			  sel	 => read_sel2,
			  output => read_data2);
end structural;