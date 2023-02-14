module pattern_detector (
  input clk,
  input rst,
  input [7:0] din,
  output reg match
);

reg [6:0] shift_reg;

always @(posedge clk) begin
  if (rst)
    shift_reg <= 7'b0000000;
  else
    shift_reg <= {din, shift_reg[6:1]};
end

always @(*) begin
  match = (shift_reg == 7'b1100001);
end

endmodule
