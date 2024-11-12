-- mux2t1_tb.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the mux2t1 module.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity mux2t1_tb is
end mux2t1_tb;

architecture behavior of mux2t1_tb is

   -- Component declaration for the unit under test (mux2t1)
   component mux2t1
     port(i_D0  : in std_logic;
          i_D1  : in std_logic;
	  i_S   : in std_logic;
	  o_O   : out std_logic);
   end component;

   -- Signals for testbench
   signal s_d0    : std_logic := '0';
   signal s_d1    : std_logic := '0';
   signal s_sel   : std_logic := '0';
   signal s_out   : std_logic;

begin

   -- Instantiate the unit under test (mux2t1)
   DUT0: mux2t1
     port map(i_D0 => s_d0,
              i_D1 => s_d1,
              i_S  => s_sel,
              o_O  => s_out);

   -- Test cases
   mux2t1_proc: process
   begin
     
      s_d0 <= '0';
      s_d1 <= '0';
      s_sel <= '0';
      wait for 100 ns;

      s_d0 <= '0';
      s_d1 <= '0';
      s_sel <= '1';
      wait for 100 ns;

      s_d0 <= '0';
      s_d1 <= '1';
      s_sel <= '0';
      wait for 100 ns;

      s_d0 <= '0';
      s_d1 <= '1';
      s_sel <= '1';
      wait for 100 ns;

      s_d0 <= '1';
      s_d1 <= '0';
      s_sel <= '0';
      wait for 100 ns;

      s_d0 <= '1';
      s_d1 <= '0';
      s_sel <= '1';
      wait for 100 ns;

      s_d0 <= '1';
      s_d1 <= '1';
      s_sel <= '0';
      wait for 100 ns;

      s_d0 <= '1';
      s_d1 <= '1';
      s_sel <= '1';
      wait for 100 ns;

      wait;
   end process;

end behavior;