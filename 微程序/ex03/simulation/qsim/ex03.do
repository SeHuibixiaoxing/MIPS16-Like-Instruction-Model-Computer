onerror {exit -code 1}
vlib work
vlog -work work ex03.vo
vlog -work work Waveform1.vwf.vt
vsim -novopt -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.ex03_vlg_vec_tst -voptargs="+acc"
vcd file -direction ex03.msim.vcd
vcd add -internal ex03_vlg_vec_tst/*
vcd add -internal ex03_vlg_vec_tst/i1/*
run -all
quit -f
