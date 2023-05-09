library ieee;
use ieee.std_logic_1164.all;

entity addr_buf is
    port(
        -- rst: in std_logic;
        clk: in std_logic;
        addr_oe: in std_logic;
        from_addr: in std_logic_vector(7 downto 0);
        address: out std_logic_vector(7 downto 0)
    );
end entity addr_buf;

architecture rtl of addr_buf is

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if addr_oe = '1' then
                address <= from_addr;
            end if;
        -- elsif rst = '1' then
        --    address <= (others => '0');
        end if;
    end process;
end architecture rtl;