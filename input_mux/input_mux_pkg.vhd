library ieee;
use ieee.std_logic_1164.all;

package input_mux_pkg is
    component input_mux is
        port(
            clk : in std_logic;
            en : in std_logic;
            step : in std_logic;
            clk_out : out std_logic
        );
    end component;
end package input_mux_pkg;

package body input_mux_pkg is
end package body;