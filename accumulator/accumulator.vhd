library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity accumulator is
    port (
        clk : in std_logic;
        rst : in std_logic;
        acc_oe : in std_logic;
        acc_inc : in std_logic;
        acc_ld : in std_logic;
        temp_ld : in std_logic;
        cmp : in std_logic;
        sub : in std_logic;
        add : in std_logic;
        data_in : in std_logic_vector(7 downto 0);
        gt : out std_logic; -- greater than 1 if acc > temp else 0
        z : out std_logic; -- zero 1 if acc = temp else 0
        data_out : out std_logic_vector(7 downto 0)
    );
end entity;

architecture rtl of accumulator is
    signal acc_buf : std_logic_vector(7 downto 0);
    signal temp_reg : std_logic_vector(7 downto 0);
    type cpu_state is (init, fetch, execute);
    signal current_cpu_state : cpu_state;
begin
    process (clk, rst)
    begin
        if rst = '1' then
            acc_buf <= (others => '0');
            temp_reg <= (others => '0');
            gt <= '0';
            z <= '0';
        elsif rising_edge(clk) then
            if acc_ld = '1' then
                acc_buf <= data_in;
            elsif acc_inc = '1' then
                acc_buf <= std_logic_vector(unsigned(acc_buf) + 1);
            elsif temp_ld = '1' then
                temp_reg <= data_in;
                -- check operation
            elsif cmp = '1' then
                if unsigned(acc_buf) > unsigned(temp_reg) then
                    gt <= '1';
                    z <= '0';
                elsif unsigned(acc_buf) = unsigned(temp_reg) then
                    gt <= '0';
                    z <= '1';
                else
                    gt <= '0';
                    z <= '0';
                end if;
            elsif sub = '1' then
                acc_buf <= std_logic_vector(unsigned(acc_buf) - unsigned(temp_reg));
            elsif add = '1' then
                acc_buf <= std_logic_vector(unsigned(acc_buf) + unsigned(temp_reg));
            end if;
            -- output
            if acc_oe = '1' then
                data_out <= acc_buf;
            else
                data_out <= (others => 'Z');
            end if;
        end if;
    end process;

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

end architecture;