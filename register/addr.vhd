library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all; -- needed for the + op

entity addr is
    port(
        -- rst: in std_logic;
        clk: in std_logic;
        data: in std_logic_vector(7 downto 0);
        addr_ld: in std_logic;
        addr_inc: in std_logic;
        to_addr_buf: out std_logic_vector(7 downto 0)
    );
end entity addr;

architecture rtl of addr is
    signal addr_reg: std_logic_vector(7 downto 0);
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if addr_ld = '1' then
                to_addr_buf <= data;
                -- report "addr_reg <= " & to_string(data);
            elsif addr_inc = '1' then
                to_addr_buf <= addr_reg + 1;
            end if;
        end if;
    end process;
end architecture rtl;