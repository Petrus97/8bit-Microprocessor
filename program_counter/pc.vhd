library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all; -- needed for the + op

-- for printing
use ieee.std_logic_textio.all;
library std;
use std.textio.all;

entity pc is
    port (
        rst : in std_logic;
        clk : in std_logic;
        alu_result : in std_logic_vector(7 downto 0);
        pc_ld : in std_logic;
        pc_inc : in std_logic;
        to_pc_buf : out std_logic_vector(7 downto 0)
    );
end entity pc;

architecture rtl of pc is
    signal pc_address : std_logic_vector(7 downto 0) := (others => '0');
begin
    process (clk)
        variable my_line : line;
    begin
        if rising_edge(clk) then
            if pc_ld = '1' then
                report "pc_ld = 1";
                write(my_line, string'("alu_result = "));
                write(my_line, alu_result);
                writeline(OUTPUT, my_line);
                pc_address <= alu_result;
                -- report "addr_reg <= " & to_string(data);
            elsif pc_inc = '1' then
                pc_address <= pc_address + 1;
            elsif rst = '1' then
                pc_address <= (others => '0');
            end if;
        end if;
    end process;
    to_pc_buf <= pc_address;
end architecture rtl;