# Assumption is you are running this from the ./simulation directory
# then from the modelesim command prompt type
# do run.do
# if the library work does not exist, create it and then map it
# if the library work does exist, then it will ignore the commands
vlib work
vmap work work
# compile the IP source code from megawizards
vcom -reportprogress 300 -work work ../ip_megawizards/clocka_pll_sim/clocka_pll.vho
vcom -reportprogress 300 -work work ../ip_megawizards/clockb_pll_sim/clockb_pll.vho
vcom -reportprogress 300 -work work ../ip_megawizards/clocka_fifo.vhd
# compile the source code
vcom -reportprogress 300 -work work ../vhdl_source/data_sink.vhd
vcom -reportprogress 300 -work work ../vhdl_source/data_source.vhd
vcom -reportprogress 300 -work work ../vhdl_source/frazzle.vhd
vcom -reportprogress 300 -work work ../vhdl_source/wumpus.vhd
vcom -reportprogress 300 -work work ../vhdl_source/de1_soc_top.vhd
# compile the test bench
vcom -reportprogress 300 -work work ./timing_tb.vhd
quit -sim
# load the design for simulation, load the testbench
vsim -voptargs=+acc work.timing_tb
# load up the simulation wave window which has the signals we want to look at
do wave.do
run 10000ns
