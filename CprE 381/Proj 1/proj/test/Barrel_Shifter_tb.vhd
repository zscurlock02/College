library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Barrel_Shifter_TB is
end Barrel_Shifter_TB;

architecture sim of Barrel_Shifter_TB is
    -- Component declaration for the Barrel_Shifter entity
    component Barrel_Shifter
        port (
            input   : in std_logic_vector(31 downto 0);
            sType   : in std_logic_vector(1 downto 0);
            shamt   : in std_logic_vector(4 downto 0);
            output  : out std_logic_vector(31 downto 0));
    end component;

    -- Signals for connecting to the Barrel_Shifter entity
    signal input_sig   : std_logic_vector(31 downto 0);
    signal sType_sig   : std_logic_vector(1 downto 0) := "00";
    signal shamt_sig   : std_logic_vector(4 downto 0) := "00000";
    signal output_sig  : std_logic_vector(31 downto 0);

begin
    -- Instantiate the Barrel_Shifter entity
    UUT : Barrel_Shifter
        port map (
            input   => input_sig,
            sType   => sType_sig,
            shamt   => shamt_sig,
            output  => output_sig
        );

    stimulus_process: process
    begin
        -- Test case 1
        input_sig <= x"12345678";
        sType_sig <= "01";
        shamt_sig <= "00001";
        wait for 100 ns;

        -- Test case 2
        input_sig <= x"87654321";
        sType_sig <= "10";
        shamt_sig <= "00010";
        wait for 100 ns;

	-- Test case 3
        input_sig <= x"12345678";
        sType_sig <= "11";
        shamt_sig <= "00011";
        wait for 100 ns;

	-- Test case 4
        input_sig <= x"FEDCBA98";
        sType_sig <= "11";
        shamt_sig <= "00100";
        wait for 100 ns;

        wait;
    end process;
end sim;
