library ieee;
use ieee.std_logic_1164.all;

package ram_pkg is
    component ram is
        port (
            rst : in std_logic;
            prog_select : in std_logic; -- switch to select the program
            clk : in std_logic;
            we : in std_logic; -- write enable
            oe : in std_logic; -- output enable
            addr : in std_logic_vector(7 downto 0);
            data_in : in std_logic_vector(7 downto 0);
            data_out : out std_logic_vector(7 downto 0)
        );
    end component ram;
end package ram_pkg;

package body ram_pkg is

end package body ram_pkg;