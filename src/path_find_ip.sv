module path_find_ip #(
  parameter MAP_WIDTH  = 1024,
  parameter MAP_LENGTH = 1024
) (
  input  clk_i,
  input  srst_i,
);

  (* ram_style = "block" *) \
  logic [MAP_WIDTH - 1:0][MAP_LENGTH - 1:0] map;


endmodule