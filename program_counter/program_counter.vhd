library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
-- use work.pc_component.all;

-- for printing
use ieee.std_logic_textio.all;
library std;
use std.textio.all;

entity program_counter is
    port (
        rst : in std_logic;
        clk : in std_logic;
        data_in : in std_logic_vector(7 downto 0);
        jump_ld : in std_logic;
        pc_ld : in std_logic;
        pc_inc : in std_logic;
        pc_oe : in std_logic;
        jpf : in std_logic;
        jpb : in std_logic;
        pc_address_out : out std_logic_vector(7 downto 0)
    );
end program_counter;

architecture pc_arch of program_counter is
    signal pc_address : std_logic_vector(7 downto 0) := (others => '0');
begin
    process (clk, rst)
        variable jump_register : std_logic_vector(7 downto 0);
    begin
        if rst = '1' then
            jump_register := (others => '0');
            pc_address <= (others => '0');
        elsif rising_edge(clk) then
            if (jump_ld = '1') then
                jump_register := data_in;
            end if;
            if (pc_ld = '1' and jpf = '1') then
                pc_address <= jump_register; -- std_logic_vector(unsigned(pc_address) + unsigned(jump_register));
            elsif (pc_ld = '1' and jpb = '1') then
                pc_address <= jump_register; --std_logic_vector(unsigned(pc_address) - unsigned(jump_register));
            elsif (pc_inc = '1') then
                pc_address <= std_logic_vector(unsigned(pc_address) + 1);
            end if;
        end if;
    end process;
    pc_address_out <= pc_address when pc_oe = '1' else (others => 'Z');
end pc_arch;