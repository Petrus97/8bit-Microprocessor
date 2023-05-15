library ieee;
use ieee.std_logic_1164.all;

entity fetch_execute is
	port(
		clk: in std_logic;
		phase: out std_logic_vector(3 downto 0)
	);

end entity fetch_execute;

architecture rtl of fetch_execute is
	type state is (FETCH, EXECUTE);
	signal current_state: state := FETCH;
	signal phase_reg: std_logic_vector(3 downto 0);
begin
	process(clk)
	begin
		if rising_edge(clk) then
			if current_state = FETCH then
				current_state <= EXECUTE;
				phase_reg <= x"E";
			else
				current_state <= FETCH;
				phase_reg <= x"F";
			end if;
		end if;
	end process;
	phase <= phase_reg;
end architecture rtl;
