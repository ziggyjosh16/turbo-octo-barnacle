onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /reg16_tb/clk
add wave -noupdate -radix binary /reg16_tb/sclr_n
add wave -noupdate -radix binary /reg16_tb/clk_ena
add wave -noupdate -radix hexadecimal /reg16_tb/datain
add wave -noupdate -radix hexadecimal /reg16_tb/reg_out
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
WaveRestoreZoom {0 ns} {263 ns}
