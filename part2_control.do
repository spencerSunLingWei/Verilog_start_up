vlib work
vlog lab7part2.v
vsim control
log {/*}
add wave {/*}

force clk 0 0ns, 1 {5ns} -r 10ns

force resetn 0
force done_plot 0
force plot 0
force load 1
force blackn 1
run 10ns

force resetn 1
force done_plot 0
force plot 0
force load 0
force blackn 1
run 10ns

force resetn 1
force done_plot 0
force plot 0
force load 1
force blackn 1
run 10ns

force resetn 1
force done_plot 0
force plot 1
force load 1
force blackn 1
run 10ns

force resetn 1
force done_plot 0
force plot 1
force load 1
force blackn 0
run 10ns

force resetn 1
force done_plot 1
force plot 1
force load 1
force blackn 1
run 10ns

force resetn 0
force done_plot 0
force plot 0
force load 1
force blackn 1
run 10ns

force resetn 1
force done_plot 0
force plot 0
force load 1
force blackn 0
run 10ns
