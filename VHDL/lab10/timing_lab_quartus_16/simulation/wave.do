onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /timing_tb/dut/clock_50
add wave -noupdate /timing_tb/dut/td_clk27
add wave -noupdate /timing_tb/dut/key
add wave -noupdate /timing_tb/dut/clocka
add wave -noupdate /timing_tb/dut/clockb
add wave -noupdate -divider {You Can Display In Analog}
add wave -noupdate -format Analog-Step -height 256 -max 256.0 -radix unsigned -childformat {{/timing_tb/dut/source_data(7) -radix unsigned} {/timing_tb/dut/source_data(6) -radix unsigned} {/timing_tb/dut/source_data(5) -radix unsigned} {/timing_tb/dut/source_data(4) -radix unsigned} {/timing_tb/dut/source_data(3) -radix unsigned} {/timing_tb/dut/source_data(2) -radix unsigned} {/timing_tb/dut/source_data(1) -radix unsigned} {/timing_tb/dut/source_data(0) -radix unsigned}} -subitemconfig {/timing_tb/dut/source_data(7) {-height 15 -radix unsigned} /timing_tb/dut/source_data(6) {-height 15 -radix unsigned} /timing_tb/dut/source_data(5) {-height 15 -radix unsigned} /timing_tb/dut/source_data(4) {-height 15 -radix unsigned} /timing_tb/dut/source_data(3) {-height 15 -radix unsigned} /timing_tb/dut/source_data(2) {-height 15 -radix unsigned} /timing_tb/dut/source_data(1) {-height 15 -radix unsigned} /timing_tb/dut/source_data(0) {-height 15 -radix unsigned}} /timing_tb/dut/source_data
add wave -noupdate /timing_tb/dut/stall_data_sink
add wave -noupdate -radix hexadecimal -childformat {{/timing_tb/dut/sink_data(7) -radix hexadecimal} {/timing_tb/dut/sink_data(6) -radix hexadecimal} {/timing_tb/dut/sink_data(5) -radix hexadecimal} {/timing_tb/dut/sink_data(4) -radix hexadecimal} {/timing_tb/dut/sink_data(3) -radix hexadecimal} {/timing_tb/dut/sink_data(2) -radix hexadecimal} {/timing_tb/dut/sink_data(1) -radix hexadecimal} {/timing_tb/dut/sink_data(0) -radix hexadecimal}} -subitemconfig {/timing_tb/dut/sink_data(7) {-height 15 -radix hexadecimal} /timing_tb/dut/sink_data(6) {-height 15 -radix hexadecimal} /timing_tb/dut/sink_data(5) {-height 15 -radix hexadecimal} /timing_tb/dut/sink_data(4) {-height 15 -radix hexadecimal} /timing_tb/dut/sink_data(3) {-height 15 -radix hexadecimal} /timing_tb/dut/sink_data(2) {-height 15 -radix hexadecimal} /timing_tb/dut/sink_data(1) {-height 15 -radix hexadecimal} /timing_tb/dut/sink_data(0) {-height 15 -radix hexadecimal}} /timing_tb/dut/sink_data
add wave -noupdate -radix hexadecimal /timing_tb/dut/data_outa
add wave -noupdate /timing_tb/dut/ledr
add wave -noupdate -radix hexadecimal /timing_tb/dut/data_wumpus
add wave -noupdate /timing_tb/dut/push_wumpus
add wave -noupdate /timing_tb/dut/halt_data_source
add wave -noupdate /timing_tb/dut/source_full
add wave -noupdate /timing_tb/dut/source_empty
add wave -noupdate -radix hexadecimal /timing_tb/dut/source_filled
add wave -noupdate /timing_tb/dut/source_wr
add wave -noupdate /timing_tb/dut/sink_empty
add wave -noupdate -radix hexadecimal /timing_tb/dut/sink_filled
add wave -noupdate /timing_tb/dut/out_full
add wave -noupdate /timing_tb/dut/out_rd
add wave -noupdate /timing_tb/dut/out_rdy
add wave -noupdate /timing_tb/dut/rst
add wave -noupdate /timing_tb/dut/wump_rdy
add wave -noupdate /timing_tb/dut/in_rd
add wave -noupdate /timing_tb/dut/pkt_avail
add wave -noupdate /timing_tb/dut/plla/locked
add wave -noupdate /timing_tb/dut/pllb/locked
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6145000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 224
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
WaveRestoreZoom {0 ps} {21 us}
