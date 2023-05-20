library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
-- https://electronics.stackexchange.com/questions/107183/meaning-of-control-pins-ce-oe-we
entity simple_ram is
    port (
        addr : in std_logic_vector(7 downto 0);
        clk : in std_logic;
        -- rst : in std_logic;
        we : in std_logic; -- Write Enable
        data_in : in std_logic_vector(7 downto 0);
        data_out : out std_logic_vector(7 downto 0)
    );
end entity;

architecture rtl of simple_ram is
    type ram_type is array(255 downto 0) of std_logic_vector(7 downto 0);
    signal ram_array : ram_type;
    -- only for simulation
begin
    process (clk, we) is
    begin
        if rising_edge(clk) then
            if we = '1' then -- mem_write from control unit
                ram_array(to_integer(unsigned(addr))) <= data_in;
            end if;
        end if;
    end process;
    data_out <= ram_array(to_integer(unsigned(addr)));
end architecture;