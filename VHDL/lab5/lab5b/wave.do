onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider -height 20 {Control Signals}
add wave -noupdate -radix binary /mult8x8_tb/clk
add wave -noupdate -radix binary /mult8x8_tb/start
add wave -noupdate -radix binary /mult8x8_tb/reset_a
add wave -noupdate -divider -height 20 Multiplicands
add wave -noupdate -radix unsigned /mult8x8_tb/dataa
add wave -noupdate -radix unsigned /mult8x8_tb/datab
add wave -noupdate -divider -height 20 {Product & Done Flag}
add wave -noupdate -radix unsigned /mult8x8_tb/product8x8_out
add wave -noupdate -radix binary /mult8x8_tb/done_flag
add wave -noupdate -divider -height 20 {7-segment Display}
add wave -noupdate -radix binary /mult8x8_tb/seg_a
add wave -noupdate -radix binary /mult8x8_tb/seg_b
add wave -noupdate -radix binary /mult8x8_tb/seg_c
add wave -noupdate -radix binary /mult8x8_tb/seg_d
add wave -noupdate -radix binary /mult8x8_tb/seg_e
add wave -noupdate -radix binary /mult8x8_tb/seg_f
add wave -noupdate -radix binary /mult8x8_tb/seg_g
add wave -noupdate -divider -height 20 {Addt'l Signals}
add wave -noupdate /mult8x8_tb/mult8x8_1/u6/current_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {400 ns} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {441 ns} {941 ns}
