onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /de1_top_tb/dut/simulation_wide
add wave -noupdate /de1_top_tb/dut/simulation_max
add wave -noupdate /de1_top_tb/dut/clock_50
add wave -noupdate -divider {large counter}
add wave -noupdate -radix unsigned -childformat {{/de1_top_tb/dut/large_counter/i_count(2) -radix unsigned} {/de1_top_tb/dut/large_counter/i_count(1) -radix unsigned} {/de1_top_tb/dut/large_counter/i_count(0) -radix unsigned}} -subitemconfig {/de1_top_tb/dut/large_counter/i_count(2) {-radix unsigned} /de1_top_tb/dut/large_counter/i_count(1) {-radix unsigned} /de1_top_tb/dut/large_counter/i_count(0) {-radix unsigned}} /de1_top_tb/dut/large_counter/i_count
add wave -noupdate /de1_top_tb/dut/large_counter/term
add wave -noupdate -divider {My one second timer}
add wave -noupdate -divider {Ten Second Hex Output}
add wave -noupdate -radix unsigned /de1_top_tb/dut/hex1_driver/input
add wave -noupdate -divider {LED Ouputs}
add wave -noupdate /de1_top_tb/dut/ledr
add wave -noupdate /de1_top_tb/dut/current_state
add wave -noupdate /de1_top_tb/dut/next_state
add wave -noupdate -expand /de1_top_tb/key
add wave -noupdate /de1_top_tb/hex0
add wave -noupdate /de1_top_tb/hex1
add wave -noupdate /de1_top_tb/hex2
add wave -noupdate /de1_top_tb/hex3
add wave -noupdate /de1_top_tb/hex4
add wave -noupdate /de1_top_tb/hex5
add wave -noupdate /de1_top_tb/dut/twelve_second_counter/clk
add wave -noupdate /de1_top_tb/dut/twelve_second_counter/data
add wave -noupdate /de1_top_tb/dut/twelve_second_counter/load
add wave -noupdate /de1_top_tb/dut/twelve_second_counter/enable
add wave -noupdate /de1_top_tb/dut/twelve_second_counter/reset
add wave -noupdate /de1_top_tb/dut/twelve_second_counter/count
add wave -noupdate /de1_top_tb/dut/twelve_second_counter/term
add wave -noupdate /de1_top_tb/dut/twelve_second_counter/i_count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {35428 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 260
configure wave -valuecolwidth 100
configure wave -justifyvalue right
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
WaveRestoreZoom {34072 ns} {102216 ns}
