module matrix_block_mul #(
    parameter WIDTH   = 8,
    parameter LENGTH  = 8,
    parameter DIG_MAX = 32
) (
    input  logic                   clk_i,
    input  logic                   srst_i,
    input  logic                   start_i,
    input  var logic [DIG_MAX-1:0] a_matrix [WIDTH-1:0][LENGTH-1:0],
    input  var logic [DIG_MAX-1:0] b_matrix [WIDTH-1:0][LENGTH-1:0],
    output var logic [DIG_MAX-1:0] c_matrix [WIDTH-1:0][LENGTH-1:0],
    output logic                   done_o
);

  localparam CCR_WIDTH = $clog2(WIDTH);

  logic [CCR_WIDTH - 1:0] current_c_row;
  logic [DIG_MAX - 1:0]   one_cycle_c_row[LENGTH-1:0];

  typedef enum logic [1:0] {IDLE, COMPUTE, DONE} state_t;
  state_t state, next_state;

  always_ff @(posedge clk_i) begin
    if (srst_i) 
      state <= IDLE;
    else
      state <= next_state;
  end

  always_comb 
    begin
      next_state = state;
      case (state)

        IDLE: begin
          if ( start_i ) 
            next_state = COMPUTE;
        end

        COMPUTE: begin
          if ( current_c_row == (CCR_WIDTH)'(WIDTH) )
            next_state = DONE;
        end

        DONE: begin
          next_state = IDLE;
        end

      endcase
    end

  always_ff @( posedge clk_i )
    begin
      if ( srst_i )
        current_c_row <= '0;
      else if ( state == COMPUTE ) 
        current_c_row <= current_c_row + 1;
    end

  always_ff @( posedge clk_i )
    begin
      if ( state == COMPUTE )
        c_matrix[current_c_row] <= one_cycle_c_row;
    end

  always_ff @( posedge clk_i )
    begin
      if ( state == IDLE )
        done_o <= 1'b0;
      else if ( state == DONE )
        done_o <= 1'b1;
    end

  always_comb begin
    one_cycle_c_row = '{default: '0};
    for (int i = 0; i < WIDTH; i++) 
      begin
        for (int j = 0; j < LENGTH; j++) 
          begin
            one_cycle_c_row[i] += a_matrix[current_c_row][j] * b_matrix[j][i];
          end
      end
  end

endmodule