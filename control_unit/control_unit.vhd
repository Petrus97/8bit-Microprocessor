library ieee;
use ieee.std_logic_1164.all;

use work.isa.all; -- instruction set architecture
use work.utils.all; -- utility functions
entity control_unit is
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
end entity control_unit;

architecture rtl of control_unit is
    type cpu_state is (init, fetch, execute);
    signal current_cpu_state : cpu_state;
    signal current_opcode : opcode;
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
    signal current_instruction : instruction;
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
        variable instr_reg : std_logic_vector(7 downto 0);
    begin
        if current_cpu_state = fetch then
            -- mem_read <= '1'; -- the microprocessor loads an instruction from the memory 
            -- mem_write <= '0'; -- the microprocessor does not write to the memory
            -- location pointed by the Program Counter (PC)
            instr_reg := data_in; -- The instruction is stored in the Instruction Register
            current_opcode <= get_opcode(instr_reg); -- decoded by the Instruction Decoder
            -- print("debug_out: ", current_opcode);

        end if;
    end process fetch_process;

    execute_process : process (current_cpu_state, current_opcode)
    begin
        if current_cpu_state = execute then
            -- In the EXECUTE cycle the Control Unit submits command execution
            -- to sub-modules by issuing control signals
            case current_opcode is
                when CMP_OP =>
                    -- this operation will generate the Z and GT flags
                    ACC_OE <= '0';
                    ACC_INC <= '0';
                    ACC_LD <= '0';
                    CMP <= '1'; -- compare
                    SUB <= '0';
                    ADD <= '0';
                    TEMP_LD <= '0';
                    JPF <= '0';
                    JPB <= '0';
                    JUMP_LD <= '0';
                    ADDR1_OE <= '0';
                    ADDR1_INC <= '0';
                    ADDR1_LD <= '0';
                    ADDR2_OE <= '0';
                    ADDR2_INC <= '0';
                    ADDR2_LD <= '0';
                when ADD_OP =>
                    -- the result of this operation will be stored in the accumulator buffer
                    ACC_OE <= '0';
                    ACC_INC <= '0';
                    ACC_LD <= '0';
                    CMP <= '0';
                    SUB <= '0';
                    ADD <= '1'; -- add
                    TEMP_LD <= '0';
                    JPF <= '0';
                    JPB <= '0';
                    JUMP_LD <= '0';
                    ADDR1_OE <= '0';
                    ADDR1_INC <= '0';
                    ADDR1_LD <= '0';
                    ADDR2_OE <= '0';
                    ADDR2_INC <= '0';
                    ADDR2_LD <= '0';
                when SUB_OP =>
                    -- the result of this operation will be stored in the accumulator buffer
                    ACC_OE <= '0';
                    ACC_INC <= '0';
                    ACC_LD <= '0';
                    CMP <= '0';
                    SUB <= '1'; -- subtract
                    ADD <= '0';
                    TEMP_LD <= '0';
                    JPF <= '0';
                    JPB <= '0';
                    JUMP_LD <= '0';
                    ADDR1_OE <= '0';
                    ADDR1_INC <= '0';
                    ADDR1_LD <= '0';
                    ADDR2_OE <= '0';
                    ADDR2_INC <= '0';
                    ADDR2_LD <= '0';
                when JPF_OP =>
                    -- unconditional jump forward
                    ACC_OE <= '0';
                    ACC_INC <= '0';
                    ACC_LD <= '0';
                    CMP <= '0';
                    SUB <= '0';
                    ADD <= '0';
                    TEMP_LD <= '0';
                    JPF <= '1'; -- jump forward
                    JPB <= '0';
                    JUMP_LD <= '0';
                    ADDR1_OE <= '0';
                    ADDR1_INC <= '0';
                    ADDR1_LD <= '0';
                    ADDR2_OE <= '0';
                    ADDR2_INC <= '0';
                    ADDR2_LD <= '0';
                when JPB_OP =>
                    -- unconditional jump backward
                    ACC_OE <= '0';
                    ACC_INC <= '0';
                    ACC_LD <= '0';
                    CMP <= '0';
                    SUB <= '0';
                    ADD <= '0';
                    TEMP_LD <= '0';
                    JPF <= '0';
                    JPB <= '1'; -- jump backward
                    JUMP_LD <= '0';
                    ADDR1_OE <= '0';
                    ADDR1_INC <= '0';
                    ADDR1_LD <= '0';
                    ADDR2_OE <= '0';
                    ADDR2_INC <= '0';
                    ADDR2_LD <= '0';
                when JPF_G_OP =>
                    -- jump forward if greater
                    ACC_OE <= '0';
                    ACC_INC <= '0';
                    ACC_LD <= '0';
                    CMP <= '0';
                    SUB <= '0';
                    ADD <= '0';
                    TEMP_LD <= '0';
                    JPB <= '0';
                    JUMP_LD <= '0';
                    ADDR1_OE <= '0';
                    ADDR1_INC <= '0';
                    ADDR1_LD <= '0';
                    ADDR2_OE <= '0';
                    ADDR2_INC <= '0';
                    ADDR2_LD <= '0';
                    if status_register = greater then
                        JPF <= '1'; -- jump
                    else
                        JPF <= '0';
                    end if;
                when JPF_Z_OP =>
                    -- jump forward if equal
                    ACC_OE <= '0';
                    ACC_INC <= '0';
                    ACC_LD <= '0';
                    CMP <= '0';
                    SUB <= '0';
                    ADD <= '0';
                    TEMP_LD <= '0';
                    JPB <= '0';
                    JUMP_LD <= '0';
                    ADDR1_OE <= '0';
                    ADDR1_INC <= '0';
                    ADDR1_LD <= '0';
                    ADDR2_OE <= '0';
                    ADDR2_INC <= '0';
                    ADDR2_LD <= '0';
                    if status_register = equal then
                        JPF <= '1'; -- jump
                    else
                        JPF <= '0';
                    end if;
                when ST_ACC1_OP =>
                    -- Write ACC to RAM (pointed by ADR1)
                    ACC_OE <= '0';
                    ACC_INC <= '0';
                    ACC_LD <= '0';
                    CMP <= '0';
                    SUB <= '0';
                    ADD <= '0';
                    TEMP_LD <= '0';
                    JPF <= '0';
                    JPB <= '0';
                    JUMP_LD <= '0';
                    ADDR1_OE <= '1'; -- store ACC1
                    ADDR1_INC <= '0';
                    ADDR1_LD <= '0';
                    ADDR2_OE <= '0';
                    ADDR2_INC <= '0';
                    ADDR2_LD <= '0';
                when ST_ACC2_OP =>
                    -- Write ACC to RAM (pointed by ADR2)
                    ACC_OE <= '0';
                    ACC_INC <= '0';
                    ACC_LD <= '0';
                    CMP <= '0';
                    SUB <= '0';
                    ADD <= '0';
                    TEMP_LD <= '0';
                    JPF <= '0';
                    JPB <= '0';
                    JUMP_LD <= '0';
                    ADDR1_OE <= '0';
                    ADDR1_INC <= '0';
                    ADDR1_LD <= '0';
                    ADDR2_OE <= '1'; -- store ACC2
                    ADDR2_INC <= '0';
                    ADDR2_LD <= '0';
                when LD_ACC_OP =>
                    -- Read the data (pointed by ADR1) to ACC register
                    ACC_OE <= '0';
                    ACC_INC <= '0';
                    ACC_LD <= '1'; -- load ACC
                    CMP <= '0';
                    SUB <= '0';
                    ADD <= '0';
                    TEMP_LD <= '0';
                    JPF <= '0';
                    JPB <= '0';
                    JUMP_LD <= '0';
                    ADDR1_OE <= '0';
                    ADDR1_INC <= '0';
                    ADDR1_LD <= '0';
                    ADDR2_OE <= '0';
                    ADDR2_INC <= '0';
                    ADDR2_LD <= '0';
                when LD_TEMP_OP =>
                    -- Read the data (pointed by ADR2) to TEMP register
                    ACC_OE <= '0';
                    ACC_INC <= '0';
                    ACC_LD <= '0';
                    CMP <= '0';
                    SUB <= '0';
                    ADD <= '0';
                    TEMP_LD <= '1'; -- load TEMP
                    JPF <= '0';
                    JPB <= '0';
                    JUMP_LD <= '0';
                    ADDR1_OE <= '0';
                    ADDR1_INC <= '0';
                    ADDR1_LD <= '0';
                    ADDR2_OE <= '0';
                    ADDR2_INC <= '0';
                    ADDR2_LD <= '0';
                when LD_JUMPREG_OP =>
                    -- Read the data (pointed by the PC+1) to JUMPREG register
                    ACC_OE <= '0';
                    ACC_INC <= '0';
                    ACC_LD <= '0';
                    CMP <= '0';
                    SUB <= '0';
                    ADD <= '0';
                    TEMP_LD <= '0';
                    JPF <= '0';
                    JPB <= '0';
                    JUMP_LD <= '1'; -- load JUMPREG
                    ADDR1_OE <= '0';
                    ADDR1_INC <= '0';
                    ADDR1_LD <= '0';
                    ADDR2_OE <= '0';
                    ADDR2_INC <= '0';
                    ADDR2_LD <= '0';
                when LD_ADDR1_OP =>
                    -- Read the data (pointed by the PC+1) to ADDR1 register
                    ACC_OE <= '0';
                    ACC_INC <= '0';
                    ACC_LD <= '0';
                    CMP <= '0';
                    SUB <= '0';
                    ADD <= '0';
                    TEMP_LD <= '0';
                    JPF <= '0';
                    JPB <= '0';
                    JUMP_LD <= '0';
                    ADDR1_OE <= '0';
                    ADDR1_INC <= '0';
                    ADDR1_LD <= '1'; -- load ADDR1
                    ADDR2_OE <= '0';
                    ADDR2_INC <= '0';
                    ADDR2_LD <= '0';
                when LD_ADDR2_OP =>
                    -- Read the data (pointed by the PC+1) to ADDR2 register
                    ACC_OE <= '0';
                    ACC_INC <= '0';
                    ACC_LD <= '0';
                    CMP <= '0';
                    SUB <= '0';
                    ADD <= '0';
                    TEMP_LD <= '0';
                    JPF <= '0';
                    JPB <= '0';
                    JUMP_LD <= '0';
                    ADDR1_OE <= '0';
                    ADDR1_INC <= '0';
                    ADDR1_LD <= '0';
                    ADDR2_OE <= '0';
                    ADDR2_INC <= '0';
                    ADDR2_LD <= '1'; -- load ADDR2
                when others =>
                    ACC_OE <= '0';
                    ACC_INC <= '0';
                    ACC_LD <= '0';
                    CMP <= '0';
                    SUB <= '0';
                    ADD <= '0';
                    TEMP_LD <= '0';
                    -- PC_OE <= '0';
                    -- PC_INC <= '0';
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
            end case;
            -- check when increment the program counter
            -- In double-length instructions the PC is incremented after the FETCH and EXECUTE cycle
            case current_opcode is
                when LD_JUMPREG_OP =>
                    -- increment the pcand the read from memory to get the address
                    PC_INC <= '1';
                    PC_OE <= '1';
                    mem_read <= '1';
                    mem_write <= '0';
                when LD_ADDR1_OP =>
                    -- increment the pc and the read from memory to get the address
                    PC_INC <= '1';
                    PC_OE <= '1';
                    mem_read <= '1';
                    mem_write <= '0';
                when LD_ADDR2_OP =>
                    -- increment the pc and the read from memory to get the address
                    PC_INC <= '1';
                    PC_OE <= '1';
                    mem_read <= '1';
                    mem_write <= '0';
                when ST_ACC1_OP =>
                    -- enable the write to memory
                    PC_INC <= '0';
                    PC_OE <= '0';
                    mem_read <= '0';
                    mem_write <= '1';
                when ST_ACC2_OP =>
                    -- enable the write to memory
                    PC_INC <= '0';
                    PC_OE <= '0';
                    mem_read <= '0';
                    mem_write <= '1';
                when others =>
                    PC_INC <= '0';
                    PC_OE <= '0';
                    mem_read <= '0';
                    mem_write <= '0';
            end case;
        elsif current_cpu_state = init then
            ACC_OE <= '0';
            ACC_INC <= '0';
            ACC_LD <= '0';
            CMP <= '0';
            SUB <= '0';
            ADD <= '0';
            TEMP_LD <= '0';
            PC_OE <= '0';
            PC_INC <= '0';
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
        elsif current_cpu_state = fetch then
            PC_INC <= '1'; --  The PC gets incremented after the FETCH cycle
            PC_OE <= '1';
            mem_read <= '1';
            mem_write <= '0';
        end if;

    end process execute_process;

    status_upd: process(gt, z)
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
        current_instruction <= debug_instr;
    end process debug_process;

end architecture rtl;

--     elsif rising_edge(clk) then
--         -- instr fetch (on the address bus there should be the program counter at 0)
--         mem_read <= '1';
--         instr_reg := data_in;
--         current_opcode <= get_opcode(instr_reg);
--         -- instr_reg := current_opcode;
--         print("debug_out: ", current_opcode);
--     end if;
--     -- debug_out <= current_opcode;