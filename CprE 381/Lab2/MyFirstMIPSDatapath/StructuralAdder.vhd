library IEEE;
use IEEE.std_logic_1164.all;

entity StructuralAdder is

	port(i_A	: in std_logic;
	     i_B	: in std_logic;
             i_Cin	: in std_logic;
	     o_Sum	: out std_logic;
	     o_Cout	: out std_logic);

end StructuralAdder;

architecture structural of StructuralAdder is 
	
	component xorg2
	  port(i_A	: in std_logic;
	       i_B	: in std_logic;
	       o_F	: out std_logic);
	end component;

	component andg2
	  port(i_A	: in std_logic;
	       i_B	: in std_logic;
	       o_F	: out std_logic);
	end component;

	component org2
	  port(i_A	: in std_logic;
	       i_B	: in std_logic;
	       o_F	: out std_logic);
	end component;


	--Signal to carry output of first XOR gate--
	signal s_A	: std_logic;	

	--Signal to carry output of first AND gate--
	signal s_B1	: std_logic;
	--Signal to carry output of second AND gate--
	signal s_B2	: std_logic;



	begin

	-- XOR GATES --

	XOR1: xorg2
	  port MAP(i_A	=> i_A,
		   i_B	=> i_B,
		   o_F	=> s_A);

	XOR2: xorg2
	  port MAP(i_A	=> s_A,
		   i_B	=> i_Cin,
		   o_F	=> o_Sum);

	-- AND GATES --

   	And1: andg2
     	  port MAP(i_A	=> i_Cin,
	      	   i_B	=> s_A,
	      	   o_F	=> s_B1);	

   	And2: andg2
     	  port MAP(i_A	=> i_A,
	      	   i_B	=> i_B,
	      	   o_F	=> s_B2);

	-- OR GATE --

	OR0: org2
	  port MAP(i_A	=> s_B1,
		   i_B	=> s_B2,
		   o_F	=> o_Cout);
end structural;