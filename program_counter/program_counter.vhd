library ieee;
use ieee.std_logic_1164.all;

package pc_component is
    component jump_reg is
        port (
            -- rst : in std_logic;
            clk : in std_logic;
            data_in : in std_logic_vector(7 downto 0);
            jump_ld : in std_logic;
            to_alu : out std_logic_vector(7 downto 0)
        );
    end component;

    component pc is
        port (
            -- rst: in std_logic;
            clk : in std_logic;
            alu_result : in std_logic_vector(7 downto 0);
            pc_ld : in std_logic;
            pc_inc : in std_logic;
            to_pc_buf : out std_logic_vector(7 downto 0)
        );
    end component;

    component pc_alu is
        port (
            -- rst: in std_logic;
            jpf : in std_logic;
            jpb : in std_logic;
            pc_address_in : in std_logic_vector(7 downto 0);
            jump_register : in std_logic_vector(7 downto 0);
            pc_address_out : out std_logic_vector(7 downto 0)
        );
    end component;

    component pc_buf is
        port (
            -- rst: in std_logic;
            clk : in std_logic;
            pc_oe : in std_logic;
            pc_address_in : in std_logic_vector(7 downto 0);
            pc_address_out : out std_logic_vector(7 downto 0)
        );
    end component;

end package;

package body pc_component is
end package body;
-- end of pc_component package


library ieee;
use ieee.std_logic_1164.all;
use work.pc_component.all;

entity program_counter is
    port (
        -- rst: in std_logic;
        clk : in std_logic;
        data_in : in std_logic_vector(7 downto 0);
        jump_ld : in std_logic;
        pc_ld : in std_logic;
        pc_inc : in std_logic;
        pc_oe : in std_logic;
        jpf : in std_logic;
        jpb : in std_logic;
        pc_address_out : out std_logic_vector(7 downto 0)
    );
end program_counter;

architecture pc_arch of program_counter is
    signal jmp_alu : std_logic_vector(7 downto 0);
    signal alu_result : std_logic_vector(7 downto 0);
    signal pc_address_in : std_logic_vector(7 downto 0);
    signal pc_address_out_buf : std_logic_vector(7 downto 0);
begin
    jump_reg_inst : entity work.jump_reg
        port map (
            -- rst => rst,
            clk => clk,
            data_in => data_in, -- in from data bus
            jump_ld => jump_ld, -- in from control
            to_alu => jmp_alu -- out to alu
        );

    pc_inst : entity work.pc
        port map (
            -- rst => rst,
            clk => clk,
            alu_result => alu_result, -- in from alu
            pc_ld => pc_ld, -- in from control
            pc_inc => pc_inc, -- in from control
            to_pc_buf => pc_address_in -- out to pc_buf and alu
        );

    pc_alu_inst : entity work.pc_alu
        port map (
            -- rst => rst,
            jpf => jpf, -- in from control
            jpb => jpb, -- in from control
            pc_address_in => pc_address_in, -- in from pc
            jump_register => jmp_alu, -- in from jump_reg
            pc_address_out => alu_result -- out to pc
        );

    pc_buf_inst : entity work.pc_buf
        port map (
            -- rst => rst,
            clk => clk,
            pc_oe => pc_oe, -- in from control
            pc_address_in => pc_address_in, -- in from pc
            pc_address_out => pc_address_out_buf -- out to address bus
        );

    pc_address_out <= pc_address_out_buf;
end pc_arch;
