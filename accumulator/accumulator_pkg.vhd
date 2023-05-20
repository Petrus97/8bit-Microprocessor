library ieee;
use ieee.std_logic_1164.all;

package accumulator_pkg is
    component accumulator is
        port (
            clk : in std_logic;
            rst : in std_logic;
            acc_oe : in std_logic;
            acc_inc : in std_logic;
            acc_ld : in std_logic;
            temp_ld : in std_logic;
            cmp : in std_logic;
            sub : in std_logic;
            add : in std_logic;
            data_in : in std_logic_vector(7 downto 0);
            gt : out std_logic; -- greater than 1 if acc > temp else 0
            z : out std_logic; -- zero 1 if acc = temp else 0
            data_out : out std_logic_vector(7 downto 0)
        );
    end component accumulator; 
end package accumulator_pkg;

package body accumulator_pkg is
    
end package body accumulator_pkg;