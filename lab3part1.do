vlib work
vlog lab3part1.v
vsim top
log {/*}
add wave {/*}

force {SW[9]} 0
force {SW[8]} 0
force {SW[7]} 0
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0

run 10ns

force {SW[9]} 0
force {SW[8]} 0
force {SW[7]} 1
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0


run 10ns

force {SW[9]} 0
force {SW[8]} 1
force {SW[7]} 0
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
run 10ns

force {SW[9]} 0
force {SW[8]} 1
force {SW[7]} 1
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 0
force {SW[5]} 0
run 10ns


force {SW[9]} 1
force {SW[8]} 0
force {SW[7]} 0
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 0
run 10ns

force {SW[9]} 1
force {SW[8]} 0
force {SW[7]} 1
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 1
run 10ns


