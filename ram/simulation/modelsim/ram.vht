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
	signal rst : std_logic;
	signal data_in : std_logic_vector(7 downto 0);
	signal data_out : std_logic_vector(7 downto 0);
	signal oe : std_logic := '0';
	signal we : std_logic := '0';
	signal prog_select : std_logic := '0';
	-- -- define my signals
	-- signal data_in : std_logic_vector(7 downto 0);
	-- signal data_out : std_logic_vector(7 downto 0);
	-- -- signal bidir : std_logic_vector(7 downto 0);
	component ram
		port (
			rst : in std_logic;
			prog_select : in std_logic; -- switch to select the program
			clk : in std_logic;
			we : in std_logic; -- write enable
			oe : in std_logic; -- output enable
			addr : in std_logic_vector(7 downto 0);
			data_in : in std_logic_vector(7 downto 0);
			data_out : out std_logic_vector(7 downto 0)
		);
	end component;
begin
	i1 : ram
	port map(
		rst => rst,
		prog_select => prog_select,
		clk => clk,
		we => we,
		oe => oe,
		addr => addr,
		data_in => data_in,
		data_out => data_out
	);
	-- data_io <= data_in when oe = '0' else (others => 'Z');

	-- data_io <= data_in when oe = '0' else (others => 'Z');
	-- data_out <= data_io when oe = '1' else (others => 'Z');

	process
	begin
		rst <= '1';
		prog_select <= '0'; -- select the add program
		wait for PERIOD;
		rst <= '0';
		wait for PERIOD;

		report "Write test (all 0xFF)" severity note;
		w_loop : for i in 0 to 255 loop
			oe <= '0'; -- disable the output
			we <= '1'; -- enable the write
			addr <= std_logic_vector(to_unsigned(i, 8));
			data_in <= x"FF"; -- put all memory to 0xFF
			wait for PERIOD;
		end loop; -- w_loop
		
		report "Write test (from 0x00 to 0xFF)" severity note;
		w2_loop: for i in 0 to 255 loop
			oe <= '0'; -- disable the output
			we <= '1'; -- enable the write
			addr <= std_logic_vector(to_unsigned(i, 8));
			data_in <= std_logic_vector(to_unsigned(i, 8));
			wait for PERIOD;
		end loop; -- w2_loop

		report "Read test" severity note;
		r_loop : for i in 0 to 255 loop
			oe <= '1'; -- disable the output
			we <= '0'; -- enable the write
			addr <= std_logic_vector(to_unsigned(i, 8));
			wait for PERIOD / 2;
			assert data_out = std_logic_vector(to_unsigned(i, 8)) report "Error in the Data out: " & integer'image(to_integer(unsigned(data_out))) & " expected: " & integer'image(i) severity error;
			wait for PERIOD / 2;
		end loop ; -- r_loop

		report "Reset test" severity note;
		reset_loop: for i in 0 to 255 loop
			oe <= '0'; -- disable the output
			we <= '1'; -- enable the write
			addr <= std_logic_vector(to_unsigned(i, 8));
			data_in <= x"00"; -- put all memory to 0x00
			wait for PERIOD;
		end loop; -- reset_loop


		report "Write/Read test" severity note;
		rw_loop : for i in 200 to 255 loop
			oe <= '0'; -- disable the output
			we <= '1'; -- enable the write
			addr <= std_logic_vector(to_unsigned(i, 8));
			data_in <= std_logic_vector(to_unsigned(i, 8));
			wait for PERIOD;
			oe <= '1';
			we <= '0';
			wait for 1 ns;
			assert data_out = std_logic_vector(to_unsigned(i, 8)) report "Error in the Data out: " & integer'image(to_integer(unsigned(data_out))) & " expected: " & integer'image(i) severity error;
			wait for PERIOD - 1 ns;
		end loop; -- 
		wait;
	end process;

	clk_process : process
		variable should_reset : boolean := true;
	begin
		while now < 16000 ns loop
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