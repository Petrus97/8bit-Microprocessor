library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; -- needed for the + op
use ieee.numeric_std.all; -- needed for the + op

-- for printing
use ieee.std_logic_textio.all;
library std;
use std.textio.all;

entity pc_alu is
    port (
        -- rst: in std_logic;
        jpf : in std_logic;
        jpb : in std_logic;
        pc_address_in : in std_logic_vector(7 downto 0);
        jump_register : in std_logic_vector(7 downto 0);
        pc_address_out : out std_logic_vector(7 downto 0)
    );
end entity pc_alu;

architecture rtl of pc_alu is
    signal new_pc_address : std_logic_vector(7 downto 0) := (others => '0');
begin
    process (pc_address_in, jpf, jpb, jump_register)
        variable myline : line;
    begin
        new_pc_address <= pc_address_in;
        report "pc_alu process";
        write(myline, string'("pc_address_in: "));
        write(myline, pc_address_in);
        writeline(output, myline);
        write(myline, string'("jump_register: "));
        write(myline, jump_register);
        writeline(output, myline);
        write(myline, string'("jpf: "));
        write(myline, jpf);
        writeline(output, myline);
        if jpf = '1' then
            report "jpf = 1";
            new_pc_address <= std_logic_vector(unsigned(pc_address_in) + unsigned(jump_register));
            write(myline, string'("new_pc_address: "));
            write(myline, new_pc_address);
            writeline(output, myline);
        elsif jpb = '1' then
            new_pc_address <= pc_address_in - jump_register;
        end if;

    end process;
    pc_address_out <= new_pc_address;
end architecture rtl;