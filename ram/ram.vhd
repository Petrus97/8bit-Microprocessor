library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library cu;
use cu.isa.all;

entity ram is
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
end entity ram;

architecture rtl of ram is
	type ram_type is array(0 to 255) of std_logic_vector(7 downto 0);
	signal ram_array : ram_type;

	-- A = B + C
	signal add_program : ram_type := (
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
	signal branch_program : ram_type := (
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

begin
	process (clk, rst)
	begin
		if rst = '1' then
			if prog_select = '0' then
				ram_array <= add_program;
				add_program(240) <= x"03"; -- 0xF0 value of A
				add_program(241) <= x"04"; -- 0xF1 value of 0
			else
				ram_array <= branch_program;
				branch_program(240) <= x"03"; -- 0xF0 value of A
				branch_program(241) <= x"00"; -- 0xF1 value of 0
				branch_program(242) <= x"04"; -- 0xF2 value of B
				branch_program(243) <= x"77"; -- 0xF3 value of C
			end if;
		elsif rising_edge(clk) then
			if we = '1' then -- write data to address 'addr'
				ram_array(to_integer(unsigned(addr))) <= data_in;
			end if;
		end if;
	end process;

	-- read data from address 'addr'
	-- convert 'addr' type to integer from std_logic_vector
	data_out <= ram_array(to_integer(unsigned(addr))) when oe = '1' else
		(others => '0') when rst = '1' else
		(others => 'Z');
end architecture rtl;