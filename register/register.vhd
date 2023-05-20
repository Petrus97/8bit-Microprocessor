-- library ieee;
-- use ieee.std_logic_1164.all;

-- package reg_component is
--     component addr_buf is
--         port (
--             -- rst: in std_logic;
--             clk : in std_logic;
--             addr_oe : in std_logic;
--             from_addr : in std_logic_vector(7 downto 0);
--             address : out std_logic_vector(7 downto 0)
--         );
--     end component;

--     component addr is
--         port (
--             rst : in std_logic;
--             clk : in std_logic;
--             data : in std_logic_vector(7 downto 0);
--             addr_ld : in std_logic;
--             addr_inc : in std_logic;
--             to_addr_buf : out std_logic_vector(7 downto 0)
--         );
--     end component;

-- end package;

-- package body reg_component is

-- end package body;
--- end of package
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity register8bit is
    port (
        rst : in std_logic;
        clk : in std_logic;
        data : in std_logic_vector(7 downto 0); -- receive from the data bus
        addr_oe : in std_logic;
        addr_ld : in std_logic;
        addr_inc : in std_logic;
        address : out std_logic_vector(7 downto 0) -- send to the address bus
    );
end entity register8bit;

architecture rtl of register8bit is
    signal addr_buf : std_logic_vector(7 downto 0);
    type cpu_state is (init, fetch, execute);
    signal current_cpu_state : cpu_state;
begin
    state_machine : process (clk, rst)
        variable state : cpu_state := init;
    begin
        if rst = '1' then
            state := init;
        elsif rising_edge(clk) then
            case state is
                when init =>
                    state := fetch;
                when fetch =>
                    state := execute;
                when execute =>
                    state := fetch;
            end case;
        end if;
        current_cpu_state <= state;
    end process state_machine;

    process (clk, rst)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                addr_buf <= (others => '0');
            elsif addr_ld = '1' then
                addr_buf <= data;
            elsif addr_inc = '1' then
                addr_buf <= addr_buf + 1;
            end if;
            -- if addr_oe = '1' then
            --     address <= addr_buf;
            -- else
            --     address <= (others => 'Z');
            -- end if;
        end if;
    end process;
    address <= addr_buf when addr_oe = '1' else (others => 'Z');
end architecture rtl;