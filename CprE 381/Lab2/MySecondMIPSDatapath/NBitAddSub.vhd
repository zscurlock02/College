library IEEE;
use IEEE.std_logic_1164.all;

entity NBitAddSub is
	generic(N : integer := 32);
	port(i_A : in std_logic_vector(N-1 downto 0);
	     i_B : in std_logic_vector(N-1 downto 0);
	     nAdd_Sub : in std_logic;
	     o_F : out std_logic_vector(N-1 downto 0));
end NBitAddSub;

architecture structural of NBitAddSub is
	component NBitRippleCarryAdder
		generic(N : integer := 32);
		port(i_A	: in std_logic_vector(N-1 downto 0);
		     i_B	: in std_logic_vector(N-1 downto 0);
		     i_Cin	: in std_logic;
		     o_Sum	: out std_logic_vector(N-1 downto 0);
		     o_Cout	: out std_logic);
	end component;

	component onescomp
		generic(N : integer := 32);
		port(i_A	: in std_logic_vector(N-1 downto 0);
		     o_F	: out std_logic_vector(N-1 downto 0));
	end component;

	component mux2t1_N
		generic(N : integer := 32);
  		port(i_S	: in std_logic;
       		     i_D0	: in std_logic_vector(N-1 downto 0);
       		     i_D1	: in std_logic_vector(N-1 downto 0);
       		     o_O	: out std_logic_vector(N-1 downto 0));
	end component;

	signal s_AddOut : std_logic_vector(N-1 downto 0);
	signal s_Inv : std_logic_vector(N-1 downto 0);
	signal s_Sub : std_logic_vector(N-1 downto 0);
	signal s_Subout : std_logic_vector(N-1 downto 0);
	signal zero : std_logic_vector(N-1 downto 0) := (others => '0');

begin


	c_Adder1: NBitRippleCarryAdder
		generic map(N => N)
		port map(i_A => i_A,
			 i_B => i_B,
			 i_Cin => '0',
			 o_Sum => s_AddOut,
			 o_Cout => open);

	c_Adder2: NBitRippleCarryAdder
		generic map(N => N)
		port map(i_A => s_Inv,
			 i_B => zero,
			 i_Cin => '1',
			 o_Sum => s_Sub,
			 o_Cout => open);

	c_Adder3: NBitRippleCarryAdder
		generic map(N => N)
		port map(i_A => i_A,
			 i_B => s_Sub,
			 i_Cin => '0',
			 o_Sum => s_SubOut,
			 o_Cout => open);

	c_Inverter: onescomp
		generic map(N => N)
		port map(i_A => i_B,
			 o_F => s_Inv);

	c_MUX: mux2t1_N
		generic map(N => N)
		port map(i_S => nAdd_Sub,
			 i_D0 => s_AddOut,
			 i_D1 => s_SubOut,
			 o_O => o_F);

end structural;