onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /serial/A
add wave -noupdate -radix unsigned /serial/B
add wave -noupdate /serial/start
add wave -noupdate /serial/resetn
add wave -noupdate /serial/clock
add wave -noupdate -radix unsigned -childformat {{/serial/sum(8) -radix unsigned} {/serial/sum(7) -radix unsigned} {/serial/sum(6) -radix unsigned} {/serial/sum(5) -radix unsigned} {/serial/sum(4) -radix unsigned} {/serial/sum(3) -radix unsigned} {/serial/sum(2) -radix unsigned} {/serial/sum(1) -radix unsigned} {/serial/sum(0) -radix unsigned}} -subitemconfig {/serial/sum(8) {-radix unsigned} /serial/sum(7) {-radix unsigned} /serial/sum(6) {-radix unsigned} /serial/sum(5) {-radix unsigned} /serial/sum(4) {-radix unsigned} /serial/sum(3) {-radix unsigned} /serial/sum(2) {-radix unsigned} /serial/sum(1) {-radix unsigned} /serial/sum(0) {-radix unsigned}} /serial/sum
add wave -noupdate /serial/my_control/current_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
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
configure wave -timelineunits ps
update
WaveRestoreZoom {60 ps} {1260 ps}
