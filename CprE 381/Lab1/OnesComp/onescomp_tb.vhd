library IEEE;
use IEEE.std_logic_1164.all;

entity onescomp_tb is
end onescomp_tb;

architecture testbench of onescomp_tb is
  constant N: integer := 32;

  signal i_A	: std_logic_vector(N-1 downto 0);
  signal o_F	: std_logic_vector(N-1 downto 0);

begin

  DUT0: entity work.onescomp
    generic map(N => 32)
    port map(
      i_A    => i_A,
      o_F    => o_F
    );

  onescomp_tb_proc: process
  begin

   -- Test 1 -- 
   i_A <= "00000000000000000000000000000000";
   wait for 100 ns;

   -- Test 2 --
   i_A <= "10101010101010101010101010101010";
   wait for 100 ns;

   -- Test 3 --
   i_A <= "00001111000011110000111100001111";
   wait for 100 ns;

   -- Test 4 --
   i_A <= "11111111111111111111111111111111";
   wait for 100 ns;

  end process onescomp_tb_proc;

end testbench; 