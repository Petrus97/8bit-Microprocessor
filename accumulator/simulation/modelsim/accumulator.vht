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
-- Generated on "05/15/2023 22:59:33"

-- Vhdl Test Bench template for design  :  accumulator
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

library ieee;
use ieee.std_logic_1164.all;

entity accumulator_vhd_tst is
end accumulator_vhd_tst;
architecture accumulator_arch of accumulator_vhd_tst is
	-- constants                                                 
	constant PERIOD : time := 10 ns;
	-- signals                                                   
	signal acc_inc : std_logic;
	signal acc_ld : std_logic;
	signal acc_oe : std_logic;
	signal add : std_logic;
	signal clk : std_logic;
	signal cmp : std_logic;
	signal data_in : std_logic_vector(7 downto 0);
	signal data_out : std_logic_vector(7 downto 0);
	signal z : std_logic;
	signal gt : std_logic;
	signal rst : std_logic;
	signal sub : std_logic;
	signal temp_ld : std_logic;
	type acc_op is (LD_TEMP_STATE, LD_ACC_STATE, ST_ACC_STATE, ADD_STATE, SUB_STATE, CMP_STATE, NOOP_STATE);
	signal op : acc_op;
	component accumulator
		port (
			acc_inc : in std_logic;
			acc_ld : in std_logic;
			acc_oe : in std_logic;
			add : in std_logic;
			clk : in std_logic;
			cmp : in std_logic;
			data_in : in std_logic_vector(7 downto 0);
			data_out : out std_logic_vector(7 downto 0);
			z : out std_logic;
			gt : out std_logic;
			rst : in std_logic;
			sub : in std_logic;
			temp_ld : in std_logic
		);
	end component;
begin
	i1 : accumulator
	port map(
		-- list connections between master ports and signals
		acc_inc => acc_inc,
		acc_ld => acc_ld,
		acc_oe => acc_oe,
		add => add,
		clk => clk,
		cmp => cmp,
		data_in => data_in,
		data_out => data_out,
		z => z,
		gt => gt,
		rst => rst,
		sub => sub,
		temp_ld => temp_ld
	);
	clk_process : process
		variable should_reset : boolean := true;
	begin
		while now < 400 ns loop
			if should_reset then
				should_reset := false;
				rst <= '1';
			else
				rst <= '0';
			end if;
			clk <= '1';
			wait for PERIOD / 2;
			clk <= '0';
			wait for PERIOD / 2;
		end loop;
		wait;
	end process;

	acc_stimulus : process
	begin
		acc_inc <= '0';
		acc_ld <= '0';
		acc_oe <= '0';
		add <= '0';
		cmp <= '0';
		sub <= '0';
		temp_ld <= '0';
		wait for PERIOD * 2; -- first execute
		-- load the temp register (simulate LD_TEMP)
		data_in <= "00000100"; -- 4
		temp_ld <= '1';
		wait for PERIOD; --fetch
		temp_ld <= '0';
		wait for PERIOD; -- execute
		-- load the accumulator (simulate LD_ACC)
		acc_ld <= '1';
		data_in <= "00000011"; -- 3
		wait for PERIOD; -- fetch
		acc_ld <= '0';
		wait for PERIOD; -- execute
		-- add the registers
		add <= '1'; -- simulate ADD, should store in the acc_buf 7
		wait for PERIOD; -- fetch
		add <= '0';
		wait for PERIOD; -- execute
		-- output the result (simulate ST_ACC)
		acc_oe <= '1'; -- should output 7
		wait for PERIOD; -- fetch
		acc_oe <= '0';
		wait for PERIOD; -- execute
		-- perform a compare
		cmp <= '1'; -- comparison between acc_buf(7) and temp_buf(4)
		wait for PERIOD; -- fetch
		cmp <= '0';
		wait for PERIOD; -- execute
		-- load the temp register (simulate LD_TEMP)
		data_in <= "00000111"; -- 7
		temp_ld <= '1';
		wait for PERIOD; --fetch
		temp_ld <= '0';
		wait for PERIOD; -- execute
		cmp <= '1'; -- comparison between acc_buf(7) and temp_buf(7)
		wait for PERIOD; -- fetch
		cmp <= '0';
		wait for PERIOD; -- execute

		wait;
	end process acc_stimulus;

	show_op: process(clk, rst)
		variable current_op : acc_op;
	begin
		if rst = '1' then
			current_op := NOOP_STATE;
		elsif rising_edge(clk) then
				if temp_ld = '1' then
					current_op := LD_TEMP_STATE;
				elsif acc_ld = '1' then
					current_op := LD_ACC_STATE;
				elsif acc_oe = '1' then
					current_op := ST_ACC_STATE;
				elsif add = '1' then
					current_op := ADD_STATE;
				elsif sub = '1' then
					current_op := SUB_STATE;
				elsif cmp = '1' then
					current_op := CMP_STATE;
				else
					current_op := NOOP_STATE;
			end if;
		end if;
		op <= current_op;
	end process show_op;
end accumulator_arch;