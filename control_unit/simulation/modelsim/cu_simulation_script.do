transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/ale19/Desktop/8bit-Microprocessor/control_unit/utils.vhd}
vcom -93 -work work {/home/ale19/Desktop/8bit-Microprocessor/control_unit/isa.vhd}
vcom -93 -work work {/home/ale19/Desktop/8bit-Microprocessor/control_unit/control_unit.vhd}

vcom -93 -work work {/home/ale19/Desktop/8bit-Microprocessor/control_unit/simulation/modelsim/control_unit.vht}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc"  control_unit_vhd_tst

add wave -position insertpoint sim:/control_unit_vhd_tst/clk
add wave -position insertpoint sim:/control_unit_vhd_tst/data_in
# add wave -position insertpoint sim:/control_unit_vhd_tst/debug_out
add wave -position insertpoint sim:/control_unit_vhd_tst/rst

#Group 0: Memory
add wave -group "Memory operations" -radix ascii -symbolic \
     /control_unit_vhd_tst/mem_read \
     /control_unit_vhd_tst/mem_write 

# Group 1: Control Signals
add wave -group "Control Out Signals" -radix ascii -symbolic \
     /control_unit_vhd_tst/ACC_INC \
     /control_unit_vhd_tst/ACC_LD \
     /control_unit_vhd_tst/ACC_OE \
     /control_unit_vhd_tst/ADDR1_INC \
     /control_unit_vhd_tst/ADDR1_LD \
     /control_unit_vhd_tst/ADDR1_OE \
     /control_unit_vhd_tst/ADDR2_INC \
     /control_unit_vhd_tst/ADDR2_LD \
     /control_unit_vhd_tst/ADDR2_OE \
     /control_unit_vhd_tst/CMP \
     /control_unit_vhd_tst/JPB \
     /control_unit_vhd_tst/JPF \
     /control_unit_vhd_tst/JUMP_LD \
     /control_unit_vhd_tst/PC_INC \
     /control_unit_vhd_tst/PC_LD \
     /control_unit_vhd_tst/PC_OE \
     /control_unit_vhd_tst/SUB \
     /control_unit_vhd_tst/ADD \
     /control_unit_vhd_tst/TEMP_LD

# Group 2: State Machine Signals
add wave -group "State Machine Signals" -radix ascii -decimal \
     /control_unit_vhd_tst/i1/state_machine/state

# Group 3: Debug Signals
add wave -group "Debug Signals" -radix ascii -decimal \
     /control_unit_vhd_tst/i1/debug_process/debug_instr

add wave -position insertpoint /control_unit_vhd_tst/pc_sim/PC
# add wave -position insertpoint /control_unit_vhd_tst/i1/state_machine/state
# add wave -position insertpoint /control_unit_vhd_tst/i1/debug_process/debug_instr

view structure
view signals
run -all
