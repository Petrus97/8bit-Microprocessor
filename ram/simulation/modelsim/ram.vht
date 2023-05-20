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
-- Generated on "05/18/2023 18:26:15"

-- Vhdl Test Bench template for design  :  ram
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram_vhd_tst is
end ram_vhd_tst;
architecture ram_arch of ram_vhd_tst is
	-- constants                                                 
	constant PERIOD : time := 10 ns;
	-- signals                                                   
	signal addr : std_logic_vector(7 downto 0);
	signal clk : std_logic;
	-- signal rst : std_logic;
	signal data_io : std_logic_vector(7 downto 0) := (others => 'Z');
	signal oe : std_logic := '0';
	signal we : std_logic := '0';
	signal en : std_logic := '1';
	-- -- define my signals
	-- signal data_in : std_logic_vector(7 downto 0);
	-- signal data_out : std_logic_vector(7 downto 0);
	-- -- signal bidir : std_logic_vector(7 downto 0);
	component ram
		port (
			en: in std_logic;
			addr : in std_logic_vector(7 downto 0);
			clk : in std_logic;
			-- rst : in std_logic;
			data_io : inout std_logic_vector(7 downto 0);
			oe : in std_logic;
			we : in std_logic
		);
	end component;
begin
	i1 : ram
	port map(
		-- list connections between master ports and signals
		addr => addr,
		clk => clk,
		-- rst => rst,
		data_io => data_io,
		oe => oe,
		we => we,
		en => en
	);
	-- data_io <= data_in when oe = '0' else (others => 'Z');

	-- data_io <= data_in when oe = '0' else (others => 'Z');
	-- data_out <= data_io when oe = '1' else (others => 'Z');

	process
	begin
		-- Initialize RAM data
		-- wait for 10 ns;
		-- we <= '1';
		-- addr <= "00000000";
		-- data_io <= "00001111";
		-- wait for 10 ns;
		-- we <= '0';

		-- -- Read from RAM
		-- wait for 10 ns;
		-- oe <= '1';
		-- addr <= "00000000";
		-- wait for 10 ns;
		-- -- wait for PERIOD; -- wait for the reset
		w_loop : for i in 0 to 100 loop
			oe <= '0'; -- disable the output
			we <= '1'; -- enable the write
			addr <= std_logic_vector(to_unsigned(i, 8));
			data_io <= std_logic_vector(to_unsigned(i, 8));
			wait for PERIOD;
			oe <= '1';
			we <= '0';
			wait for PERIOD;
		end loop; -- 
		-- reset the ram
		-- TEST0: Write a value to the 0x00 address and read it
		-- Write to 0x00
		-- oe <= '0'; -- disable the output
		-- we <= '1'; -- enable the write
		-- write data in that address
		-- data_in <= x"01";
		-- select the address to write to
		-- addr <= x"00";
		-- wait for PERIOD;
		-- Read from 0x00
		-- addr <= x"01";
		-- data_in <= x"02";
		-- we <= '0'; -- disable the write
		-- oe <= '1'; -- enable the output
		-- wait for PERIOD;
		-- we <= '0'; -- disable the write
		-- -- TEST1: Modify the value to the 0x00 address and read it
		-- -- Write to 0x00
		-- oe <= '0'; -- disable the output
		-- we <= '1'; -- enable the write
		-- -- select the address to write to
		-- addr <= x"00";
		-- -- write data in that address
		-- data_in <= x"FF";
		-- wait for PERIOD;
		-- -- Read from 0x00
		-- addr <= x"00";
		-- we <= '0'; -- disable the write
		-- oe <= '1'; -- enable the output
		-- wait for PERIOD;

		-- -- TEST2: Write a value to the 0xFF address(last one) and read it
		-- -- Write to 0xFF
		-- oe <= '0'; -- disable the output
		-- we <= '1'; -- enable the write
		-- -- select the address to write to
		-- addr <= x"FF";
		-- -- write data in that address
		-- data_in <= x"01";
		-- wait for PERIOD;
		-- -- Read from 0xFF
		-- addr <= x"FF";
		-- we <= '0'; -- disable the write
		-- oe <= '1'; -- enable the output
		-- wait for PERIOD;

		-- -- TEST3: Modify the value to the 0xFF address and read it
		-- -- Write to 0xFF
		-- oe <= '0'; -- disable the output
		-- we <= '1'; -- enable the write
		-- -- select the address to write to
		-- addr <= x"FF";
		-- -- write data in that address
		-- data_in <= x"FF";
		-- wait for PERIOD;
		-- -- Read from 0xFF
		-- addr <= x"FF";
		-- we <= '0'; -- disable the write
		-- oe <= '1'; -- enable the output
		-- wait for PERIOD;
		wait;
	end process;

	clk_process : process
		variable should_reset : boolean := true;
	begin
		while now < 400 ns loop
			-- if should_reset then
			-- 	should_reset := false;
			-- 	rst <= '1';
			-- else
			-- 	rst <= '0';
			-- end if;
			clk <= '1';
			wait for PERIOD / 2;
			clk <= '0';
			wait for PERIOD / 2;
		end loop;
		wait;
	end process;

end ram_arch;