module matrix_block_mul #(
    parameter WIDTH   = 8,
    parameter LENGTH  = 8,
    parameter DIG_MAX = 32
) (
    input  logic                  clk_i,
    input  logic                  srst_i,
    input  logic                  start_i,
    input  logic [DIG_MAX-1:0]    a_matrix[WIDTH-1:0][LENGTH-1:0],
    input  logic [DIG_MAX-1:0]    b_matrix[WIDTH-1:0][LENGTH-1:0],
    output logic [DIG_MAX-1:0]    c_matrix[WIDTH-1:0][LENGTH-1:0]
);

  logic [$clog2(WIDTH):0] current_c_row;
  logic [DIG_MAX-1:0]     one_cycle_c_row[LENGTH-1:0];
  logic                   done_row;

  typedef enum logic [1:0] {IDLE, COMPUTE, UPDATE} state_t;
  state_t state, next_state;

  always_ff @(posedge clk_i) begin
    if (srst_i) begin
      state <= IDLE;
      current_c_row <= 0;
      c_matrix <= '{default:0};
    end else begin
      state <= next_state;
      if (state == UPDATE) begin
        c_matrix[current_c_row] <= one_cycle_c_row;
        current_c_row <= current_c_row + 1;
      end
    end
  end

  always_comb begin
    next_state = state;
    done_row = 0;
    case (state)
      IDLE: begin
        if (start_i) begin
          next_state = COMPUTE;
        end
      end
      COMPUTE: begin
        next_state = UPDATE;
      end
      UPDATE: begin
        if (current_c_row < WIDTH - 1) begin
          next_state = COMPUTE;
        end else begin
          next_state = IDLE;
          done_row = 1;
        end
      end
    endcase
  end

  always_comb begin
    one_cycle_c_row = '{default:0};
    for (int j = 0; j < LENGTH; j++) begin
      for (int k = 0; k < LENGTH; k++) begin
        one_cycle_c_row[j] += a_matrix[current_c_row][k] * b_matrix[k][j];
      end
    end
  end

endmodule