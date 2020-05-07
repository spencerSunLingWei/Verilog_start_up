vlib work
vlog lab4part2.v
vsim top
log {/*}
add wave {/*}

force {KEY[0]} 0 0ns, 1 {5ns} -r 10ns

force {SW[9]} 0
run 10ns

force {SW[9]} 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 1
force {KEY[1]} 0
force {KEY[2]} 0
force {KEY[3]} 0
run 10ns


force {SW[9]} 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 1
force {KEY[1]} 0
force {KEY[2]} 0
force {KEY[3]} 0
run 10ns

force {SW[9]} 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 1
force {KEY[1]} 0
force {KEY[2]} 0
force {KEY[3]} 1
run 10ns

force {SW[9]} 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 1
force {KEY[1]} 0
force {KEY[2]} 0
force {KEY[3]} 1
run 10ns

force {SW[9]} 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 1
force {KEY[1]} 0
force {KEY[2]} 0
force {KEY[3]} 1
run 10ns

force {SW[9]} 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 1
force {KEY[1]} 0
force {KEY[2]} 0
force {KEY[3]} 1
run 10ns



force {SW[9]} 1
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 1
run 10ns
force {SW[9]} 1
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 1
run 10ns
