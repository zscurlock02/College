-------------------------------------------------------------------------
-- Zach Scurlock
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux2t1_df.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 2 to 1 multiplexer.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux2t1_df is 
	port(i_D1, i_D0 : in std_logic;
	     i_S	: in std_logic;
	     o_O	: out std_logic);
end mux2t1_df;

architecture mux2t1 of mux2t1_df is
	begin
	    o_O <= i_D1 when (i_S = '1') else
	    	   i_D0 when (i_S = '0') else
		   '0';
end mux2t1;

