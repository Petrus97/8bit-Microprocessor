library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all; -- needed for the + op

entity jump_reg is
    port(
        -- rst: in std_logic;
        clk: in std_logic;
        data_in: in std_logic_vector(7 downto 0);
        jump_ld: in std_logic;
        to_alu: out std_logic_vector(7 downto 0)
    );
end entity jump_reg;

architecture rtl of jump_reg is
    signal reg: std_logic_vector(7 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if jump_ld = '1' then
                reg <= data_in;
            end if;
        end if;
    end process;
	 to_alu <= reg;
end architecture rtl;