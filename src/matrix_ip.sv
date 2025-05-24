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
  localparam SHIFT_S = $clog2(MAT_NUM);
  localparam DIG_MAX = 32;
  localparam DONE_RS = $clog2(MAT_NUM**2);

  // Intentionally using a lot of distributed mem 
  (* ram_style = "distribute" *) logic [DIG_MAX - 1:0] a_matrix   [MAX_WIDTH - 1:0][MAX_LENGTH - 1:0];
  (* ram_style = "distribute" *) logic [DIG_MAX - 1:0] b_matrix   [MAX_WIDTH - 1:0][MAX_LENGTH - 1:0];
  (* ram_style = "distribute" *) logic [DIG_MAX - 1:0] res_matrix [MAX_WIDTH - 1:0][MAX_LENGTH - 1:0];

  (* ram_style = "distribute" *) logic [DIG_MAX - 1:0] inter_matr [MAT_NUM:0][MIN_WIDTH - 1:0][MIN_LENGTH - 1:0];
  (* ram_style = "distribute" *) logic [DIG_MAX - 1:0] current_am [MAT_NUM:0][MIN_WIDTH - 1:0][MIN_LENGTH - 1:0];
  (* ram_style = "distribute" *) logic [DIG_MAX - 1:0] current_bm [MAT_NUM:0][MIN_WIDTH - 1:0][MIN_LENGTH - 1:0];


  logic [SHIFT_S - 1:0] xshift;
  logic [SHIFT_S - 1:0] yshift;

  logic [DONE_RS - 1:0] done_reg;

  logic [MAT_NUM - 1:0] dones;

  logic                 run;

  assign done_o == ( done_reg == MAT_NUM**2 );

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
        .done_o     ( dones[i]      )
        );
      end
  endgenerate

  always_ff @( posedge clk_i )
    begin
      if ( srst_i )
        xshift   <= '0;
      else if ( run && dones == '1 )
        begin
          if ( xshift == (SHIFT_S)'(MAT_NUM - 1) )
            xshift <= '0;
          else
            xshift <= xshift + (SHIFT_S)'(1);
        end
    end

  always_ff @( posedge clk_i )
    begin
      if ( srst_i )
        yshift <= '0;
      else if ( run && xshift == (SHIFT_S)'(MAT_NUM - 1) && dones == '1 )
        yshift <= yshift + (SHIFT_S)'(1);
    end

  always_ff @( posedge clk_i )
    begin
      if ( srst_i )
        done_reg <= '0;
      else if ( run && dones == '1 )
        done_reg <= done_reg + (DONE_RS)'(1);
    end

  always_comb
    begin
      for ( int i = 0; i < MAT_NUM; i++ )
        begin
          current_am = a_matrix[0 + MIN_WIDTH * xshift * i:+MIN_WIDTH][0 + MIN_LENGTH * yshift * i:+MIN_LENGTH];
          current_bm = b_matrix[0 + MIN_LENGTH * yshift * i:+MIN_LENGTH][0 + MIN_WIDTH * xshift * i:+MIN_WIDTH];
        end
    end

  always_ff @( posedge clk_i )
    begin
      for ( int i = 0; i < MAT_NUM; i++ )
        begin
          res_matrix[0 + MIN_WIDTH * xshift:+MIN_WIDTH][0 + MIN_LENGTH * yshift:+MIN_LENGTH] += inter_matr[i];
        end
    end

endmodule