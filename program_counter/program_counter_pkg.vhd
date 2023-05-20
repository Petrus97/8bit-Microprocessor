library ieee;
use ieee.std_logic_1164.all;

package program_counter_pkg is
    component program_counter is
        port (
            rst : in std_logic;
            clk : in std_logic;
            data_in : in std_logic_vector(7 downto 0);
            jump_ld : in std_logic;
            pc_ld : in std_logic;
            pc_inc : in std_logic;
            pc_oe : in std_logic;
            jpf : in std_logic;
            jpb : in std_logic;
            pc_address_out : out std_logic_vector(7 downto 0)
        );
    end component program_counter;
end package program_counter_pkg;

package body program_counter_pkg is
    
end package body program_counter_pkg;