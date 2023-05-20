library ieee;
use ieee.std_logic_1164.all;

use work.isa.all; -- instruction set architecture
use work.utils.all; -- utility functions
entity control_unit is
    port (
        clk : in std_logic;
        rst : in std_logic;
        data_in : in std_logic_vector(7 downto 0); -- get from memory the instruction
        z : in std_logic; -- zero flag from alu
        gt : in std_logic; -- greater than flag from alu
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
end entity control_unit;

architecture rtl of control_unit is
    type cpu_state is (init, fetch, execute);
    signal current_cpu_state : cpu_state;
    signal current_opcode : opcode;
    signal instr_reg : std_logic_vector(7 downto 0) := (others => '0');
    type instruction is (
        IDLE,
        COMPARE,
        ADDITION,
        SUBTRACT,
        JUMP_FORWARD,
        JUMP_BACKWARD,
        JUMP_FORWARD_GREATER,
        JUMP_FORWARD_ZERO,
        STORE_ACCUMULATOR_1,
        STORE_ACCUMULATOR_2,
        LOAD_ACCUMULATOR,
        LOAD_TEMP,
        LOAD_JUMP_REGISTER,
        LOAD_ADDRESS_1,
        LOAD_ADDRESS_2
    );
    type alu_result is (
        equal, -- z = 1
        greater, -- gt = 1
        less -- z = 0 and gt = 0
    );
    signal status_register : alu_result;
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

    fetch_process : process (current_cpu_state, data_in)
        -- variable instr_reg : std_logic_vector(7 downto 0);
    begin
        if current_cpu_state = fetch then
            -- mem_read <= '1'; -- the microprocessor loads an instruction from the memory 
            -- mem_write <= '0'; -- the microprocessor does not write to the memory
            -- location pointed by the Program Counter (PC)
            instr_reg <= data_in; -- The instruction is stored in the Instruction Register
            -- current_opcode <= get_opcode(instr_reg); -- decoded by the Instruction Decoder
            -- print("debug_out: ", current_opcode);

        end if;
    end process fetch_process;

    execute_process : process (current_cpu_state, current_opcode, status_register)
    begin
        ACC_OE <= '0';
        ACC_INC <= '0';
        ACC_LD <= '0';
        CMP <= '0';
        SUB <= '0';
        ADD <= '0';
        TEMP_LD <= '0';
        PC_INC <= '0';
        PC_OE <= '0';
        PC_LD <= '0';
        JPF <= '0';
        JPB <= '0';
        JUMP_LD <= '0';
        ADDR1_OE <= '0';
        ADDR1_INC <= '0';
        ADDR1_LD <= '0';
        ADDR2_OE <= '0';
        ADDR2_INC <= '0';
        ADDR2_LD <= '0';
        mem_read <= '0';
        mem_write <= '0';

        if current_cpu_state = execute then
            case current_opcode is
                when CMP_OP =>
                    ACC_OE <= '0';
                    CMP <= '1';
                when ADD_OP =>
                    ACC_OE <= '0';
                    ADD <= '1';
                when SUB_OP =>
                    ACC_OE <= '0';
                    SUB <= '1';
                when JPF_OP =>
                    JPF <= '1';
                when JPB_OP =>
                    JPB <= '1';
                when JPF_G_OP =>
                    if status_register = greater then
                        JPF <= '1';
                    end if;
                when JPF_Z_OP =>
                    if status_register = equal then
                        JPF <= '1';
                    end if;
                when ST_ACC1_OP =>
                    ADDR1_OE <= '1';
                    ACC_OE <= '1';
                    mem_write <= '1';
                when ST_ACC2_OP =>
                    ADDR2_OE <= '1';
                    ACC_OE <= '1';
                    mem_write <= '1';
                when LD_ACC_OP =>
                    ACC_LD <= '1';
                    ADDR1_OE <= '1';
                when LD_TEMP_OP =>
                    TEMP_LD <= '1';
                    ADDR2_OE <= '1';
                when LD_JUMPREG_OP =>
                    JUMP_LD <= '1';
                    PC_INC <= '1';
                    PC_OE <= '1';
                    mem_read <= '1';
                when LD_ADDR1_OP =>
                    ADDR1_LD <= '1';
                    PC_INC <= '1';
                    PC_OE <= '1';
                    mem_read <= '1';
                when LD_ADDR2_OP =>
                    ADDR2_LD <= '1';
                    PC_INC <= '1';
                    PC_OE <= '1';
                    mem_read <= '1';
                when others =>
                    null;
            end case;
        elsif current_cpu_state = init then
            null; -- No need to update signals in the init state
        elsif current_cpu_state = fetch then
            PC_INC <= '1';
            PC_OE <= '1';
            mem_read <= '1';
        end if;
    end process execute_process;

    status_upd : process (gt, z)
    begin
        if gt = '1' then
            status_register <= greater;
        elsif z = '1' then
            status_register <= equal;
        else
            status_register <= less;
        end if;
    end process status_upd;

    -- debug process to print the current instruction in the simulation
    debug_process : process (current_opcode)
        variable debug_instr : instruction;
    begin
        case current_opcode is
            when CMP_OP => debug_instr := COMPARE;
            when ADD_OP => debug_instr := ADDITION;
            when SUB_OP => debug_instr := SUBTRACT;
            when JPF_OP => debug_instr := JUMP_FORWARD;
            when JPB_OP => debug_instr := JUMP_BACKWARD;
            when JPF_G_OP => debug_instr := JUMP_FORWARD_GREATER;
            when JPF_Z_OP => debug_instr := JUMP_FORWARD_ZERO;
            when ST_ACC1_OP => debug_instr := STORE_ACCUMULATOR_1;
            when ST_ACC2_OP => debug_instr := STORE_ACCUMULATOR_2;
            when LD_ACC_OP => debug_instr := LOAD_ACCUMULATOR;
            when LD_TEMP_OP => debug_instr := LOAD_TEMP;
            when LD_JUMPREG_OP => debug_instr := LOAD_JUMP_REGISTER;
            when LD_ADDR1_OP => debug_instr := LOAD_ADDRESS_1;
            when LD_ADDR2_OP => debug_instr := LOAD_ADDRESS_2;
                -- Add more cases for other instructions if necessary
            when others => debug_instr := IDLE;
        end case;
    end process debug_process;

    current_opcode <= NOOP_OP when current_cpu_state = init else
        get_opcode(instr_reg);
end architecture rtl;