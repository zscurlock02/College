library IEEE;
use IEEE.std_logic_1164.all;

entity addsub_Nv2 is
	generic(N : integer := 32);
	port(A : in std_logic_vector(N-1 downto 0);
		B : in std_logic_vector(N-1 downto 0);
		nAdd_Sub : in std_logic;
		O : out std_logic_vector(N-1 downto 0));
end addsub_Nv2;

architecture structural of addsub_Nv2 is
	component adder_N
		generic(N : integer := 32);
		port(i_X : in std_logic_vector(N-1 downto 0);
			i_Y : in std_logic_vector(N-1 downto 0);
			i_Cin : in std_logic;
			o_S : out std_logic_vector(N-1 downto 0);
			o_Cout : out std_logic);
	end component;

	component OnesComp
		generic(N : integer := 32);
		port(i_O : in std_logic_vector(N-1 downto 0);
			o_O : out std_logic_vector(N-1 downto 0));
	end component;

	component mux2t1_N
		generic(N : integer := 32);
  		port(i_S : in std_logic;
       			i_D0 : in std_logic_vector(N-1 downto 0);
       			i_D1 : in std_logic_vector(N-1 downto 0);
       			o_O : out std_logic_vector(N-1 downto 0));
	end component;

	--Signals
	signal s_AddOut : std_logic_vector(N-1 downto 0);
	signal s_Inv : std_logic_vector(N-1 downto 0);
	signal s_Sub : std_logic_vector(N-1 downto 0);
	signal s_Subout : std_logic_vector(N-1 downto 0);
	signal zero : std_logic_vector(N-1 downto 0) := (others => '0');

begin

	--Adders
	c_Adder1: adder_N
		generic map(N => N)
		port map(i_X => A,
			 i_Y => B,
			 i_Cin => '0',
			 o_S => s_AddOut,
			 o_Cout => open);

	c_Adder2: adder_N
		generic map(N => N)
		port map(i_X => s_Inv,
			 i_Y => zero,
			 i_Cin => '1',
			 o_S => s_Sub,
			 o_Cout => open);

	c_Adder3: adder_N
		generic map(N => N)
		port map(i_X => A,
			 i_Y => s_Sub,
			 i_Cin => '0',
			 o_S => s_SubOut,
			 o_Cout => open);

	--Inverter
	c_Inverter: OnesComp
		generic map(N => N)
		port map(i_O => B,
			 o_O => s_Inv);

	--MUX
	c_MUX: mux2t1_N
		generic map(N => N)
		port map(i_S => nAdd_Sub,
			 i_D0 => s_AddOut,
			 i_D1 => s_SubOut,
			 o_O => O);

end structural;