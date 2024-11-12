library IEEE;
use IEEE.std_logic_1164.all;

entity onescomp is 
	
	generic(N : integer := 16);
	port(i_A : in std_logic_vector(N-1 downto 0);
	     o_F : out std_logic_vector(N-1 downto 0));
	end onescomp;

architecture structure of onescomp is 

	component invg is 
		port(i_A	: in std_logic;
		     o_F	: out std_logic);
        end component;

begin

  NBit_INVERT: for i in 0 to N-1 generate
    INVERTI: invg port map(
              i_A      => i_A(i),      
              o_F      => o_F(i));  
  end generate NBit_INVERT;

end structure;