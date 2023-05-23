library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package ISA is
    subtype opcode is std_logic_vector(7 downto 0);

    constant NOOP_OP : opcode := "00000000"; -- 0x00
    -- Single byte instructions
    constant CMP_OP : opcode := "00000001"; -- 0x01
    constant ADD_OP : opcode := "00000010"; -- 0x02
    constant SUB_OP : opcode := "00000011"; -- 0x03
    constant JPF_OP : opcode := "00010000"; -- 0x10
    constant JPB_OP : opcode := "00010001"; -- 0x11
    constant JPF_G_OP : opcode := "00010010"; -- 0x12
    constant JPF_Z_OP : opcode := "00010011"; -- 0x13
    constant ST_ACC1_OP : opcode := "10000001"; -- 0x81
    constant ST_ACC2_OP : opcode := "10000010"; -- 0x82
    constant LD_ACC_OP : opcode := "10100000"; -- 0xA0
    constant LD_TEMP_OP : opcode := "10100001"; -- 0xA1

    -- Two byte instructions
    constant LD_JUMPREG_OP : opcode := "10101000"; -- 0xA8
    constant LD_ADDR1_OP : opcode := "10101001"; -- 0xA9
    constant LD_ADDR2_OP : opcode := "10101010"; -- 0xAA
    -- convert the instruction to an opcode
    function get_opcode(instr : std_logic_vector(7 downto 0)) return opcode;
end package;

package body ISA is
    function get_opcode(instr : std_logic_vector(7 downto 0)) return opcode is
    begin
        case instr is
            when "00000001" => return CMP_OP;
            when "00000010" => return ADD_OP;
            when "00000011" => return SUB_OP;
            when "00010000" => return JPF_OP;
            when "00010001" => return JPB_OP;
            when "00010010" => return JPF_G_OP;
            when "00010011" => return JPF_Z_OP;
            when "10000001" => return ST_ACC1_OP;
            when "10000010" => return ST_ACC2_OP;
            when "10100000" => return LD_ACC_OP;
            when "10100001" => return LD_TEMP_OP;
            when "10101000" => return LD_JUMPREG_OP;
            when "10101001" => return LD_ADDR1_OP;
            when "10101010" => return LD_ADDR2_OP;
            when others => return NOOP_OP;
        end case;
    end function;
end ISA;
