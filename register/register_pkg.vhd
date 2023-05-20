library ieee;
use ieee.std_logic_1164.all;

package register_pkg is
    component register8bit is
        port (
            rst : in std_logic;
            clk : in std_logic;
            data : in std_logic_vector(7 downto 0); -- receive from the data bus
            addr_oe : in std_logic;
            addr_ld : in std_logic;
            addr_inc : in std_logic;
            address : out std_logic_vector(7 downto 0) -- send to the address bus
        );
    end component register8bit; 
end package register_pkg;

package body register_pkg is
    
end package body register_pkg;