transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/ale19/Desktop/8bit-Microprocessor/program_counter/program_counter.vhd}

vcom -93 -work work {/home/ale19/Desktop/8bit-Microprocessor/program_counter/simulation/modelsim/program_counter.vht}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc"  program_counter_vhd_tst

add wave *
view structure
view signals
run -all
