library IEEE;
use IEEE.std_logic_1164.all;

entity NBitAddSub is
	generic(N : integer := 16);
	port(i_A	: in std_logic_vector(N-1 downto 0);
	     i_B	: in std_logic_vector(N-1 downto 0);
	     nAdd_Sub	: in std_logic;
	     o_F	: out std_logic_vector(N-1 downto 0));
end NBitAddSub;

architecture structural of NBitAddSub is
	component NBitRippleCarryAdder
		generic(N : integer := 16);
		port(i_A	: in std_logic_vector(N-1 downto 0);
		     i_B	: in std_logic_vector(N-1 downto 0);
		     i_Cin	: in std_logic;
		     o_Sum	: out std_logic_vector(N-1 downto 0);
		     o_Cout	: out std_logic);
	end component;

	component onescomp
		generic(N : integer := 16);
		port(i_A	: in std_logic_vector(N-1 downto 0);
		     o_F	: out std_logic_vector(N-1 downto 0));
	end component;

	component mux2t1_N
		generic(N : integer := 16);
  		port(i_S : in std_logic;
       		     i_D0 : in std_logic_vector(N-1 downto 0);
       		     i_D1 : in std_logic_vector(N-1 downto 0);
       		     o_O : out std_logic_vector(N-1 downto 0));
	end component;

	--Signals--
	signal s_nAdd : std_logic_vector(N-1 downto 0);
	signal s_Inverter1 : std_logic_vector(N-1 downto 0);
	signal s_Inverter2 : std_logic_vector(N-1 downto 0);
	signal s_Adder1 : std_logic_vector(N-1 downto 0);
	signal s_Adder2 : std_logic_vector(N-1 downto 0);
	signal s_nSubtractor : std_logic_vector(N-1 downto 0);
	signal s_Cout : std_logic;
	signal output : std_logic_vector(N-1 downto 0);
	signal zero : std_logic_vector(N-1 downto 0) := (others => '0');

begin
	--Adders--
	c_Adder1: NBitRippleCarryAdder
		generic map(N => N)
		port map(i_A => i_A,
			 i_B => i_B,
			 i_Cin => '0',
			 o_Sum => s_nAdd,
			 o_Cout => open);

	c_Adder2: NBitRippleCarryAdder
		generic map(N => N)
		port map(i_A => i_A,
			 i_B => s_Inverter1,
			 i_Cin => '0',
			 o_Sum => s_Adder1,
			 o_Cout => s_Cout);

	c_Adder3: NBitRippleCarryAdder
		generic map(N => N)
		port map(i_A => s_Adder1,
			 i_B => zero,
			 i_Cin => '1',
			 o_Sum => s_Adder2,
			 o_Cout => open);

	--Inverters--
	c_Inverter1: OnesComp
		generic map(N => N)
		port map(i_A => i_B,
			 o_F => s_Inverter1);

	c_Inverter2: OnesComp
		generic map(N => N)
		port map(i_A => s_Adder1,
			 o_F => s_Inverter2);

	--Multiplexers--
	c_MUX1: mux2t1_N
		generic map(N => N)
		port map(i_S => s_Cout,
			 i_D0 => s_Inverter2,
			 i_D1 => s_Adder2,
			 o_O => s_nSubtractor);

	c_MUX2: mux2t1_N
		generic map(N => N)
		port map(i_S => nAdd_Sub,
			 i_D0 => s_nAdd,
			 i_D1 => s_nSubtractor,
			 o_O => output);

o_F <= output;

end structural;