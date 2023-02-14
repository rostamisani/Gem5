module fifo_buffer #(
  parameter depth = 8,
  parameter data_width = 8
) (
  input        clk,
  input        reset,
  input        write_enable,
  input [data_width-1:0] write_data,
  output       write_full,
  input        read_enable,
  output [data_width-1:0] read_data,
  output       read_empty
);

  reg [data_width-1:0] memory [0:depth-1];
  reg [3:0] write_pointer, read_pointer;
  reg [data_width-1:0] read_temp;

  always @(posedge clk) begin
    if (reset) begin
      write_pointer <= 0;
      read_pointer <= 0;
    end else begin
      if (write_enable && !write_full) begin
        memory[write_pointer] <= write_data;
        write_pointer <= write_pointer + 1;
        if (write_pointer == depth) begin
          write_pointer <= 0;
        end
      end
      if (read_enable && !read_empty) begin
        read_temp <= memory[read_pointer];
        read_pointer <= read_pointer + 1;
        if (read_pointer == depth) begin
          read_pointer <= 0;
        end
      end
    end
  end

  assign write_full = (write_pointer + 1 == read_pointer) || (write_pointer == depth-1 && read_pointer == 0);
  assign read_empty = (read_pointer == write_pointer);
  assign read_data = read_temp;

endmodule
