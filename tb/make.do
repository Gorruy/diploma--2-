vlog -sv ../src/matrix_block_mul.sv
vlog -sv matrix_block_mul_tb.sv

vsim -voptargs="+acc" work.matrix_block_mul_tb

add wave -noupdate  \
sim:/matrix_block_mul_tb/DUT/clk_i \
sim:/matrix_block_mul_tb/DUT/srst_i \
sim:/matrix_block_mul_tb/DUT/start_i \
sim:/matrix_block_mul_tb/DUT/a_matrix \
sim:/matrix_block_mul_tb/DUT/b_matrix \
sim:/matrix_block_mul_tb/DUT/c_matrix \
sim:/matrix_block_mul_tb/DUT/one_cycle_c_row \
sim:/matrix_block_mul_tb/DUT/current_c_row \
sim:/matrix_block_mul_tb/DUT/done_o \

run -all