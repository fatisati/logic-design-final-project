onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testTcircuit/rst
add wave -noupdate /testTcircuit/clk
add wave -noupdate /testTcircuit/a
add wave -noupdate /testTcircuit/b
add wave -noupdate /testTcircuit/a_tr
add wave -noupdate /testTcircuit/b_tr
add wave -noupdate /testTcircuit/r
add wave -noupdate /testTcircuit/a_ti_l
add wave -noupdate /testTcircuit/a_ti_h
add wave -noupdate /testTcircuit/b_ti_h
add wave -noupdate /testTcircuit/b_ti_l
add wave -noupdate /testTcircuit/c
add wave -noupdate /testTcircuit/a_l
add wave -noupdate /testTcircuit/b_l
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ns} {1 us}
