library IEEE;
use IEEE.std_logic_1164.all;

entity adder_N is
	generic(N : integer := 16);
	port(i_X : in std_logic_vector(N-1 downto 0);
		i_Y : in std_logic_vector(N-1 downto 0);
		i_Cin : in std_logic;
		o_S : out std_logic_vector(N-1 downto 0);
		o_Cout : out std_logic);
end adder_N;

architecture structural of adder_N is
	component adder is
		port(i_X : in std_logic;
			i_Y : in std_logic;
			i_Cin : in std_logic;
			o_S : out std_logic;
			o_Cout : out std_logic);
	end component;

	--Signal for carry bits
	signal carry : std_logic_vector(N downto 0);

	begin
		carry(0) <= i_Cin; --set first carry bit to external carry input
		
		--N adders
		NBit_Adder: for i in 0 to N-1 generate
			AdderI: adder port map(i_X => i_X(i),
						i_Y => i_Y(i),
						i_Cin => carry(i),
						o_S => o_S(i),
						o_Cout => carry(i+1)); --connect the output carry to the input of the next adder
		end generate NBit_Adder;
		o_Cout <= carry(N);

end structural;
