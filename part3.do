
vlib work

vlog lab7part3forsimulation.v

vsim mymodule

log {/*}
add wave {/*}

force clk 1 0ns, 0 {5ns} -r 10ns
force resetn 0
run 10ns
force resetn 1

force colour_in 3'b111
run 10000ns

