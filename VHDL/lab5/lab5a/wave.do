onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /mult_control_tb/clk
add wave -noupdate -radix binary /mult_control_tb/reset_a
add wave -noupdate -radix binary /mult_control_tb/count
add wave -noupdate -radix binary /mult_control_tb/start
add wave -noupdate -radix binary /mult_control_tb/input_sel
add wave -noupdate -radix binary /mult_control_tb/shift_sel
add wave -noupdate -radix unsigned /mult_control_tb/state_out
add wave -noupdate -radix binary /mult_control_tb/done
add wave -noupdate -radix binary /mult_control_tb/clk_ena
add wave -noupdate -radix binary /mult_control_tb/sclr_n
add wave -noupdate /mult_control_tb/mult_control1/current_state
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
WaveRestoreZoom {0 ns} {420 ns}
