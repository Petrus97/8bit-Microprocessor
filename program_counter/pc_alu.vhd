library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; -- needed for the + op

entity pc_alu is
    port(
        -- rst: in std_logic;
        jpf: in std_logic;
        jpb: in std_logic;
        pc_address_in: in std_logic_vector(7 downto 0);
        jump_register: in std_logic_vector(7 downto 0);
        pc_address_out: out std_logic_vector(7 downto 0)
    );
end entity pc_alu;

architecture rtl of pc_alu is
signal new_pc_address: std_logic_vector(7 downto 0) := (others => '0');
begin
    process(jpf, jpb, pc_address_in, jump_register)
    begin
        if jpf = '1' then
            new_pc_address <= pc_address_in + jump_register;
        elsif jpb = '1' then
            new_pc_address <= pc_address_in - jump_register;
        end if;
    end process;
    pc_address_out <= new_pc_address;
end architecture rtl;