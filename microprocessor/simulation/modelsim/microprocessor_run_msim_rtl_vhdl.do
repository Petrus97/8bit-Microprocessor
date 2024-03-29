transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlib mux
vmap mux mux
vcom -93 -work mux {/home/ale19/Desktop/8bit-Microprocessor/input_mux/input_mux.vhd}
vcom -93 -work mux {/home/ale19/Desktop/8bit-Microprocessor/input_mux/input_mux_pkg.vhd}
vlib pc
vmap pc pc
vcom -93 -work pc {/home/ale19/Desktop/8bit-Microprocessor/program_counter/program_counter_pkg.vhd}
vlib acc
vmap acc acc
vcom -93 -work acc {/home/ale19/Desktop/8bit-Microprocessor/accumulator/accumulator_pkg.vhd}
vlib reg
vmap reg reg
vcom -93 -work reg {/home/ale19/Desktop/8bit-Microprocessor/register/register_pkg.vhd}
vcom -93 -work reg {/home/ale19/Desktop/8bit-Microprocessor/register/register.vhd}
vcom -93 -work pc {/home/ale19/Desktop/8bit-Microprocessor/program_counter/program_counter.vhd}
vlib cu
vmap cu cu
vcom -93 -work cu {/home/ale19/Desktop/8bit-Microprocessor/control_unit/utils.vhd}
vcom -93 -work cu {/home/ale19/Desktop/8bit-Microprocessor/control_unit/isa.vhd}
vcom -93 -work acc {/home/ale19/Desktop/8bit-Microprocessor/accumulator/accumulator.vhd}
vcom -93 -work cu {/home/ale19/Desktop/8bit-Microprocessor/control_unit/control_unit_pkg.vhd}
vcom -93 -work cu {/home/ale19/Desktop/8bit-Microprocessor/control_unit/control_unit.vhd}
vcom -93 -work work {/home/ale19/Desktop/8bit-Microprocessor/microprocessor/microprocessor.vhd}

vcom -93 -work work {/home/ale19/Desktop/8bit-Microprocessor/microprocessor/simulation/modelsim/microprocessor.vht}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -L mux -L pc -L acc -L reg -L cu -voptargs="+acc"  microprocessor_vhd_tst

do /home/ale19/Desktop/8bit-Microprocessor/microprocessor/simulation/modelsim/microprocessor_simulation_script.do
