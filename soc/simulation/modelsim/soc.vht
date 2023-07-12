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
-- Generated on "05/22/2023 18:48:42"

-- Vhdl Test Bench template for design  :  soc
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

library ieee;
use ieee.std_logic_1164.all;

entity soc_vhd_tst is
end soc_vhd_tst;
architecture soc_arch of soc_vhd_tst is
	-- constants                                                 
	constant PERIOD : time := 10 ns;
	-- signals                                                   
	signal address_h : std_logic_vector(7 downto 0);
	signal address_l : std_logic_vector(7 downto 0);
	signal CLK : std_logic;
	signal data_in_h : std_logic_vector(7 downto 0);
	signal data_in_l : std_logic_vector(7 downto 0);
	signal dout_disp_h : std_logic_vector(7 downto 0);
	signal dout_disp_l : std_logic_vector(7 downto 0);
	signal EN : std_logic;
	signal PROG_SELECT : std_logic;
	signal RST : std_logic := '1';
	signal STEP : std_logic := '1';
	-- helpful to display the signals in the wave window
	signal din_h : character;
	signal din_l : character;
	signal dout_h : character;
	signal dout_l : character;
	signal addr_h : character;
	signal addr_l : character;

	component soc
		port (
			address_h : out std_logic_vector(7 downto 0);
			address_l : out std_logic_vector(7 downto 0);
			CLK : in std_logic;
			data_in_h : out std_logic_vector(7 downto 0);
			data_in_l : out std_logic_vector(7 downto 0);
			dout_disp_h : out std_logic_vector(7 downto 0);
			dout_disp_l : out std_logic_vector(7 downto 0);
			EN : in std_logic;
			PROG_SELECT : in std_logic;
			RST : in std_logic;
			STEP : in std_logic
		);
	end component;

	function seg_to_char(segment : in std_logic_vector(7 downto 0)) return character is
		begin
			case segment is
				when "00000001" => return '0';
				when "01001111" => return '1';
				when "00010010" => return '2';
				when "00000110" => return '3';
				when "01001100" => return '4';
				when "00100100" => return '5';
				when "00100000" => return '6';
				when "00001111" => return '7';
				when "00000000" => return '8';
				when "00000100" => return '9';
				when "00001000" => return 'A';
				when "01100000" => return 'B';
				when "00110001" => return 'C';
				when "01000010" => return 'D';
				when "00110000" => return 'E';
				when "00111000" => return 'F';
				when others =>
					return 'Z'; -- Invalid segment pattern, return a space
			end case;
		end function;
		
begin
	i1 : soc
	port map(
		-- list connections between master ports and signals
		address_h => address_h,
		address_l => address_l,
		CLK => CLK,
		data_in_h => data_in_h,
		data_in_l => data_in_l,
		dout_disp_h => dout_disp_h,
		dout_disp_l => dout_disp_l,
		EN => EN,
		PROG_SELECT => PROG_SELECT,
		RST => RST,
		STEP => STEP
	);
	-- Clock generation process
	en <= '1'; -- enable the clk input
	prog_select <= '1'; -- select the add program
	reset_process : process
	begin
		rst <= not rst;
		wait for PERIOD;
		rst <= not rst;
		wait for PERIOD;
		wait;
	end process;

	clk_process : process
	begin
		-- wait until rst = '0';
		while now < 400 ns loop
			clk <= '1';
			wait for PERIOD / 2;
			clk <= '0';
			wait for PERIOD / 2;
		end loop;
		wait;
	end process;

	-- display process
	display_process : process (address_h, address_l, data_in_h, data_in_l, dout_disp_h, dout_disp_l)
	begin
		din_h <= seg_to_char(data_in_h(7 downto 0));
		din_l <= seg_to_char(data_in_l(7 downto 0));
		dout_h <= seg_to_char(dout_disp_h(7 downto 0));
		dout_l <= seg_to_char(dout_disp_l(7 downto 0));
		addr_h <= seg_to_char(address_h(7 downto 0));
		addr_l <= seg_to_char(address_l(7 downto 0));
		-- wait for PERIOD;
	end process;

end soc_arch;