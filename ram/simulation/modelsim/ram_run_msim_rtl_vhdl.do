transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/ale19/Desktop/8bit-Microprocessor/ram/ram.vhd}

vcom -93 -work work {/home/ale19/Desktop/8bit-Microprocessor/ram/simulation/modelsim/ram.vht}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc"  ram_vhd_tst

do /home/ale19/Desktop/8bit-Microprocessor/ram/simulation/modelsim/ram_simulation_script.do
