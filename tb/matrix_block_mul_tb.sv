module matrix_block_mul_tb;

  // Parameters
  localparam WIDTH   = 2;
  localparam LENGTH  = 2;
  localparam DIG_MAX = 32;
  localparam CLK_PERIOD = 10; // Clock period in ns

  // Testbench signals
  bit                    clk;
  logic                  srst_i;
  logic                  start_i;
  logic [DIG_MAX-1:0]    a_matrix[WIDTH-1:0][LENGTH-1:0];
  logic [DIG_MAX-1:0]    b_matrix[WIDTH-1:0][LENGTH-1:0];
  logic [DIG_MAX-1:0]    c_matrix[WIDTH-1:0][LENGTH-1:0];
  logic [$clog2(WIDTH) - 1:0] done;

  // Expected result for verification
  logic [DIG_MAX-1:0]    expected_c_matrix[WIDTH-1:0][LENGTH-1:0];

  default clocking cb @( posedge clk );
  endclocking

  // Instantiate the DUT (Device Under Test)
  matrix_block_mul #(
    .WIDTH   ( WIDTH     ),
    .LENGTH  ( LENGTH    ),
    .DIG_MAX ( DIG_MAX   )
  ) DUT (
    .clk_i    ( clk      ),
    .srst_i   ( srst_i   ),
    .start_i  ( start_i  ),
    .a_matrix ( a_matrix ),
    .b_matrix ( b_matrix ),
    .c_matrix ( c_matrix ),
    .done_o   ( done     )
  );

  // Clock generation
  initial begin
    clk = 1'b0;
    forever #(CLK_PERIOD/2) clk = !clk;
  end

  // Test procedure
  initial begin
    // Initialize signals
    srst_i = 1'b0;
    start_i = 1'b0;
    a_matrix = '{default: '0};
    b_matrix = '{default: '0};
    expected_c_matrix = '{default: '0};

    // Reset the module
    srst_i = 1'b1;
    #(CLK_PERIOD * 2);
    srst_i = 1'b0;
    #(CLK_PERIOD);

    // Test Case 1: 2x2 matrices for simplicity (subset of 8x8)
    // Initialize a_matrix and b_matrix
    for (int i = 0; i < 2; i++) begin
      for (int j = 0; j < 2; j++) begin
        a_matrix[i][j] = i + j + 1; // Example: [[1, 2], [2, 3]]
        b_matrix[i][j] = i + j + 2; // Example: [[2, 3], [3, 4]]
      end
    end

    // Calculate expected result for 2x2 matrix multiplication
    // Expected: [[8, 11], [13, 18]]
    expected_c_matrix[0][0] = a_matrix[0][0] * b_matrix[0][0] + a_matrix[0][1] * b_matrix[1][0]; // 1*2 + 2*3 = 8
    expected_c_matrix[0][1] = a_matrix[0][0] * b_matrix[0][1] + a_matrix[0][1] * b_matrix[1][1]; // 1*3 + 2*4 = 11
    expected_c_matrix[1][0] = a_matrix[1][0] * b_matrix[0][0] + a_matrix[1][1] * b_matrix[1][0]; // 2*2 + 3*3 = 13
    expected_c_matrix[1][1] = a_matrix[1][0] * b_matrix[0][1] + a_matrix[1][1] * b_matrix[1][1]; // 2*3 + 3*4 = 18

    // Start the multiplication
    start_i = 1;
    #(CLK_PERIOD);
    start_i = 0;

    // Wait for the computation to complete (WIDTH cycles)
    wait ( done === 1'b1 );

    // Check results
    $display("Test Case 1: 2x2 Matrix Multiplication");
    for (int i = 0; i < 2; i++) begin
      for (int j = 0; j < 2; j++) begin
        if (c_matrix[i][j] === expected_c_matrix[i][j]) begin
          $display("PASS: c_matrix[%0d][%0d] = %0d (Expected: %0d)", i, j, c_matrix[i][j], expected_c_matrix[i][j]);
        end else begin
          $display("FAIL: c_matrix[%0d][%0d] = %0d (Expected: %0d)", i, j, c_matrix[i][j], expected_c_matrix[i][j]);
        end
      end
    end

    // Test Case 2: Identity matrix multiplication
    // Reset matrices
    a_matrix = '{default:0};
    b_matrix = '{default:0};
    expected_c_matrix = '{default:0};

    // Set a_matrix as identity matrix, b_matrix as test values
    for (int i = 0; i < WIDTH; i++) begin
      a_matrix[i][i] = 1; // Identity matrix
      for (int j = 0; j < LENGTH; j++) begin
        b_matrix[i][j] = i + j + 1;
      end
    end

    // Expected: c_matrix = b_matrix (since A is identity)
    for (int i = 0; i < WIDTH; i++) begin
      for (int j = 0; j < LENGTH; j++) begin
        expected_c_matrix[i][j] = b_matrix[i][j];
      end
    end

    // Reset and start
    srst_i = 1;
    #(CLK_PERIOD);
    srst_i = 0;
    #(CLK_PERIOD);
    start_i = 1;
    #(CLK_PERIOD);
    start_i = 0;

    // Wait for completion
    wait ( done === 1'b1 );

    // Check results
    $display("\nTest Case 2: Identity Matrix Multiplication");
    for (int i = 0; i < WIDTH; i++) begin
      for (int j = 0; j < LENGTH; j++) begin
        if (c_matrix[i][j] === expected_c_matrix[i][j]) begin
          $display("PASS: c_matrix[%0d][%0d] = %0d (Expected: %0d)", i, j, c_matrix[i][j], expected_c_matrix[i][j]);
        end else begin
          $display("FAIL: c_matrix[%0d][%0d] = %0d (Expected: %0d)", i, j, c_matrix[i][j], expected_c_matrix[i][j]);
        end
      end
    end

    // End simulation
    #(CLK_PERIOD * 2);
    $stop();
  end

endmodule