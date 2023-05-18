library ieee;
use ieee.std_logic_1164.all;

package control_unit_pkg is
    component control_unit is
    port (
        clk : in std_logic;
        rst : in std_logic;
        data_in : in std_logic_vector(7 downto 0); -- get from
        z: in std_logic; -- zero flag from alu
        gt: in std_logic; -- greater than flag from alu
        mem_read : out std_logic; -- send to ram the signal to read
        mem_write : out std_logic; -- send to ram the signal to write
        ACC_OE : out std_logic;
        ACC_INC : out std_logic;
        ACC_LD : out std_logic;
        CMP : out std_logic;
        SUB : out std_logic;
        ADD : out std_logic;
        TEMP_LD : out std_logic;
        PC_OE : out std_logic;
        PC_INC : out std_logic;
        PC_LD : out std_logic;
        JPF : out std_logic;
        JPB : out std_logic;
        JUMP_LD : out std_logic;
        ADDR1_OE : out std_logic;
        ADDR1_INC : out std_logic;
        ADDR1_LD : out std_logic;
        ADDR2_OE : out std_logic;
        ADDR2_INC : out std_logic;
        ADDR2_LD : out std_logic
        -- debug_out : out std_logic_vector(7 downto 0)
    );
    end component;
end control_unit_pkg;

package body control_unit_pkg is
end control_unit_pkg;