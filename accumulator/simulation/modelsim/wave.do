onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /accumulator_vhd_tst/acc_inc
add wave -noupdate /accumulator_vhd_tst/acc_ld
add wave -noupdate /accumulator_vhd_tst/acc_oe
add wave -noupdate /accumulator_vhd_tst/add
add wave -noupdate /accumulator_vhd_tst/clk
add wave -noupdate /accumulator_vhd_tst/cmp
add wave -noupdate /accumulator_vhd_tst/data_in
add wave -noupdate /accumulator_vhd_tst/data_out
add wave -noupdate /accumulator_vhd_tst/eq
add wave -noupdate /accumulator_vhd_tst/gt
add wave -noupdate /accumulator_vhd_tst/rst
add wave -noupdate /accumulator_vhd_tst/sub
add wave -noupdate /accumulator_vhd_tst/temp_ld
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {199301 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 264
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {110834 ps}
