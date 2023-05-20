transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vcom -93 -work work {ram.vho}

vcom -93 -work work {/home/ale19/Desktop/8bit-Microprocessor/ram/simulation/modelsim/ram.vht}

vsim -t 1ps +transport_int_delays +transport_path_delays -sdftyp /NA=ram_vhd.sdo -L altera -L altera_lnsim -L cyclonev -L gate_work -L work -voptargs="+acc"  ram_vhd_tst

do /home/ale19/Desktop/8bit-Microprocessor/ram/simulation/modelsim/ram_simulation_script.do
