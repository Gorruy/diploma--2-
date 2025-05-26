module matrix_ip #(
  parameter MAX_WIDTH  = 20,
  parameter MIN_WIDTH  = 4,
  parameter MAX_LENGTH = 20,
  parameter MIN_LENGTH = 4,
  parameter DWIDTH     = 64,
  parameter DIG_MAX    = 32
) (
  input  logic                 clk_i,
  input  logic                 srst_i,
  input  logic                 data_valid,
  output logic                 data_ready,
  input  logic [DIG_MAX - 1:0] data_in,
  output logic [DIG_MAX - 1:0] res_matrix_o [MAX_WIDTH - 1:0][MAX_LENGTH - 1:0],
  output logic                 done_o
);

  localparam MAT_NUM = MAX_WIDTH / MIN_WIDTH;
  localparam SHIFT_S = $clog2(MAT_NUM);
  localparam DONE_RS = $clog2(MAT_NUM**2);
  localparam LOAD_SZ = $clog2(MAX_WIDTH);

  // Intentionally using a lot of distributed mem 
  (* ram_style = "distribute" *) logic [DIG_MAX - 1:0] a_matrix   [MAX_WIDTH - 1:0][MAX_LENGTH - 1:0];
  (* ram_style = "distribute" *) logic [DIG_MAX - 1:0] b_matrix   [MAX_WIDTH - 1:0][MAX_LENGTH - 1:0];
  (* ram_style = "distribute" *) logic [DIG_MAX - 1:0] res_matrix [MAX_WIDTH - 1:0][MAX_LENGTH - 1:0];

  (* ram_style = "distribute" *) logic [DIG_MAX - 1:0] inter_matr [MAT_NUM - 1:0][MIN_WIDTH - 1:0][MIN_LENGTH - 1:0];
  (* ram_style = "distribute" *) logic [DIG_MAX - 1:0] current_am [MAT_NUM - 1:0][MIN_WIDTH - 1:0][MIN_LENGTH - 1:0];
  (* ram_style = "distribute" *) logic [DIG_MAX - 1:0] current_bm [MAT_NUM - 1:0][MIN_WIDTH - 1:0][MIN_LENGTH - 1:0];

  logic [SHIFT_S - 1:0] xshift;
  logic [SHIFT_S - 1:0] yshift;
  logic [DONE_RS - 1:0] done_reg;
  logic [MAT_NUM - 1:0] dones;
  logic                 run;
  logic [LOAD_SZ - 1:0] column_load;
  logic [LOAD_SZ - 1:0] row_load;
  logic                 start;

  typedef enum logic [2:0] {
    IDLE,
    LOAD_A,
    LOAD_B,
    COMPUTE,
    DONE
  } state_t;

  state_t state;
  state_t next_state;

  assign start        = ( state == COMPUTE );
  assign res_matrix_o = res_matrix;

  genvar i;

  generate
    for ( i = 0; i < MAT_NUM; i++ )
      begin
        matrix_block_mul #(
        .WIDTH    ( MIN_WIDTH     ),
        .LENGTH   ( MIN_LENGTH    ),
        .DIG_MAX  ( DIG_MAX       )
        ) matrix_block_mul_inst (
        .clk_i    ( clk_i         ),
        .srst_i   ( srst_i        ),
        .a_matrix ( current_am[i] ),
        .b_matrix ( current_bm[i] ),
        .c_matrix ( inter_matr[i] ),
        .done_o   ( dones[i]      ),
        .start_i  ( start         )
        );
      end
  endgenerate

  always_ff @( posedge clk_i )
    begin
      if ( srst_i )
        state <= IDLE;
      else
        state <= next_state;
    end

  always_comb
    begin
      next_state = state;

      case( state )

        IDLE:begin
          if ( data_ready && data_valid )
            next_state = LOAD_A;
        end

        LOAD_A:begin
          if ( column_load == (LOAD_SZ)'(MAX_LENGTH) && row_load == (LOAD_SZ)'(MAX_WIDTH) )
            next_state = LOAD_B;
        end

        LOAD_B:begin
          if ( column_load == (LOAD_SZ)'(MAX_LENGTH) && row_load == (LOAD_SZ)'(MAX_WIDTH) )
            next_state = COMPUTE;
        end

        COMPUTE:begin
          if ( xshift == MAT_NUM**2 && yshift == MAT_NUM**2 )
            next_state = DONE;
        end

        DONE:begin
          if ( column_load == (LOAD_SZ)'(MAX_LENGTH) && row_load == (LOAD_SZ)'(MAX_WIDTH) )
            next_state = IDLE;
        end

        default: begin
          next_state = state_t'('x);
        end

      endcase

    end

  always_comb
    begin
      done_o     = 1'b0;
      data_ready = 1'b0;

      case (state)

        IDLE:begin
          done_o     = 1'b0;
          data_ready = 1'b1;
        end

        LOAD_A:begin
          done_o     = 1'b0;
          data_ready = 1'b1;
        end

        LOAD_B:begin
          done_o     = 1'b0;
          data_ready = 1'b1;
        end

        COMPUTE:begin
          done_o     = 1'b0;
          data_ready = 1'b0;
        end

        DONE:begin
          done_o     = 1'b1;
          data_ready = 1'b0;
        end

        default: begin
          done_o     = 'x;
          data_ready = 'x;
        end

      endcase

    end

  always_ff @( posedge clk_i )
    begin
      if ( state == LOAD_A )
        a_matrix[row_load][column_load] <= data_in;
    end

  always_ff @( posedge clk_i )
    begin
      if ( state == LOAD_B )
        b_matrix[row_load][column_load] <= data_in;
    end

  always_ff @( posedge clk_i )
    begin
      if ( state == IDLE )
        begin
          row_load    <= '0;
          column_load <= '0;
        end
      else if ( state == LOAD_A || state == LOAD_B )
        begin
          if ( column_load == MAX_WIDTH )
            begin
              row_load    <= row_load + (LOAD_SZ)'(1);
              column_load <= '0;
            end
          else
            begin
              column_load <= column_load + (LOAD_SZ)'(1);
            end
        end
    end

  always_ff @( posedge clk_i )
    begin
      if ( state == IDLE )
        xshift   <= '0;
      else if ( state == COMPUTE && dones == '1 )
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
      else if ( state == COMPUTE && xshift == (SHIFT_S)'(MAT_NUM - 1) && dones == '1 )
        yshift <= yshift + (SHIFT_S)'(1);
    end

  always_ff @( posedge clk_i )
    begin
      if ( state == IDLE )
        done_reg <= '0;
      else if ( state == COMPUTE && dones == '1 )
        done_reg <= done_reg + (DONE_RS)'(1);
    end

  always_comb
    begin
      for ( int i = 0; i < MAT_NUM; i++ )
        begin
          for ( int m = 0; m < MIN_WIDTH; m++ )
            for ( int n = 0; n < MIN_LENGTH; n++ )
              begin
                current_am[i][m][n] = a_matrix[MIN_WIDTH * i + m][MIN_LENGTH * yshift * i + n];
                current_bm[i][m][n] = b_matrix[MIN_LENGTH * i + m][MIN_WIDTH * i + n];
              end
        end
    end

    always_ff @( posedge clk_i )
      begin
        for ( int i = 0; i < MAT_NUM; i++ )
          begin
            for ( int m = 0; m < MIN_WIDTH; m++ )
              for ( int n = 0; n < MIN_LENGTH; n++ )
                res_matrix[xshift*MIN_WIDTH + m][yshift*MIN_LENGTH + n] <= inter_matr[i][m][n] + res_matrix[xshift*MIN_WIDTH + m][yshift*MIN_LENGTH + n];
          end
      end

endmodule