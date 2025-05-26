vlog -sv ../src/matrix_block_mul.sv 
vlog ../src/s_axi_slv.v 
vlog -sv ../src/matrix_ip.sv 
vlog -sv ../src/acc_top.sv 
vlog -sv top_tb.sv

vsim work.top_tb

add wave -noupdate \
sim:/top_tb/s00_axis_aclk \
sim:/top_tb/s00_axis_aresetn \
sim:/top_tb/s00_axis_tvalid \
sim:/top_tb/s00_axis_tready \
sim:/top_tb/s00_axis_tdata \
sim:/top_tb/s00_axis_tstrb \
sim:/top_tb/s00_axis_tlast \
sim:/top_tb/m00_axis_tvalid \
sim:/top_tb/m00_axis_tready \
sim:/top_tb/m00_axis_tdata \
sim:/top_tb/m00_axis_tstrb \
sim:/top_tb/m00_axis_tlast \
sim:/top_tb/DUT/matrix_ip_inst/state \ 
sim:/top_tb/DUT/matrix_ip_inst/data_valid \ 
sim:/top_tb/DUT/matrix_ip_inst/data_ready \ 
sim:/top_tb/DUT/matrix_ip_inst/data_in \ 
sim:/top_tb/DUT/matrix_ip_inst/row_load \ 
sim:/top_tb/DUT/matrix_ip_inst/column_load \ 
sim:/top_tb/DUT/matrix_ip_inst/out_row \ 
sim:/top_tb/DUT/matrix_ip_inst/out_col \ 
sim:/top_tb/DUT/matrix_ip_inst/a_matrix \ 
sim:/top_tb/DUT/matrix_ip_inst/b_matrix \ 
sim:/top_tb/DUT/matrix_ip_inst/res_matrix \ 
sim:/top_tb/DUT/matrix_ip_inst/done_o

run -all