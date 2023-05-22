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
-- Generated on "05/22/2023 12:33:53"

-- Vhdl Test Bench template for design  :  input_mux
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

library ieee;
use ieee.std_logic_1164.all;

entity input_mux_vhd_tst is
end input_mux_vhd_tst;
architecture input_mux_arch of input_mux_vhd_tst is
	-- constants                                                 
	constant clk_period : time := 10 ns;
	-- signals                                                   
	signal clk : std_logic;
	signal clk_out : std_logic;
	signal en : std_logic;
	signal step : std_logic;
	component input_mux
		port (
			clk : in std_logic;
			clk_out : out std_logic;
			en : in std_logic;
			step : in std_logic
		);
	end component;
begin
	i1 : input_mux
	port map(
		-- list connections between master ports and signals
		clk => clk,
		clk_out => clk_out,
		en => en,
		step => step
	);
	clk_process : process
		variable half_period : time := clk_period / 2;
	begin
		while now < 5000 ns loop
			clk <= '0';
			wait for half_period;
			clk <= '1';
			wait for half_period;
		end loop;
		wait;
	end process;

	en_process : process
	begin
		en <= '1';
		wait for 2000 ns;
		en <= '0';
		wait for 2000 ns;
		en <= '1';
		wait;
	end process;

	step_process : process
		variable four_period : time := clk_period * 4;
	begin
		while now < 5000 ns loop
			step <= '1';
			wait for four_period;
			step <= '0';
			wait for four_period;
		end loop;
		wait;
	end process;
end input_mux_arch;