library ieee;
use ieee.std_logic_1164.all;
-- load control unit package
library cu;
use cu.control_unit_pkg.all;
use cu.isa.all;
-- load register package
library reg;
use reg.register_pkg.all;
-- load program counter package
library pc;
use pc.program_counter_pkg.all;
-- load accumulator package
library acc;
use acc.accumulator_pkg.all;
-- load the input mux package
library mux;
use mux.input_mux_pkg.all;

entity microprocessor is
    port (
        clk : in std_logic; -- 50MHz
        rst : in std_logic;
        en : in std_logic; -- enable
        data_in : in std_logic_vector(7 downto 0);
        data_out : out std_logic_vector(7 downto 0);
        address : out std_logic_vector(7 downto 0);
        wr : out std_logic; -- write to memory
        rd : out std_logic; -- read from memory
        step : in std_logic -- step button
    );
end microprocessor;

architecture arch of microprocessor is
    signal data_bus_in : std_logic_vector(7 downto 0);
    signal data_bus_out : std_logic_vector(7 downto 0);
    signal address_bus : std_logic_vector(7 downto 0);
    signal read_mem, write_mem : std_logic;
    signal internal_clk : std_logic;

    -- CU <-> Accumulator signals
    signal z, gt : std_logic; -- zero and greater than flags ALU -> CU
    signal acc_oe : std_logic; -- accumulator output enable
    signal acc_inc : std_logic; -- accumulator increment
    signal acc_ld : std_logic; -- accumulator load
    signal cmp : std_logic; -- comparator
    signal sub : std_logic; -- subtract
    signal add : std_logic; -- add
    signal temp_ld : std_logic; -- temp load
    -- CU <-> PC signals
    signal pc_inc : std_logic; -- program counter increment
    signal pc_ld : std_logic; -- program counter load
    signal pc_oe : std_logic; -- program counter output enable
    signal jpf, jpb : std_logic; -- jump forward and backward
    signal jump_ld : std_logic; -- jump load
    -- CU <-> register signals
    signal addr1_oe : std_logic; -- address 1 output enable
    signal addr1_inc : std_logic; -- address 1 increment
    signal addr1_ld : std_logic; -- address 1 load
    signal addr2_oe : std_logic; -- address 2 output enable
    signal addr2_inc : std_logic; -- address 2 increment
    signal addr2_ld : std_logic; -- address 2 load

    type program is array (0 to 255) of std_logic_vector(7 downto 0);
    signal add_program : program := (
        LD_ADDR1_OP, -- load the address of B
        x"03", -- 
        LD_ADDR2_OP, -- load the address of C
        x"04", --
        LD_ACC_OP, -- move B to ACC
        LD_TEMP_OP, -- move C to TEMP
        LD_ADDR1_OP, -- load the address of A
        x"05", --
        ADD_OP, -- add B and C
        ST_ACC1_OP, -- store the result in A
        others => (others => '0')
    );
begin

    mux : input_mux port map(
        clk => clk,
        step => step,
        en => en,
        clk_out => internal_clk
    );

    CU : control_unit port map(
        clk => internal_clk,
        rst => rst,
        -- step => step,
        data_in => data_bus_in, -- input data
        mem_read => read_mem, -- read from memory signal
        mem_write => write_mem, -- write to memory signal
        -- CU <-> Accumulator signals
        z => z, -- zero flag
        gt => gt, -- greater than flag
        acc_oe => acc_oe, -- output signal output enable
        acc_inc => acc_inc, -- output signal increment
        acc_ld => acc_ld, -- output signal load
        cmp => cmp, -- output signal comparator
        sub => sub, -- output signal subtract
        add => add, -- output signal add
        temp_ld => temp_ld, -- output signal load for temp
        -- CU <-> PC signals
        pc_inc => pc_inc, -- output signal increment
        pc_ld => pc_ld, -- output signal load
        pc_oe => pc_oe, -- output signal output enable
        jpf => jpf, -- output signal jump forward
        jpb => jpb, -- output signal jump backward
        jump_ld => jump_ld, -- output signal load for jump
        -- CU <-> register signals
        addr1_oe => addr1_oe, -- output signal oe
        addr1_inc => addr1_inc, -- output signal increment
        addr1_ld => addr1_ld, -- output signal load
        addr2_oe => addr2_oe, -- output signal oe
        addr2_inc => addr2_inc, -- output signal increment
        addr2_ld => addr2_ld -- output signal load
    );

    acc : accumulator port map(
        clk => internal_clk,
        rst => rst,
        acc_oe => acc_oe, -- input signal output enable
        acc_inc => acc_inc, -- input signal increment
        acc_ld => acc_ld, -- input signal load
        cmp => cmp, -- input signal comparator
        sub => sub, -- input signal subtract
        add => add, -- input signal add
        temp_ld => temp_ld, -- input signal load for temp
        z => z, -- output signal zero
        gt => gt, -- output signal greater than
        data_in => data_bus_in, -- input data
        data_out => data_bus_out -- output data
    );

    pc : program_counter port map(
        clk => internal_clk,
        rst => rst,
        pc_inc => pc_inc, -- input signal increment
        pc_ld => pc_ld, -- input signal load
        pc_oe => pc_oe, -- input signal output enable
        jpf => jpf, -- input signal jump forward
        jpb => jpb, -- input signal jump backward
        jump_ld => jump_ld, -- input signal load for jump
        data_in => data_bus_in, -- input data for jump
        pc_address_out => address_bus -- output address
    );

    reg1 : register8bit port map(
        clk => internal_clk,
        rst => rst,
        data => data_bus_in, -- input data
        addr_oe => addr1_oe, -- input signal oe
        addr_inc => addr1_inc, -- input signal increment
        addr_ld => addr1_ld, -- input signal load
        address => address_bus -- output address
    );

    reg2 : register8bit port map(
        clk => internal_clk,
        rst => rst,
        data => data_bus_in, -- input data
        addr_oe => addr2_oe, -- input signal oe
        addr_inc => addr2_inc, -- input signal increment
        addr_ld => addr2_ld, -- input signal load
        address => address_bus -- output address
    );

    rd <= read_mem;
    wr <= write_mem;
    data_bus_in <= data_in;
    data_out <= data_bus_out when write_mem = '1' else
        (others => '0') when rst = '1' else
        "ZZZZZZZZ";
    address <= address_bus;
end arch;