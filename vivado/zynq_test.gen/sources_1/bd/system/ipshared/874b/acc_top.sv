`timescale 1ns / 1ps

module acc_top #(
  parameter integer C_S00_AXIS_TDATA_WIDTH = 32,
  parameter integer MAX_WIDTH             = 20,
  parameter integer MIN_WIDTH             = 4,
  parameter integer MAX_LENGTH            = 20,
  parameter integer MIN_LENGTH            = 4,
  parameter integer DWIDTH                = 64,
  parameter integer DIG_MAX               = 32,
  parameter integer FREQ_HZ               = 250000000
) (
  input  wire                                  s00_axis_aclk,
  input  wire                                  s00_axis_aresetn,
  output wire                                  s00_axis_tready,
  input  wire [C_S00_AXIS_TDATA_WIDTH-1:0]     s00_axis_tdata,
  input  wire [(C_S00_AXIS_TDATA_WIDTH/8)-1:0] s00_axis_tstrb,
  input  wire                                  s00_axis_tlast,
  input  wire                                  s00_axis_tvalid,
  output wire                                  m00_axis_tvalid,
  input  wire                                  m00_axis_tready,
  output wire [C_S00_AXIS_TDATA_WIDTH-1:0]     m00_axis_tdata,
  output wire [(C_S00_AXIS_TDATA_WIDTH/8)-1:0] m00_axis_tstrb,
  output wire                                  m00_axis_tlast
);
  wire                                   data_valid;
  wire                                   data_ready;
  wire [DIG_MAX-1:0]                     data_out;
  wire [DIG_MAX-1:0]                     res_matrix_o [MAX_WIDTH-1:0][MAX_LENGTH-1:0];
  wire                                   done_o;

  s_axi_slv # ( 
    .C_S_AXIS_TDATA_WIDTH(C_S00_AXIS_TDATA_WIDTH)
  ) s_axi_slv_inst (
    .S_AXIS_ACLK(s00_axis_aclk),
    .S_AXIS_ARESETN(s00_axis_aresetn),
    .S_AXIS_TREADY(s00_axis_tready),
    .S_AXIS_TDATA(s00_axis_tdata),
    .S_AXIS_TSTRB(s00_axis_tstrb),
    .S_AXIS_TLAST(s00_axis_tlast),
    .S_AXIS_TVALID(s00_axis_tvalid),
    .data_valid(data_valid),
    .data_ready(data_ready),
    .data_out(data_out)
  );  

  matrix_ip #(
    .MAX_WIDTH(MAX_WIDTH),
    .MIN_WIDTH(MIN_WIDTH),
    .MAX_LENGTH(MAX_LENGTH),
    .MIN_LENGTH(MIN_LENGTH),
    .DWIDTH(DWIDTH),
    .DIG_MAX(DIG_MAX)
  ) matrix_ip_inst (
    .clk_i(s00_axis_aclk),
    .srst_i(~s00_axis_aresetn),
    .data_valid(data_valid),
    .data_ready(data_ready),
    .data_in(data_out),
    .res_matrix_o(res_matrix_o),
    .done_o(done_o)
  );

  reg                                    m00_axis_tvalid_int;
  reg [C_S00_AXIS_TDATA_WIDTH-1:0]       m00_axis_tdata_int;
  reg [(C_S00_AXIS_TDATA_WIDTH/8)-1:0]   m00_axis_tstrb_int;
  reg                                    m00_axis_tlast_int;
  reg [9:0]                              output_count;
  reg [4:0]                              out_row, out_col;

  assign m00_axis_tvalid = m00_axis_tvalid_int;
  assign m00_axis_tdata = m00_axis_tdata_int;
  assign m00_axis_tstrb = m00_axis_tstrb_int;
  assign m00_axis_tlast = m00_axis_tlast_int;

  always_ff @(posedge s00_axis_aclk) begin
    if (!s00_axis_aresetn) begin
      m00_axis_tvalid_int <= 0;
      m00_axis_tdata_int <= 0;
      m00_axis_tstrb_int <= 0;
      m00_axis_tlast_int <= 0;
      output_count <= 0;
      out_row <= 0;
      out_col <= 0;
    end else if (done_o && !m00_axis_tvalid_int) begin
      m00_axis_tvalid_int <= 1;
      m00_axis_tstrb_int <= 4'hF;
      m00_axis_tdata_int <= res_matrix_o[0][0];
    end else if (m00_axis_tvalid_int && m00_axis_tready) begin
      m00_axis_tdata_int <= res_matrix_o[out_row][out_col + 1];
      if (out_col == MAX_LENGTH-1) begin
        out_col <= 0;
        out_row <= out_row + 1;
      end else begin
        out_col <= out_col + 1;
      end
      output_count <= output_count + 1;
      if (output_count == MAX_WIDTH * MAX_LENGTH - 2) begin
        m00_axis_tlast_int <= 1;
      end else if (output_count == MAX_WIDTH * MAX_LENGTH - 1) begin
        m00_axis_tvalid_int <= 0;
        m00_axis_tstrb_int <= 0;
        m00_axis_tlast_int <= 0;
        output_count <= 0;
        out_row <= 0;
        out_col <= 0;
      end
    end
  end

endmodule