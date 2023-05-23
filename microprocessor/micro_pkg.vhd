library ieee;
use ieee.std_logic_1164.all;

package micro_pkg is
    component microprocessor is
        port (
            clk : in std_logic; -- 50MHz
            rst : in std_logic;
            en : in std_logic; -- enable
            -- data : inout std_logic_vector(7 downto 0);
            data_in : in std_logic_vector(7 downto 0);
            data_out : out std_logic_vector(7 downto 0);
            address : out std_logic_vector(7 downto 0);
            wr : out std_logic; -- write to memory
            rd : out std_logic; -- read from memory
            step : in std_logic -- step button
        );
    end component microprocessor;
end package micro_pkg;

package body micro_pkg is
end package body micro_pkg;