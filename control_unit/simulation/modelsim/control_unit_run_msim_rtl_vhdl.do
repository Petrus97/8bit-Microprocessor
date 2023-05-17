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

do /home/ale19/Desktop/8bit-Microprocessor/control_unit/simulation/modelsim/cu_simulation_script.do
