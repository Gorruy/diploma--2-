module matrix_ip (
    parameter MAX_WIDTH  = 20,
    parameter MIN_WIDTH  = 4,
    parameter MAX_LENGTH = 20,
    parameter MIN_LENGTH = 4,
    parameter DWIDTH     = 64
) (
    input logic  clk_i,
    input logic  srst_i,
);

    logic [DIG_MAX - 1:0] a_matrix   [MAX_WIDTH - 1:0][MAX_LENGTH - 1:0];
    logic [DIG_MAX - 1:0] b_matrix   [MAX_WIDTH - 1:0][MAX_LENGTH - 1:0];
    logic [DIG_MAX - 1:0] res_matrix [MAX_WIDTH - 1:0][MAX_LENGTH - 1:0];

    typedef enum logic [2:0] {
        IDLE = 3'd0,
        LOAD_A = 3'd1,
        LOAD_B = 3'd2,
        COMPUTE = 3'd3,
        OUTPUT = 3'd4
    } state_t;
    state_t state, next_state;

    logic [7:0] row_a_count, col_a_count;
    logic [7:0] row_b_count, col_b_count;
    logic [7:0] row_c_count, col_c_count;
    logic [7:0] compute_i, compute_j, compute_k;

    logic [31:0] product;
    logic compute_done;
    logic load_a_done, load_b_done;

    assign s_axis_a_tready = (state == LOAD_A);
    assign s_axis_b_tready = (state == LOAD_B);
    assign m_axis_c_tvalid = (state == OUTPUT);

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            state <= IDLE;
        else
            state <= next_state;
    end

    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                if (s_axis_a_tvalid && s_axis_a_tready)
                    next_state = LOAD_A;
            end
            LOAD_A: begin
                if (load_a_done)
                    next_state = LOAD_B;
            end
            LOAD_B: begin
                if (load_b_done)
                    next_state = COMPUTE;
            end
            COMPUTE: begin
                if (compute_done)
                    next_state = OUTPUT;
            end
            OUTPUT: begin
                if (row_c_count == rows_a && col_c_count == cols_b - 1)
                    next_state = IDLE;
            end
        endcase
    end

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            row_a_count <= 8'd0;
            col_a_count <= 8'd0;
            load_a_done <= 1'b0;
        end else if (state == LOAD_A && s_axis_a_tvalid && s_axis_a_tready) begin
            matrix_a[row_a_count][col_a_count] <= s_axis_a_tdata;
            if (col_a_count == cols_a - 1) begin
                col_a_count <= 8'd0;
                if (row_a_count == rows_a - 1) begin
                    row_a_count <= 8'd0;
                    load_a_done <= 1'b1;
                end else begin
                    row_a_count <= row_a_count + 1;
                end
            end else begin
                col_a_count <= col_a_count + 1;
            end
        end
    end

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            row_b_count <= 8'd0;
            col_b_count <= 8'd0;
            load_b_done <= 1'b0;
        end else if (state == LOAD_B && s_axis_b_tvalid && s_axis_b_tready) begin
            matrix_b[row_b_count][col_b_count] <= s_axis_b_tdata;
            if (col_b_count == cols_b - 1) begin
                col_b_count <= 8'd0;
                if (row_b_count == cols_a - 1) begin
                    row_b_count <= 8'd0;
                    load_b_done <= 1'b1;
                end else begin
                    row_b_count <= row_b_count + 1;
                end
            end else begin
                col_b_count <= col_b_count + 1;
            end
        end
    end

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            compute_i <= 8'd0;
            compute_j <= 8'd0;
            compute_k <= 8'd0;
            compute_done <= 1'b0;
            for (int i = 0; i < 256; i++)
                for (int j = 0; j < 256; j++)
                    matrix_c[i][j] <= 32'd0;
        end else if (state == COMPUTE) begin
            matrix_c[compute_i][compute_j] <= matrix_c[compute_i][compute_j] +
                                             matrix_a[compute_i][compute_k] * matrix_b[compute_k][compute_j];
            if (compute_k == cols_a - 1) begin
                compute_k <= 8'd0;
                if (compute_j == cols_b - 1) begin
                    compute_j <= 8'd0;
                    if (compute_i == rows_a - 1) begin
                        compute_i <= 8'd0;
                        compute_done <= 1'b1;
                    end else begin
                        compute_i <= compute_i + 1;
                    end
                end else begin
                    compute_j <= compute_j + 1;
                end
            end else begin
                compute_k <= compute_k + 1;
            end
        end
    end

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            row_c_count <= 8'd0;
            col_c_count <= 8'd0;
            m_axis_c_tdata <= 32'd0;
        end else if (state == OUTPUT && m_axis_c_tready) begin
            m_axis_c_tdata <= matrix_c[row_c_count][col_c_count];
            if (col_c_count == cols_b - 1) begin
                col_c_count <= 8'd0;
                if (row_c_count == rows_a - 1) begin
                    row_c_count <= 8'd0;
                end else begin
                    row_c_count <= row_c_count + 1;
                end
            end else begin
                col_c_count <= col_c_count + 1;
            end
        end
    end
endmodule