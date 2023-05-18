transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -2008 -work work {/home/ale19/Desktop/8bit-Microprocessor/register/register.vhd}

vcom -2008 -work work {/home/ale19/Desktop/8bit-Microprocessor/register/simulation/modelsim/register8bit.vht}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc"  register8bit_vhd_tst

add wave *

# Group 1: CPU State Signals
add wave -group "CPU State" -radix ascii -decimal \
     /register8bit_vhd_tst/i1/state_machine/state

view structure
view signals
run -all
