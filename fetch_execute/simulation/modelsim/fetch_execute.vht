-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "05/15/2023 13:39:41"

-- Vhdl Test Bench template for design  :  fetch_execute
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

library ieee;
use ieee.std_logic_1164.all;

entity fetch_execute_vhd_tst is
end fetch_execute_vhd_tst;
architecture fetch_execute_arch of fetch_execute_vhd_tst is
  -- constants  

  constant PERIOD : time := 10 ns;
  -- signals                                                   
  signal clk : std_logic;
  signal phase : std_logic_vector(3 downto 0);
  component fetch_execute
    port (
      clk : in std_logic;
      phase : out std_logic_vector(3 downto 0)
    );
  end component;
begin
  i1 : fetch_execute
  port map(
    -- list connections between master ports and signals
    clk => clk,
    phase => phase
  );
  init : process
    -- variable declarations                                     
  begin
    -- code that executes only once                      
    wait;
  end process init;
  always : process
    -- optional sensitivity list                                  
    -- (        )                                                 
    -- variable declarations                                      
  begin
    -- code executes for every event on sensitivity list  
    wait;
  end process always;
end fetch_execute_arch;
library ieee;
use ieee.std_logic_1164.all;

entity fetch_execute_vhd_tst is
end entity fetch_execute_vhd_tst;

architecture sim of fetch_execute_vhd_tst is
  component fetch_execute is
    port (
      clk : in std_logic;
      phase : out std_logic_vector(3 downto 0)
    );
  end component;

  signal clk_tb : std_logic := '0';
  signal phase_tb : std_logic_vector(3 downto 0);

  constant PERIOD : time := 10 ns;

begin
  dut : fetch_execute
  port map(
    clk => clk_tb,
    phase => phase_tb
  );

  clk_process : process
  begin
    while now < 1000 ns loop
      clk_tb <= '1';
      wait for PERIOD / 2;
      clk_tb <= '0';
      wait for PERIOD / 2;
    end loop;
    wait;
  end process;

  stim_process : process
  begin
    wait for PERIOD;
    for i in 0 to 7 loop
      wait until rising_edge(clk_tb);
      assert phase_tb = "1110" report "Phase is not as expected" severity error;
      wait until rising_edge(clk_tb);
      assert phase_tb = "1111" report "Phase is not as expected" severity error;
    end loop;
    wait;
  end process;

end architecture sim;