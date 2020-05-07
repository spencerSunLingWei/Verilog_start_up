vlib work 

vlog lab7part1.v
vsim -L altera_mf_ver top

log {/*}
add wave {/*}

force {KEY[0]} 0 0ns, 1 {5ns} -r 10ns


force {SW[8:4]} 5'b00001
force {SW[3:0]} 4'b0000
force {SW[9]} 0
run 10ns


force {SW[8:4]} 5'b00010
force {SW[3:0]} 4'b0000
force {SW[9]} 0
run 10ns


force {SW[8:4]} 5'b00001
force {SW[3:0]} 4'b0010
force {SW[9]} 1
run 10ns

force {SW[8:4]} 5'b00001
force {SW[3:0]} 4'b0011
force {SW[9]} 1
run 10ns

force {SW[8:4]} 5'b00010
force {SW[3:0]} 4'b0111
force {SW[9]} 1
run 10ns

force {SW[8:4]} 5'b00001
force {SW[3:0]} 4'b0000
force {SW[9]} 0
run 10ns


force {SW[8:4]} 5'b00010
force {SW[3:0]} 4'b0000
force {SW[9]} 0
run 10ns