library ieee;
use ieee.std_logic_1164.all;

entity pc_buf is
    port(
        -- rst: in std_logic;
        clk: in std_logic;
        pc_oe: in std_logic;
        pc_address_in: in std_logic_vector(7 downto 0);
        pc_address_out: out std_logic_vector(7 downto 0)
    );
end entity pc_buf;

architecture rtl of pc_buf is

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if pc_oe = '1' then
                pc_address_out <= pc_address_in;
            end if;
        -- elsif rst = '1' then
        --    address <= (others => '0');
        end if;
    end process;
end architecture rtl;