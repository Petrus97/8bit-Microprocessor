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
        eq : out std_logic; -- equal to 1 if acc = temp else 0
        data_out : out std_logic_vector(7 downto 0)
    );
end entity;

architecture rtl of accumulator is
    signal acc_buf : std_logic_vector(7 downto 0);
    signal temp_reg : std_logic_vector(7 downto 0);
begin
    process (clk, rst)
    begin
        if rst = '1' then
            acc_buf <= (others => '0');
            temp_reg <= (others => '0');
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
                else
                    gt <= '0';
                end if;
                if unsigned(acc_buf) = unsigned(temp_reg) then
                    eq <= '1';
                else
                    eq <= '0';
                end if;
            elsif sub = '1' then
                acc_buf <= std_logic_vector(unsigned(acc_buf) - unsigned(temp_reg));
            elsif add = '1' then
                acc_buf <= std_logic_vector(unsigned(acc_buf) + unsigned(temp_reg));
            end if;
            -- output
            if acc_oe = '1' then
                data_out <= acc_buf;
            end if;
        end if;
    end process;

end architecture;