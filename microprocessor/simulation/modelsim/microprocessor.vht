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
	signal step : std_logic := '1';
	signal wr : std_logic;
	signal en : std_logic;
	component microprocessor
		port (
			address : out std_logic_vector(7 downto 0);
			clk : in std_logic;
			en : in std_logic;
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
	-- if (A >= 0) then B = C
	signal branch_program : program := (
		LD_ADDR1_OP, -- load the address of A (0x00)
		x"F0", -- address of A (0x01)
		LD_ADDR2_OP, -- load the address of 0 variable (0x02)
		x"F1", -- address of 0 variable (0x03)
		LD_JUMPREG_OP, -- (0x04)
		x"0E", -- address of B = C (0x05)
		LD_ACC_OP, -- move A to ACC (0x06)
		LD_TEMP_OP, -- move 0 to TEMP (0x07)
		CMP_OP, -- compare A and 0 		(0x08)
		JPF_G_OP, -- if A > 0 then jump to 	(0x09)
		JPF_Z_OP, -- if A == 0 then jump to 	(0x0A)
		-- else operations
		LD_JUMPREG_OP, -- (0x0B)
		x"14", -- else jump to 0x14	(0x0C)
		JPF_OP, -- jump to 0x14	(0x0D)
		-- if operations (here we load B and C)
		LD_ADDR1_OP, -- load the address of C (0x0E)
		x"F3", -- address of C (0x0F)
		LD_ADDR2_OP, -- load the address of B (0x10)
		x"F2", -- address of B (0x11)
		LD_ACC_OP, -- move C to ACC (0x12)
		ST_ACC2_OP, -- store C in B (0x13)
		others => (others => '0') -- (0x14 - 0xFF)
	);
	signal current_pc : integer := 0;
begin
	i1 : microprocessor
	port map(
		-- list connections between master ports and signals
		address => address,
		clk => clk,
		en => en,
		-- data => data,
		data_in => data_in,
		data_out => data_out,
		rd => rd,
		rst => rst,
		step => step,
		wr => wr
	);
	add_program(240) <= x"03"; -- 0xF0 value of A
	add_program(241) <= x"04"; -- 0xF1 value of 0

	branch_program(240) <= x"03"; -- 0xF0 value of A
	branch_program(241) <= x"00"; -- 0xF1 value of 0
	branch_program(242) <= x"04"; -- 0xF2 value of B
	branch_program(243) <= x"77"; -- 0xF3 value of C

	-- en <= '1'; -- enable the clock input
	en <= '0'; -- disable the clock input, enable the step input

	reset_process : process
	begin
		rst <= '1';
		wait for PERIOD;
		rst <= '0';
		wait for PERIOD;
		wait;
	end process;

	step_process : process
	begin
		wait until rst = '0';
		while now < 2000 ns loop
			step <= '1';
			wait for PERIOD * 2;
			step <= '0';
			wait for PERIOD * 2;
		end loop;
		wait;
	end process;

	clk_process : process
	begin
		wait until rst = '0';
		while now < 2000 ns loop
			clk <= '1';
			wait for PERIOD / 2;
			clk <= '0';
			wait for PERIOD / 2;
		end loop;
		wait;
	end process;

	program_process : process (address)
	begin
		data_in <= add_program(to_integer(unsigned(address)));
	end process;

end microprocessor_arch;