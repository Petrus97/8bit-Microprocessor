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
-- Generated on "05/07/2023 21:45:03"

-- Vhdl Test Bench template for design  :  register8bit
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity register8bit_vhd_tst is
end register8bit_vhd_tst;
architecture register8bit_arch of register8bit_vhd_tst is
	-- constants                                                 
	constant period : time := 10 ns;
	constant half_period : time := period / 2;
	-- signals                                                   
	signal rst : std_logic;
	signal addr_inc : std_logic;
	signal addr_ld : std_logic;
	signal addr_oe : std_logic;
	signal address : std_logic_vector(7 downto 0);
	signal clk : std_logic;
	signal data : std_logic_vector(7 downto 0);
	component register8bit
		port (
			rst : in std_logic;
			addr_inc : in std_logic;
			addr_ld : in std_logic;
			addr_oe : in std_logic;
			address : out std_logic_vector(7 downto 0);
			clk : in std_logic;
			data : in std_logic_vector(7 downto 0)
		);
	end component;
begin
	i1 : register8bit
	port map(
		-- list connections between master ports and signals
		rst => rst,
		addr_inc => addr_inc,
		addr_ld => addr_ld,
		addr_oe => addr_oe,
		address => address,
		clk => clk,
		data => data
	);

	register_stimulus : process
	begin
		addr_ld <= '0'; -- enable load address
		addr_inc <= '0'; -- disable increment address
		addr_oe <= '0'; -- disable output
		data <= x"00"; -- load data
		rst <= '1'; -- reset
		wait for period;
		rst <= '0'; -- release reset
		for i in 0 to 255 loop
			-- fetch
			addr_oe <= '0'; -- disable output
			addr_ld <= '1'; -- enable load address
			data <= std_logic_vector(to_unsigned(i, data'length));
			wait for period;
			-- execute
			addr_ld <= '0'; -- disable load address
			addr_oe <= '1'; -- enable output
			wait for period;
		end loop;
		wait;
	end process register_stimulus;

	clock : process
	begin
		for i in 0 to 512 loop
			clk <= '1';
			wait for half_period;
			clk <= '0';
			wait for half_period;
		end loop;
		wait;
	end process clock;

end register8bit_arch;