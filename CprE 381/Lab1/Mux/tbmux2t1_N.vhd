library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_mux2t1_N is
end tb_mux2t1_N;

architecture testbench of tb_mux2t1_N is
  constant N : integer := 16;  -- Number of bits

  signal i_S      : std_logic;
  signal i_D0     : std_logic_vector(N-1 downto 0);
  signal i_D1     : std_logic_vector(N-1 downto 0);
  signal o_O      : std_logic_vector(N-1 downto 0);

begin

  -- Instantiate the mux2t1_N component
  uut: entity work.mux2t1_N
    generic map(N => N)
    port map(
      i_S    => i_S,
      i_D0   => i_D0,
      i_D1   => i_D1,
      o_O    => o_O
    );

  tb_mux2t1_proc: process
  begin
    -- Test case 1: Select input '0' (i_S) should pass i_D0 to o_O
    i_S <= '0';
    i_D0 <= "1010101010101010";  -- 16-bit input
    i_D1 <= "1111111111111111";  -- 16-bit input
    wait for 100 ns;  -- Allow some time for the output to settle
    
    -- Test case 2: Select input '1' (i_S) should pass i_D1 to o_O
    i_S <= '1';
    i_D0 <= "1010101010101010";  -- 16-bit input
    i_D1 <= "1111111111111111";  -- 16-bit input
    wait for 100 ns;  -- Allow some time for the output to settle
    
  end process tb_mux2t1_proc;

end testbench;
