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
-- Generated on "05/20/2023 18:14:36"

-- Vhdl Test Bench template for design  :  microprocessor
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library cu;
use cu.control_unit_pkg.all;
use cu.isa.all;

entity microprocessor_vhd_tst is
end microprocessor_vhd_tst;
architecture microprocessor_arch of microprocessor_vhd_tst is
	-- constants                                                 
	constant PERIOD : time := 10 ns;
	-- signals                                                   
	signal address : std_logic_vector(7 downto 0);
	signal clk : std_logic;
	signal data_in : std_logic_vector(7 downto 0);
	signal data_out : std_logic_vector(7 downto 0);
	signal rd : std_logic;
	signal rst : std_logic;
	signal step : std_logic;
	signal wr : std_logic;
	component microprocessor
		port (
			address : out std_logic_vector(7 downto 0);
			clk : in std_logic;
			-- data : inout std_logic_vector(7 downto 0);
			data_in : in std_logic_vector(7 downto 0);
			data_out : out std_logic_vector(7 downto 0);
			rd : out std_logic;
			rst : in std_logic;
			step : in std_logic;
			wr : out std_logic
		);
	end component;

	type program is array (0 to 255) of std_logic_vector(7 downto 0);
	signal add_program : program := (
		LD_ADDR1_OP, -- load the address of B
		x"F0", -- 
		LD_ADDR2_OP, -- load the address of C
		x"F1", --
		LD_ACC_OP, -- move B to ACC
		LD_TEMP_OP, -- move C to TEMP
		LD_ADDR1_OP, -- load the address of A
		x"F2", --
		ADD_OP, -- add B and C
		ST_ACC1_OP, -- store the result in A
		others => (others => '0')
	);
begin
	i1 : microprocessor
	port map(
		-- list connections between master ports and signals
		address => address,
		clk => clk,
		-- data => data,
		data_in => data_in,
		data_out => data_out,
		rd => rd,
		rst => rst,
		step => step,
		wr => wr
	);
	add_program(240) <= x"03";
	add_program(241) <= x"04";

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

	program_process : process(address)
	begin
		-- wait for PERIOD;
		data_in <= add_program(to_integer(unsigned(address)));
		-- wait for PERIOD;
		-- data <= add_program(1);
		-- wait for PERIOD;
		-- wait;
	end process;

	-- program_process : process(address)
	-- begin
	-- 	report "address = " & integer'image(to_integer(unsigned(address)));
	-- 	data <= add_program(to_integer(unsigned(address)));
	-- end process;
end microprocessor_arch;