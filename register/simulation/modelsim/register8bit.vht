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

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                
USE ieee.numeric_std.all;


ENTITY register8bit_vhd_tst IS
END register8bit_vhd_tst;
ARCHITECTURE register8bit_arch OF register8bit_vhd_tst IS
-- constants                                                 
constant period : time := 10 ns;
constant half_period : time := period / 2;
-- signals                                                   
SIGNAL addr_inc : STD_LOGIC;
SIGNAL addr_ld : STD_LOGIC;
SIGNAL addr_oe : STD_LOGIC;
SIGNAL address : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL clk : STD_LOGIC;
SIGNAL data : STD_LOGIC_VECTOR(7 DOWNTO 0);
COMPONENT register8bit
	PORT (
	addr_inc : IN STD_LOGIC;
	addr_ld : IN STD_LOGIC;
	addr_oe : IN STD_LOGIC;
	address : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	clk : IN STD_LOGIC;
	data : IN STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : register8bit
	PORT MAP (
-- list connections between master ports and signals
	addr_inc => addr_inc,
	addr_ld => addr_ld,
	addr_oe => addr_oe,
	address => address,
	clk => clk,
	data => data
	);                                         

	-- address <= (OTHERS => '0');
	-- data <= (OTHERS => '0');
	-- addr_inc <= '0';
	-- addr_ld <= '0';
	-- addr_oe <= '0';

always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
		addr_ld <= '0'; -- enable load address
		addr_inc <= '0'; -- disable increment address
		addr_oe <= '0'; -- disable output
		data <= x"00"; -- load data
		-- addr_oe <= '1'; -- enable output (data should be same as address)
		-- wait for 10 ns;
		-- addr_oe <= '0';
		-- wait for 10 ns;
		for i in 0 to 255 loop
			addr_oe <= '0'; -- disable output
			addr_ld <= '1'; -- enable load address
			data <= std_logic_vector(to_unsigned(i, data'length));
			wait for period;
			addr_ld <= '0'; -- disable load address
			addr_oe <= '1'; -- enable output
			wait for period;
		end loop;
WAIT;                                                        
END PROCESS always;                                          

clock: process
begin
	for i in 0 to 512 loop
		clk <= '1';
		wait for half_period;
		clk <= '0';
		wait for half_period;
	end loop;
	wait;
end process clock;

END register8bit_arch;
