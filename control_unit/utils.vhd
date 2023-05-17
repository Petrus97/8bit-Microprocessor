library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
-- for printing
use ieee.std_logic_textio.all;
library std;
use std.textio.all;

package utils is
    -- function to_string (signal s: in std_logic_vector) return string;

    procedure print (str: in string; sig: in std_logic_vector);
end package utils;

package body utils is
    -- function to_string (signal s: in std_logic_vector) return string is
    --     variable result : string (1 to s'length);
    -- begin
    --     for i in s'range loop
    --         result(i) := character'val(to_integer(unsigned(s(i))));
    --     end loop;
    --     return result;
    -- end function to_string;

    procedure print (str: in string; sig: in std_logic_vector) is
        variable my_line : line;
    begin
        write(my_line, str);
        write(my_line, sig);
        writeline(output, my_line);
    end procedure print;
end package body utils;