library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
-- for printing
use ieee.std_logic_textio.all;
library std;
use std.textio.all;

package utils is
    procedure print (str: in string; sig: in std_logic_vector);
end package utils;

package body utils is

    procedure print (str: in string; sig: in std_logic_vector) is
        variable my_line : line;
    begin
        write(my_line, str);
        write(my_line, sig);
        writeline(output, my_line);
    end procedure print;
end package body utils;