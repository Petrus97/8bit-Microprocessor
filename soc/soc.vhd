library ieee;
use ieee.std_logic_1164.all;

library work;
use work.all;
-- use work.display.all;
library micro;
use micro.micro_pkg.all;
library memory;
use memory.ram_pkg.all;

entity soc is
    port (
        CLK : in std_logic;
        RST : in std_logic;
        EN : in std_logic;
        STEP : in std_logic;
        PROG_SELECT : in std_logic;
        address_h : out std_logic_vector(7 downto 0);
        address_l : out std_logic_vector(7 downto 0);
        data_in_h : out std_logic_vector(7 downto 0);
        data_in_l : out std_logic_vector(7 downto 0);
        dout_disp_h : out std_logic_vector(7 downto 0);
        dout_disp_l : out std_logic_vector(7 downto 0)
    );
end soc;

architecture rtl of soc is
    component seven_segment_interface
        port (
            counts : in std_logic_vector(3 downto 0);
            display : out std_logic_vector(7 downto 0)
        );
    end component;

    signal read_mem : std_logic;
    signal write_mem : std_logic;
    signal address : std_logic_vector(7 downto 0);
    signal data_in : std_logic_vector(7 downto 0);
    signal data_out : std_logic_vector(7 downto 0);
    signal step_btn : std_logic;
    signal reset_btn : std_logic;
begin
    reset_btn <= not RST;
    step_btn <= not STEP;
	 
    mp : microprocessor
    port map
    (
        clk => CLK,
        rst => reset_btn,
        en => EN,
        step => step_btn,
        data_in => data_in,
        wr => write_mem,
        rd => read_mem,
        address => address,
        data_out => data_out
    );
    mem : ram
    port map
    (
        rst => reset_btn,
        prog_select => PROG_SELECT,
        clk => CLK,
        we => write_mem,
        oe => read_mem,
        addr => address,
        data_in => data_out,
        data_out => data_in
    );

    b2v_HEX0 : seven_segment_interface
    port map(
        counts => address(7 downto 4),
        display => address_h);
    b2v_HEX1 : seven_segment_interface
    port map(
        counts => address(3 downto 0),
        display => address_l);
    b2v_HEX2 : seven_segment_interface
    port map(
        counts => data_out(7 downto 4),
        display => dout_disp_h);
    b2v_HEX3 : seven_segment_interface
    port map(
        counts => data_out(3 downto 0),
        display => dout_disp_l);
    b2v_HEX4 : seven_segment_interface
    port map(
        counts => data_in(7 downto 4),
        display => data_in_h);
    b2v_HEX5 : seven_segment_interface
    port map(
        counts => data_in(3 downto 0),
        display => data_in_l);
end rtl;