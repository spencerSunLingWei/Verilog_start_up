vlib work

vlog lab6part1.v

vsim sequence_detector

log {/*}

add wave {/*}

force {KEY[0]} 0 0ns, 1 {5ns} -r 10ns

force {SW[0]} 0
run 12ns

force {SW[0]} 1
force {SW[1]} 0
run 10ns


force {SW[0]} 1
force {SW[1]} 1
run 30ns


force {SW[0]} 1
force {SW[1]} 0
run 10ns

force {SW[0]} 1
force {SW[1]} 1
run 10ns

force {SW[0]} 1
force {SW[1]} 0
run 10ns

force {SW[0]} 1
force {SW[1]} 0
run 10ns

force {SW[0]} 1
force {SW[1]} 1
run 20ns

force {SW[0]} 1
force {SW[1]} 0
run 10ns

force {SW[0]} 1
force {SW[1]} 0
run 20ns

force {SW[0]} 1
force {SW[1]} 1
run 20ns

force {SW[0]} 1
force {SW[1]} 0
run 10ns

force {SW[0]} 1
force {SW[1]} 1
run 10ns

force {SW[0]} 1
force {SW[1]} 0
run 10ns

force {SW[0]} 1
force {SW[1]} 0
run 10ns

force {SW[0]} 1
force {SW[1]} 1
run 40ns
force {SW[0]} 1
force {SW[1]} 0
run 10ns


