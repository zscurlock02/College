-------------------------------------------------------------------------
-- Zach Scurlock
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux2t1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 2 to 1 multiplexer.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux2t1 is

   port(i_D0	: in std_logic;
        i_D1	: in std_logic;
	i_S	: in std_logic;
	o_O	: out std_logic);

end mux2t1;

architecture dataflow of mux2t1 is

   component andg2
     port(i_A		:in std_logic;
	  i_B		:in std_logic;
	  o_F		:out std_logic);
   end component;

   component org2
     port(i_A		:in std_logic;
	  i_B		:in std_logic;
	  o_F		:out std_logic);
   end component;

   component invg
     port(i_A		:in std_logic;
	  o_F		:out std_logic);
   end component;


   --Signal to carry output of first and gate
   signal s_A1    :std_logic;
   --Signal to carry output of second and gate
   signal s_A2    :std_logic;
   --Signal to carry output of first not gate
   signal s_N     :std_logic;
 

   begin

   -- AND GATES --

   And1: andg2
     port MAP(i_A	=> i_D0,
	      i_B	=> s_N,
	      o_F	=> s_A1);	

   And2: andg2
     port MAP(i_A	=> i_D1,
	      i_B	=> i_S,
	      o_F	=> s_A2);

   -- NOT GATE --

   Not0: invg
     port MAP(i_A	=> i_S,
	      o_F	=> s_N);

   -- OR GATE --

   OR0: org2
     port MAP(i_A	=> s_A1,
              i_B	=> s_A2,
	      o_F	=> o_O);

end dataflow;
