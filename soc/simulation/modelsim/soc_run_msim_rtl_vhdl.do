transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlib memory
vmap memory memory
vcom -93 -work memory {/home/ale19/Desktop/8bit-Microprocessor/ram/ram_pkg.vhd}
vlib micro
vmap micro micro
vcom -93 -work micro {/home/ale19/Desktop/8bit-Microprocessor/microprocessor/micro_pkg.vhd}
vcom -93 -work work {/home/ale19/Desktop/8bit-Microprocessor/soc/seven_segment_interface.vhd}
vlib pc
vmap pc pc
vcom -93 -work pc {/home/ale19/Desktop/8bit-Microprocessor/program_counter/program_counter_pkg.vhd}
vcom -93 -work pc {/home/ale19/Desktop/8bit-Microprocessor/program_counter/program_counter.vhd}
vlib acc
vmap acc acc
vcom -93 -work acc {/home/ale19/Desktop/8bit-Microprocessor/accumulator/accumulator_pkg.vhd}
vcom -93 -work acc {/home/ale19/Desktop/8bit-Microprocessor/accumulator/accumulator.vhd}
vlib cu
vmap cu cu
vcom -93 -work cu {/home/ale19/Desktop/8bit-Microprocessor/control_unit/utils.vhd}
vcom -93 -work cu {/home/ale19/Desktop/8bit-Microprocessor/control_unit/isa.vhd}
vlib mux
vmap mux mux
vcom -93 -work mux {/home/ale19/Desktop/8bit-Microprocessor/input_mux/input_mux_pkg.vhd}
vcom -93 -work mux {/home/ale19/Desktop/8bit-Microprocessor/input_mux/input_mux.vhd}
vlib reg
vmap reg reg
vcom -93 -work reg {/home/ale19/Desktop/8bit-Microprocessor/register/register_pkg.vhd}
vcom -93 -work reg {/home/ale19/Desktop/8bit-Microprocessor/register/register.vhd}
vcom -93 -work work {/home/ale19/Desktop/8bit-Microprocessor/soc/soc.vhd}
vcom -93 -work cu {/home/ale19/Desktop/8bit-Microprocessor/control_unit/control_unit_pkg.vhd}
vcom -93 -work cu {/home/ale19/Desktop/8bit-Microprocessor/control_unit/control_unit.vhd}
vcom -93 -work memory {/home/ale19/Desktop/8bit-Microprocessor/ram/ram.vhd}
vcom -93 -work micro {/home/ale19/Desktop/8bit-Microprocessor/microprocessor/microprocessor.vhd}

vcom -93 -work work {/home/ale19/Desktop/8bit-Microprocessor/soc/simulation/modelsim/soc.vht}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -L memory -L micro -L pc -L acc -L cu -L mux -L reg -voptargs="+acc"  soc_vhd_tst

do /home/ale19/Desktop/8bit-Microprocessor/soc/simulation/modelsim/soc_simulation_script.do
