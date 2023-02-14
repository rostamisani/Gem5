module frequency_divider (
  input  clk_in,
  output clk_out
);
  parameter N = 4;

  reg counter = 0;

  always @(posedge clk_in) begin
    counter <= counter + 1;
    if (counter == N-1) begin
      counter <= 0;
      clk_out <= ~clk_out;
    end
  end
endmodule
