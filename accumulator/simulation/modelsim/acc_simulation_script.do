transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/ale19/Desktop/8bit-Microprocessor/accumulator/accumulator.vhd}

vcom -93 -work work {/home/ale19/Desktop/8bit-Microprocessor/accumulator/simulation/modelsim/accumulator.vht}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc"  accumulator_vhd_tst

add wave *

# Group 0: Internal registers
add wave -group "Internal registes" -radix ascii -decimal  \
		sim:/accumulator_vhd_tst/i1/acc_buf \
		sim:/accumulator_vhd_tst/i1/temp_reg

# Group 1: CPU State
add wave -group "CPU State" -radix ascii -decimal \
     /accumulator_vhd_tst/i1/state_machine/state


view structure
view signals
run -all
