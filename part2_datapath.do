vlib work

vlog Lab7part2.v

vsim datapath

log {/*}
add wave {/*}

force clk 1 0ns, 0 {5ns} -r 10ns

force resetn 0
run 10ns

force resetn 1
force position 7'b1010001
force ld_x 1
force ld_y 0
force colour_in 3'b010
force go_clear 0
force go_plot 0

run 10ns

force position 7'b1010001
force ld_x 0
force ld_y 1
force colour_in 3'b010
force go_clear 0
force go_plot 0
run 10ns

force ld_x 0
force ld_y 0
run 10ns

force go_plot 1
run 160ns


force resetn 1
force position 7'b1000001
force ld_x 1
force ld_y 0
force colour_in 3'b011
force go_clear 0
force go_plot 0

run 10ns

force position 7'b1000001
force ld_x 0
force ld_y 1
force colour_in 3'b011
force go_clear 0
force go_plot 0
run 10ns

force ld_x 0
force ld_y 0
run 10ns

force go_plot 1
run 160ns


force go_clear 1
force go_plot 1
run 20ns

force resetn 0
run 10ns
