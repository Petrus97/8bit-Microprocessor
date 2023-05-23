library ieee;
use ieee.std_logic_1164.all;

entity seven_segment_interface is
        port (
                counts : in std_logic_vector(3 downto 0);
                display : out std_logic_vector(7 downto 0)
        );
end entity seven_segment_interface;

architecture behave of seven_segment_interface is
begin
        process (counts) begin
                case counts is
                        when "0000" => display <= "00000001";
                        when "0001" => display <= "01001111";
                        when "0010" => display <= "00010010";
                        when "0011" => display <= "00000110";
                        when "0100" => display <= "01001100";
                        when "0101" => display <= "00100100";
                        when "0110" => display <= "00100000";
                        when "0111" => display <= "00001111";
                        when "1000" => display <= "00000000";
                        when "1001" => display <= "00000100";
                        when "1010" => display <= "00001000";
                        when "1011" => display <= "01100000";
                        when "1100" => display <= "00110001";
                        when "1101" => display <= "01000010";
                        when "1110" => display <= "00110000";
                        when "1111" => display <= "00111000";
                        when others => display <= "00000000";
                end case;
        end process;
end behave;