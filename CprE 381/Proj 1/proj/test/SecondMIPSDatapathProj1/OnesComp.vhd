library IEEE;
use IEEE.std_logic_1164.all;

entity OnesComp is
	generic(N : integer := 16);
	port(i_O : in std_logic_vector(N-1 downto 0);
	o_O : out std_logic_vector(N-1 downto 0));
end OnesComp;

architecture structural of OnesComp is

	component invg
		port(i_A : in std_logic;
		o_F : out std_logic);
	end component;

	signal s_O : std_logic_vector(N-1 downto 0);

	begin
		NBit_INV: for i in 0 to N-1 generate
			INVI: invg port map(i_A => i_O(i),
			o_F => s_O(i));
		end generate NBit_INV;
	o_O <= s_O;
end structural;