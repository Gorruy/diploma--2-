vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xilinx_vip
vlib questa_lib/msim/axi_infrastructure_v1_1_0
vlib questa_lib/msim/axi_vip_v1_1_17
vlib questa_lib/msim/processing_system7_vip_v1_0_19
vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/xlconcat_v2_1_6

vmap xilinx_vip questa_lib/msim/xilinx_vip
vmap axi_infrastructure_v1_1_0 questa_lib/msim/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_17 questa_lib/msim/axi_vip_v1_1_17
vmap processing_system7_vip_v1_0_19 questa_lib/msim/processing_system7_vip_v1_0_19
vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap xlconcat_v2_1_6 questa_lib/msim/xlconcat_v2_1_6

vlog -work xilinx_vip -64 -incr -mfcu  -sv -L axi_vip_v1_1_17 -L processing_system7_vip_v1_0_19 -L xilinx_vip "+incdir+/mnt/big_chungus/vivada/Vivado/2024.1/data/xilinx_vip/include" \
"/mnt/big_chungus/vivada/Vivado/2024.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/mnt/big_chungus/vivada/Vivado/2024.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/mnt/big_chungus/vivada/Vivado/2024.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/mnt/big_chungus/vivada/Vivado/2024.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/mnt/big_chungus/vivada/Vivado/2024.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/mnt/big_chungus/vivada/Vivado/2024.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/mnt/big_chungus/vivada/Vivado/2024.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/mnt/big_chungus/vivada/Vivado/2024.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/mnt/big_chungus/vivada/Vivado/2024.1/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work axi_infrastructure_v1_1_0 -64 -incr -mfcu  "+incdir+../../../../zynq_test.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_test.gen/sources_1/bd/system/ipshared/b28c/hdl" "+incdir+/mnt/big_chungus/vivada/Vivado/2024.1/data/xilinx_vip/include" \
"../../../../zynq_test.gen/sources_1/bd/system/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_17 -64 -incr -mfcu  -sv -L axi_vip_v1_1_17 -L processing_system7_vip_v1_0_19 -L xilinx_vip "+incdir+../../../../zynq_test.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_test.gen/sources_1/bd/system/ipshared/b28c/hdl" "+incdir+/mnt/big_chungus/vivada/Vivado/2024.1/data/xilinx_vip/include" \
"../../../../zynq_test.gen/sources_1/bd/system/ipshared/4d04/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work processing_system7_vip_v1_0_19 -64 -incr -mfcu  -sv -L axi_vip_v1_1_17 -L processing_system7_vip_v1_0_19 -L xilinx_vip "+incdir+../../../../zynq_test.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_test.gen/sources_1/bd/system/ipshared/b28c/hdl" "+incdir+/mnt/big_chungus/vivada/Vivado/2024.1/data/xilinx_vip/include" \
"../../../../zynq_test.gen/sources_1/bd/system/ipshared/b28c/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../zynq_test.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_test.gen/sources_1/bd/system/ipshared/b28c/hdl" "+incdir+/mnt/big_chungus/vivada/Vivado/2024.1/data/xilinx_vip/include" \
"../../../bd/system/ip/system_processing_system7_0_0/sim/system_processing_system7_0_0.v" \

vlog -work xlconcat_v2_1_6 -64 -incr -mfcu  "+incdir+../../../../zynq_test.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_test.gen/sources_1/bd/system/ipshared/b28c/hdl" "+incdir+/mnt/big_chungus/vivada/Vivado/2024.1/data/xilinx_vip/include" \
"../../../../zynq_test.gen/sources_1/bd/system/ipshared/6120/hdl/xlconcat_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../zynq_test.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_test.gen/sources_1/bd/system/ipshared/b28c/hdl" "+incdir+/mnt/big_chungus/vivada/Vivado/2024.1/data/xilinx_vip/include" \
"../../../bd/system/ip/system_xlconcat_0_0/sim/system_xlconcat_0_0.v" \
"../../../bd/system/ip/system_xlconcat_1_0/sim/system_xlconcat_1_0.v" \
"../../../bd/system/sim/system.v" \

vlog -work xil_defaultlib \
"glbl.v"

