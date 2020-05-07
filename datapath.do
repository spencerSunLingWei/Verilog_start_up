vlib work
vlog poly_function.v
vsim datapath
log {/*}
add wave {/*}

force clk 0 0ns, 1 {5ns} -r 10ns

#reset
force resetn 0
run 12ns

#load a value
force data_in 0000010
force resetn 1
force ld_a 1
force ld_b 0
force ld_c 0
force ld_x 0
force ld_alu_out 0
force alu_select_a 0
force alu_select_b 0
force alu_op 0
force ld_r 0
run 10ns
#load b value
force resetn 1
force data_in 0000011
force ld_a 0
force ld_b 1
force ld_c 0
force ld_x 0
force ld_alu_out 0
force alu_select_a 0
force alu_select_b 0
force alu_op 0
force ld_r 0
run 10ns
#load c value
force resetn 1
force data_in 0000100
force ld_a 0
force ld_b 0
force ld_c 1
force ld_x 0
force ld_alu_out 0
force alu_select_a 0
force alu_select_b 0
force alu_op 0
force ld_r 0
run 10ns
#load x value
force resetn 1
force data_in 0010100
force ld_a 0
force ld_b 0
force ld_c 0
force ld_x 1
force ld_alu_out 0
force alu_select_a 0
force alu_select_b 0
force alu_op 0
force ld_r 0
run 10ns

#select a & a and multiply and stored in a value
force data_in 00000000
force resetn 1
force ld_a 1
force ld_b 0
force ld_c 0
force ld_x 0
force ld_alu_out 1
force alu_select_a 00
force alu_select_b 00
force alu_op 1
force ld_r 0
run 10ns


#select a & c plus and display
force data_in 00000000
force resetn 1
force ld_a 0
force ld_b 0
force ld_c 0
force ld_x 0
force ld_alu_out 0
force alu_select_a 00
force alu_select_b 10
force alu_op 0
force ld_r 1
run 10ns




#final display
force data_in 00000000
force resetn 1
force ld_a 0
force ld_b 0
force ld_c 0
force ld_x 0
force ld_alu_out 0
force alu_select_a 00
force alu_select_b 00
force alu_op 0
force ld_r 0
run 10ns






