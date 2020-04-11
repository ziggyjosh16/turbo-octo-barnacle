onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /de1_top_lab6_tb/aclr_n
add wave -noupdate /de1_top_lab6_tb/clk
add wave -noupdate /de1_top_lab6_tb/sw
add wave -noupdate /de1_top_lab6_tb/key
add wave -noupdate /de1_top_lab6_tb/ledr
add wave -noupdate /de1_top_lab6_tb/hex0
add wave -noupdate /de1_top_lab6_tb/hex1
add wave -noupdate /de1_top_lab6_tb/hex2
add wave -noupdate /de1_top_lab6_tb/hex3
add wave -noupdate /de1_top_lab6_tb/hex4
add wave -noupdate /de1_top_lab6_tb/hex5
add wave -noupdate /de1_top_lab6_tb/CLK_PER
add wave -noupdate -radix unsigned /de1_top_lab6_tb/dut/h5/input
add wave -noupdate /de1_top_lab6_tb/dut/c5
add wave -noupdate /de1_top_lab6_tb/dut/c4
add wave -noupdate /de1_top_lab6_tb/dut/c3
add wave -noupdate /de1_top_lab6_tb/dut/c1
add wave -noupdate /de1_top_lab6_tb/dut/c0
add wave -noupdate /de1_top_lab6_tb/dut/mux_sel_2
add wave -noupdate /de1_top_lab6_tb/dut/mux_sel_1
add wave -noupdate /de1_top_lab6_tb/dut/mux_in_b4
add wave -noupdate /de1_top_lab6_tb/dut/mux_in_b3
add wave -noupdate /de1_top_lab6_tb/dut/data_sa1
add wave -noupdate /de1_top_lab6_tb/dut/data_sa2
add wave -noupdate /de1_top_lab6_tb/dut/data_c
add wave -noupdate /de1_top_lab6_tb/dut/data_02
add wave -noupdate /de1_top_lab6_tb/dut/data_01
add wave -noupdate /de1_top_lab6_tb/dut/data_bmux
add wave -noupdate /de1_top_lab6_tb/dut/data_a
add wave -noupdate /de1_top_lab6_tb/dut/add_b
add wave -noupdate /de1_top_lab6_tb/dut/mult_a
add wave -noupdate /de1_top_lab6_tb/dut/LED1
add wave -noupdate /de1_top_lab6_tb/dut/LED2
add wave -noupdate /de1_top_lab6_tb/dut/LED3
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5069 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 270
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
WaveRestoreZoom {4050 ns} {7872 ns}
