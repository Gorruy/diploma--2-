transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib activehdl/xilinx_vip
vlib activehdl/axi_infrastructure_v1_1_0
vlib activehdl/axi_vip_v1_1_17
vlib activehdl/processing_system7_vip_v1_0_19
vlib activehdl/xil_defaultlib
vlib activehdl/xlconcat_v2_1_6

vmap xilinx_vip activehdl/xilinx_vip
vmap axi_infrastructure_v1_1_0 activehdl/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_17 activehdl/axi_vip_v1_1_17
vmap processing_system7_vip_v1_0_19 activehdl/processing_system7_vip_v1_0_19
vmap xil_defaultlib activehdl/xil_defaultlib
vmap xlconcat_v2_1_6 activehdl/xlconcat_v2_1_6

vlog -work xilinx_vip  -sv2k12 "+incdir+/mnt/big_chungus/vivada/Vivado/2024.1/data/xilinx_vip/include" -l xilinx_vip -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l processing_system7_vip_v1_0_19 -l xil_defaultlib -l xlconcat_v2_1_6 \
"/mnt/big_chungus/vivada/Vivado/2024.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/mnt/big_chungus/vivada/Vivado/2024.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/mnt/big_chungus/vivada/Vivado/2024.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/mnt/big_chungus/vivada/Vivado/2024.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/mnt/big_chungus/vivada/Vivado/2024.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/mnt/big_chungus/vivada/Vivado/2024.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/mnt/big_chungus/vivada/Vivado/2024.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/mnt/big_chungus/vivada/Vivado/2024.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/mnt/big_chungus/vivada/Vivado/2024.1/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work axi_infrastructure_v1_1_0  -v2k5 "+incdir+../../../../zynq_test.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_test.gen/sources_1/bd/system/ipshared/b28c/hdl" "+incdir+/mnt/big_chungus/vivada/Vivado/2024.1/data/xilinx_vip/include" -l xilinx_vip -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l processing_system7_vip_v1_0_19 -l xil_defaultlib -l xlconcat_v2_1_6 \
"../../../../zynq_test.gen/sources_1/bd/system/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_17  -sv2k12 "+incdir+../../../../zynq_test.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_test.gen/sources_1/bd/system/ipshared/b28c/hdl" "+incdir+/mnt/big_chungus/vivada/Vivado/2024.1/data/xilinx_vip/include" -l xilinx_vip -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l processing_system7_vip_v1_0_19 -l xil_defaultlib -l xlconcat_v2_1_6 \
"../../../../zynq_test.gen/sources_1/bd/system/ipshared/4d04/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work processing_system7_vip_v1_0_19  -sv2k12 "+incdir+../../../../zynq_test.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_test.gen/sources_1/bd/system/ipshared/b28c/hdl" "+incdir+/mnt/big_chungus/vivada/Vivado/2024.1/data/xilinx_vip/include" -l xilinx_vip -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l processing_system7_vip_v1_0_19 -l xil_defaultlib -l xlconcat_v2_1_6 \
"../../../../zynq_test.gen/sources_1/bd/system/ipshared/b28c/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../zynq_test.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_test.gen/sources_1/bd/system/ipshared/b28c/hdl" "+incdir+/mnt/big_chungus/vivada/Vivado/2024.1/data/xilinx_vip/include" -l xilinx_vip -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l processing_system7_vip_v1_0_19 -l xil_defaultlib -l xlconcat_v2_1_6 \
"../../../bd/system/ip/system_processing_system7_0_0/sim/system_processing_system7_0_0.v" \

vlog -work xlconcat_v2_1_6  -v2k5 "+incdir+../../../../zynq_test.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_test.gen/sources_1/bd/system/ipshared/b28c/hdl" "+incdir+/mnt/big_chungus/vivada/Vivado/2024.1/data/xilinx_vip/include" -l xilinx_vip -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l processing_system7_vip_v1_0_19 -l xil_defaultlib -l xlconcat_v2_1_6 \
"../../../../zynq_test.gen/sources_1/bd/system/ipshared/6120/hdl/xlconcat_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../zynq_test.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_test.gen/sources_1/bd/system/ipshared/b28c/hdl" "+incdir+/mnt/big_chungus/vivada/Vivado/2024.1/data/xilinx_vip/include" -l xilinx_vip -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l processing_system7_vip_v1_0_19 -l xil_defaultlib -l xlconcat_v2_1_6 \
"../../../bd/system/ip/system_xlconcat_0_0/sim/system_xlconcat_0_0.v" \
"../../../bd/system/ip/system_xlconcat_1_0/sim/system_xlconcat_1_0.v" \
"../../../bd/system/sim/system.v" \

vlog -work xil_defaultlib \
"glbl.v"

