library IEEE;
use IEEE.std_logic_1164.all;

entity NBitRippleCarryAdder is

	generic(N	: integer := 16);

	port(i_A	: in std_logic_vector(N-1 downto 0);
	     i_B	: in std_logic_vector(N-1 downto 0);
	     i_Cin	: in std_logic;
	     o_Sum	: out std_logic_vector(N-1 downto 0);
	     o_Cout	: out std_logic);

end NBitRippleCarryAdder;

architecture structural of NBitRippleCarryAdder is
	component StructuralAdder is
		port(i_A : in std_logic;
			i_B : in std_logic;
			i_Cin : in std_logic;
			o_Sum : out std_logic;
			o_Cout : out std_logic);
	end component;

	--Signal for carry bits
	signal carry : std_logic_vector(N downto 0);

	begin
		carry(0) <= i_Cin; 
		
		NBit_Adder: for i in 0 to N-1 generate
			Adder: StructuralAdder port map(i_A => i_A(i),
						i_B => i_B(i),
						i_Cin => carry(i),
						o_Sum => o_Sum(i),
						o_Cout => carry(i+1)); 
		end generate NBit_Adder;
		o_Cout <= carry(N);

end structural;