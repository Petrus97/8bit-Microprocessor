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
-- Generated on "05/15/2023 14:40:32"

-- Vhdl Test Bench template for design  :  program_counter
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

library ieee;
use ieee.std_logic_1164.all;

entity program_counter_vhd_tst is
end program_counter_vhd_tst;
architecture program_counter_arch of program_counter_vhd_tst is
	-- constants                                                 
	constant PERIOD : time := 10 ns;
	-- signals                                                   
	signal rst : std_logic;
	signal clk : std_logic;
	signal data_in : std_logic_vector(7 downto 0);
	signal jpb : std_logic;
	signal jpf : std_logic;
	signal jump_ld : std_logic;
	signal pc_address_out : std_logic_vector(7 downto 0);
	signal pc_inc : std_logic;
	signal pc_ld : std_logic;
	signal pc_oe : std_logic;
	component program_counter
		port (
			rst : in std_logic;
			clk : in std_logic;
			data_in : in std_logic_vector(7 downto 0);
			jpb : in std_logic;
			jpf : in std_logic;
			jump_ld : in std_logic;
			pc_address_out : out std_logic_vector(7 downto 0);
			pc_inc : in std_logic;
			pc_ld : in std_logic;
			pc_oe : in std_logic
		);
	end component;
begin
	i1 : program_counter
	port map(
		-- list connections between master ports and signals
		rst => rst,
		clk => clk,
		data_in => data_in,
		jpb => jpb,
		jpf => jpf,
		jump_ld => jump_ld,
		pc_address_out => pc_address_out,
		pc_inc => pc_inc,
		pc_ld => pc_ld,
		pc_oe => pc_oe
	);
	clk_process : process
	begin
		while now < 1000 ns loop
			clk <= '1';
			wait for PERIOD / 2;
			clk <= '0';
			wait for PERIOD / 2;
		end loop;
		wait;
	end process;

	pc_stimulus: process
	begin
		data_in <= "00000000";
		jpb <= '0';
		jpf <= '0';
		jump_ld <= '0';
		pc_inc <= '0';
		pc_ld <= '0';
		pc_oe <= '0';
		rst <= '1';
		wait for PERIOD;
		rst <= '0';
		pc_inc <= '1';
		wait for PERIOD;
		pc_inc <= '0';
		pc_oe <= '1';
		wait for PERIOD;
		wait;
	end process;
end program_counter_arch;