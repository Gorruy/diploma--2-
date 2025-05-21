module acc_top #
(
  // AXI SPECIFIC
  parameter integer C_S00_AXIS_TDATA_WIDTH	= 32
) (
  // AXI SPECIFIC
  input wire  s00_axis_aclk,
  input wire  s00_axis_aresetn,
  output wire  s00_axis_tready,
  input wire [C_S00_AXIS_TDATA_WIDTH-1 : 0] s00_axis_tdata,
  input wire [(C_S00_AXIS_TDATA_WIDTH/8)-1 : 0] s00_axis_tstrb,
  input wire  s00_axis_tlast,
  input wire  s00_axis_tvalid
);
// Instantiation of Axi Bus Interface SAXIS
s_axi_slv # ( 
  .C_S_AXIS_TDATA_WIDTH(C_S00_AXIS_TDATA_WIDTH)
) s_axi_slv_inst (
  .S_AXIS_ACLK(s00_axis_aclk),
  .S_AXIS_ARESETN(s00_axis_aresetn),
  .S_AXIS_TREADY(s00_axis_tready),
  .S_AXIS_TDATA(s00_axis_tdata),
  .S_AXIS_TSTRB(s00_axis_tstrb),
  .S_AXIS_TLAST(s00_axis_tlast),
  .S_AXIS_TVALID(s00_axis_tvalid)
);

endmodule