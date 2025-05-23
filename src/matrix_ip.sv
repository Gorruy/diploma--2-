module matrix_ip (
  parameter MAX_WIDTH  = 20,
  parameter MIN_WIDTH  = 4,
  parameter MAX_LENGTH = 20,
  parameter MIN_LENGTH = 4,
  parameter DWIDTH     = 64
) (
  input  logic  clk_i,
  input  logic  srst_i,

  output logic done_o
);
  loclaparam MAT_NUM = MAX_WIDTH / MIN_WIDTH;

  localparam DIG_MAX = 32;

  logic [DIG_MAX - 1:0] a_matrix   [MAX_WIDTH - 1:0][MAX_LENGTH - 1:0];
  logic [DIG_MAX - 1:0] b_matrix   [MAX_WIDTH - 1:0][MAX_LENGTH - 1:0];
  logic [DIG_MAX - 1:0] res_matrix [MAX_WIDTH - 1:0][MAX_LENGTH - 1:0];

  logic [DIG_MAX - 1:0] inter_matr [MAT_NUM:0][MIN_WIDTH - 1:0][MIN_LENGTH - 1:0];
  logic [DIG_MAX - 1:0] current_am [MAT_NUM:0][MIN_WIDTH - 1:0][MIN_LENGTH - 1:0];
  logic [DIG_MAX - 1:0] current_bm [MAT_NUM:0][MIN_WIDTH - 1:0][MIN_LENGTH - 1:0];

  genvar i;

  generate
    for ( i = 0; i < MAT_NUM; i++ )
      begin
        matrix_block_mul #(
        .WIDTH      ( MIN_WIDTH     ),
        .LENGTH     ( MIN_LENGTH    ),
        .DIG_MAX    ( DIG_MAX       )
        ) matrix_block_mul_inst (
        .clk_i      ( clk_i         ),
        .srst_i     ( srst_i        ),
        .a_matrix   ( current_am[i] ),
        .b_matrix   ( current_bm[i] ),
        .res_matrix ( inter_matr[i] ),
        );
      end
  endgenerate



endmodule