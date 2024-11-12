library IEEE;
use IEEE.std_logic_1164.all;

entity adder is
	port(i_X : in std_logic;
		i_Y : in std_logic;
		i_Cin : in std_logic;
		o_S : out std_logic;
		o_Cout : out std_logic);
end adder;

architecture structure of adder is
	component xorg2
		port(i_A : in std_logic;
			i_B : in std_logic;
			o_F : out std_logic);
	end component;

	component andg2
		port(i_A : in std_logic;
			i_B : in std_logic;
			o_F : out std_logic);
	end component;

	component org2
		port(i_A : in std_logic;
			i_B : in std_logic;
			o_F : out std_logic);
	end component;
	
	--Signal to carry output of first XOR
	signal s_XOR : std_logic;
	--Signals to carry and gate outputs
	signal s_A1 : std_logic;
	signal s_A2 : std_logic;

	begin
		--XOR Gates
		g_XOR1: xorg2
			port MAP(i_A => i_X,
				i_B => i_Y,
				o_F => s_XOR);

		g_XOR2: xorg2
			port MAP(i_A => s_XOR,
				i_B => i_Cin,
				o_F => o_S);

		--AND Gates
		g_AND1: andg2
			port MAP(i_A => s_XOR,
				i_B => i_Cin,
				o_F => s_A1);

		g_AND2: andg2
			port MAP(i_A => i_X,
				i_B => i_Y,
				o_F => s_A2);

		--OR Gate
		g_OR: org2
			port MAP(i_A => s_A1,
				i_B => s_A2,
				o_F => o_Cout);

end structure;