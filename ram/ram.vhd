library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram is
    port (
        -- rst : in std_logic;
        en : in std_logic;
        clk : in std_logic;
        we : in std_logic; -- write enable
        oe : in std_logic; -- output enable
        addr : in std_logic_vector(7 downto 0);
        data_io : inout std_logic_vector(7 downto 0)
    );
end entity ram;

architecture rtl of ram is
    type ram_type is array(255 downto 0) of std_logic_vector(7 downto 0);
    signal ram_array : ram_type; --  := (others => (others => '0')); -- Clear RAM at startup,
    signal data_in : std_logic_vector(7 downto 0);
    signal data_out : std_logic_vector(7 downto 0);
    type ram_state is (idle, write, read);
    signal state : ram_state := idle;
begin
    process (clk)
    begin
        if falling_edge(clk) then
            if en = '1' then
                if we = '1' then
                    ram_array(to_integer(unsigned(addr))) <= data_in;
                elsif oe = '1' then
                    data_out <= ram_array(to_integer(unsigned(addr)));
                else
                    data_out <= (others => 'Z');
                end if;
            end if;
        end if;
    end process;
    data_in <= data_io;
    data_io <= data_out when oe = '1' else
        (others => 'Z');

    process (we, oe)
    begin
        if we = '1' and oe = '0' then
            state <= write;
        elsif we = '0' and oe = '1' then
            state <= read;
        else
            state <= idle;
        end if;
    end process;

end architecture rtl;

-- architecture rtl of ram is
--     component simple_ram
--         port (
--             addr : in std_logic_vector(7 downto 0);
--             clk : in std_logic;
--             -- rst : in std_logic;
--             we : in std_logic; -- Write Enable
--             data_in : in std_logic_vector(7 downto 0);
--             data_out : out std_logic_vector(7 downto 0)
--         );
--     end component simple_ram;
--     -- type ram_type is array(255 downto 0) of std_logic_vector(7 downto 0);
--     -- signal ram_array : ram_type; -- := (others => (others => '0')); -- Clear RAM at startup,
--     -- signal s_in : std_logic_vector(7 downto 0);
--     -- signal s_out : std_logic_vector(7 downto 0);
--     signal data_in : std_logic_vector(7 downto 0);
--     signal data_out : std_logic_vector(7 downto 0);
-- begin
--     ram_inst : simple_ram
--     port map(
--         addr => addr,
--         clk => clk,
--         -- rst => rst,
--         we => we,
--         data_in => data_in,
--         data_out => data_out
--     );
--     process(data_out, oe)
--     begin
--         if oe = '1' then
--             data_io <= data_out;
--         else
--             data_io <= (others => 'Z');
--         end if;
--     end process;
--     data_in <= data_io;
--     -- data_io <= data_out when oe = '1' else (others => 'Z'); -- output enable
--     -- data_io <= s_out when oe = '1' else (others => 'Z'); -- output enable
--     -- s_in <= data_io;--  when we = '1' else (others => '0'); -- write enable

-- end architecture rtl;