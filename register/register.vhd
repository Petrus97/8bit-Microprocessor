library ieee;
use ieee.std_logic_1164.all;

package reg_component is
    component addr_buf is
        port(
            -- rst: in std_logic;
            clk: in std_logic;
            addr_oe: in std_logic;
            from_addr: in std_logic_vector(7 downto 0);
            address: out std_logic_vector(7 downto 0)
        );
    end component;

    component addr is 
        port(
            rst: in std_logic;
            clk: in std_logic;
            data: in std_logic_vector(7 downto 0);
            addr_ld: in std_logic;
            addr_inc: in std_logic;
            to_addr_buf: out std_logic_vector(7 downto 0)
        );
    end component;

end package;

package body reg_component is

end package body;
--- end of package
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

use work.reg_component.all;

entity register8bit is 
    port(
        -- rst: in std_logic;
        clk: in std_logic;
        data: in std_logic_vector(7 downto 0); -- receive from the data bus
        addr_oe: in std_logic;
        addr_ld: in std_logic;
        addr_inc: in std_logic;
        address: out std_logic_vector(7 downto 0) -- send to the address bus
    );
end entity register8bit;

architecture rtl of register8bit is
    signal to_addr_buf: std_logic_vector(7 downto 0);
begin
    addr: entity work.addr port map(
        clk => clk,
        data => data,
        addr_ld => addr_ld,
        addr_inc => addr_inc,
        to_addr_buf => to_addr_buf
    );
    addr_buffer: entity work.addr_buf port map(
        clk => clk,
        addr_oe => addr_oe,
        from_addr => to_addr_buf,
        address => address
    );
end architecture rtl;