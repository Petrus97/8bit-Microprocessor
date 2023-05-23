add wave \
	sim:/soc_vhd_tst/CLK \
	sim:/soc_vhd_tst/EN \
	sim:/soc_vhd_tst/PROG_SELECT \
	sim:/soc_vhd_tst/RST \
	sim:/soc_vhd_tst/STEP 



add wave -group "Display: DataIN" -radix ascii -hex \
	sim:/soc_vhd_tst/data_in_h \
	sim:/soc_vhd_tst/data_in_l \
	sim:/soc_vhd_tst/din_h \
	sim:/soc_vhd_tst/din_l 

add wave -group "Display: DataOUT" -radix ascii -hex \
	sim:/soc_vhd_tst/dout_disp_h \
	sim:/soc_vhd_tst/dout_disp_l \
	sim:/soc_vhd_tst/dout_h \
	sim:/soc_vhd_tst/dout_l 

add wave -group "Display: Address" -radix ascii -hex \
	sim:/soc_vhd_tst/address_h \
	sim:/soc_vhd_tst/address_l \
	sim:/soc_vhd_tst/addr_h \
	sim:/soc_vhd_tst/addr_l 

add wave -position insertpoint \
/soc_vhd_tst/i1/mp/CU/debug_process/debug_instr

add wave -group "Microprocessor" -radix ascii -symbolic \
	sim:/soc_vhd_tst/i1/mp/*

add wave -group "RAM" -radix ascii -symbolic \
	sim:/soc_vhd_tst/i1/mem/*

add wave -group "mux" -radix ascii -symbolic \
	sim:/soc_vhd_tst/i1/mp/mux/*

add wave -group "CU" -radix ascii -symbolic \
	sim:/soc_vhd_tst/i1/mp/CU/*

add wave -group "acc" -radix ascii -symbolic \
	sim:/soc_vhd_tst/i1/mp/acc/*

add wave -group "pc" -radix ascii -symbolic \
	sim:/soc_vhd_tst/i1/mp/pc/*

add wave -group "reg1" -radix ascii -symbolic \
	sim:/soc_vhd_tst/i1/mp/reg1/*

add wave -group "reg2" -radix ascii -symbolic \
	sim:/soc_vhd_tst/i1/mp/reg2/*

view structure
view signals
run -all
