vlib work
vlog lab6part2.v
vsim control
log {/*}
add wave {/*}

force clk 0 0ns, 1 {5ns} -r 10ns

#reset
force resetn 0
run 10ns
force resetn 1

force go 0
run 10ns
force go 1
run 10ns
force go 0
run 10ns
force go 1
run 10ns
force go 0
run 10ns
force go 1
run 10ns
force go 0
run 10ns
force go 1
run 10ns
force go 0
run 10ns
force go 1
run 10ns
force go 0
run 10ns
force go 1
run 10ns
force go 0
run 10ns
force go 1
run 10ns
force go 0
run 10ns
force go 1
run 10ns
force go 0
run 10ns