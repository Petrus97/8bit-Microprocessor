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
-- Generated on "05/16/2023 19:27:51"

-- Vhdl Test Bench template for design  :  control_unit
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.isa.all;

entity control_unit_vhd_tst is
end control_unit_vhd_tst;
architecture control_unit_arch of control_unit_vhd_tst is
	-- constants                                                 
	constant PERIOD : time := 10 ns;
	-- signals                                                   
	signal ACC_INC : std_logic;
	signal ACC_LD : std_logic;
	signal ACC_OE : std_logic;
	signal ADDR1_INC : std_logic;
	signal ADDR1_LD : std_logic;
	signal ADDR1_OE : std_logic;
	signal ADDR2_INC : std_logic;
	signal ADDR2_LD : std_logic;
	signal ADDR2_OE : std_logic;
	signal clk : std_logic;
	signal CMP : std_logic;
	signal data_in : std_logic_vector(7 downto 0);
	signal debug_out : std_logic_vector(7 downto 0);
	signal JPB : std_logic;
	signal JPF : std_logic;
	signal JUMP_LD : std_logic;
	signal mem_read : std_logic;
	signal mem_write : std_logic;
	signal PC_INC : std_logic;
	signal PC_LD : std_logic;
	signal PC_OE : std_logic;
	signal rst : std_logic;
	signal SUB : std_logic;
	signal ADD : std_logic;
	signal TEMP_LD : std_logic;
	signal z : std_logic;
	signal gt : std_logic;
	component control_unit
		port (
			ACC_INC : out std_logic;
			ACC_LD : out std_logic;
			ACC_OE : out std_logic;
			ADDR1_INC : out std_logic;
			ADDR1_LD : out std_logic;
			ADDR1_OE : out std_logic;
			ADDR2_INC : out std_logic;
			ADDR2_LD : out std_logic;
			ADDR2_OE : out std_logic;
			clk : in std_logic;
			CMP : out std_logic;
			data_in : in std_logic_vector(7 downto 0);
			debug_out : out std_logic_vector(7 downto 0);
			JPB : out std_logic;
			JPF : out std_logic;
			JUMP_LD : out std_logic;
			mem_read : out std_logic;
			mem_write : out std_logic;
			PC_INC : out std_logic;
			PC_LD : out std_logic;
			PC_OE : out std_logic;
			rst : in std_logic;
			SUB : out std_logic;
			ADD : out std_logic;
			TEMP_LD : out std_logic;
			z: in std_logic;
			gt: in std_logic
		);
	end component;

	signal current_pc : integer := 0;
	-- type program is array (0 to 255) of std_logic_vector(7 downto 0);
	-- signal add_program : program := (
	-- 	LD_ADDR1_OP, -- load the address of B
	-- 	x"03", -- 
	-- 	LD_ADDR2_OP, -- load the address of C
	-- 	x"04", --
	-- 	LD_ACC_OP, -- move B to ACC
	-- 	LD_TEMP_OP, -- move C to TEMP
	-- 	LD_ADDR1_OP, -- load the address of A
	-- 	x"05", --
	-- 	ADD_OP, -- add B and C
	-- 	ST_ACC_OP, -- store the result in A
	-- );
begin
	i1 : control_unit
	port map(
		-- list connections between master ports and signals
		ACC_INC => ACC_INC,
		ACC_LD => ACC_LD,
		ACC_OE => ACC_OE,
		ADDR1_INC => ADDR1_INC,
		ADDR1_LD => ADDR1_LD,
		ADDR1_OE => ADDR1_OE,
		ADDR2_INC => ADDR2_INC,
		ADDR2_LD => ADDR2_LD,
		ADDR2_OE => ADDR2_OE,
		clk => clk,
		CMP => CMP,
		data_in => data_in,
		debug_out => debug_out,
		JPB => JPB,
		JPF => JPF,
		JUMP_LD => JUMP_LD,
		mem_read => mem_read,
		mem_write => mem_write,
		PC_INC => PC_INC,
		PC_LD => PC_LD,
		PC_OE => PC_OE,
		rst => rst,
		SUB => SUB,
		ADD => ADD,
		TEMP_LD => TEMP_LD,
		z => z,
		gt => gt
	);
	clk_process : process
	begin
		while now < 400 ns loop
			clk <= '1';
			wait for PERIOD / 2;
			clk <= '0';
			wait for PERIOD / 2;
		end loop;
		wait;
	end process;

	stimulus : process
		-- optional sensitivity list                                  
		-- (        )                                                 
		-- variable declarations                                      
	begin
		rst <= '1';
		wait for PERIOD;
		rst <= '0';
		data_in <= LD_ADDR2_OP;
		wait for PERIOD * 2;
		data_in <= LD_ADDR1_OP;
		wait for PERIOD * 2;
		data_in <= LD_ACC_OP;
		wait for PERIOD * 2;
		data_in <= LD_TEMP_OP;
		wait for PERIOD * 2;
		data_in <= CMP_OP;
		wait for PERIOD * 2;
		data_in <= ADD_OP;
		wait for PERIOD * 2;
		data_in <= SUB_OP;
		wait for PERIOD * 2;
		data_in <= JPF_OP;
		wait for PERIOD * 2;
		data_in <= JPB_OP;
		wait for PERIOD * 2;
		data_in <= ST_ACC1_OP;
		wait for PERIOD * 2;
		data_in <= ST_ACC2_OP;
		wait for PERIOD * 2;
		data_in <= LD_JUMPREG_OP;
		wait for PERIOD * 2;
		wait;
	end process stimulus;

	pc_sim: process(clk, rst)
		variable PC : integer := 0;
	begin
		if rst = '1' then
			PC := 0;
		elsif rising_edge(clk) then
			if PC_LD = '1' then
				PC := to_integer(unsigned(debug_out));
			elsif PC_INC = '1' then
				PC := PC + 1;
			end if;
		end if;
		current_pc <= PC;
	end process pc_sim;
end control_unit_arch;