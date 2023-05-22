library ieee;
use ieee.std_logic_1164.all;

entity input_mux is
    port(
        clk : in std_logic;
        en : in std_logic; -- enable clock
        step : in std_logic;
        clk_out : out std_logic
    );
end entity;

architecture rtl of input_mux is
begin
    clk_out <= clk when en = '1' else step;
end architecture;