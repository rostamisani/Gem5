module image_processing (
  input clk,
  input [7:0] data_in,
  output reg [7:0] data_out
);

reg [7:0] pixel;

always @(posedge clk) begin
  pixel <= data_in;
  // Perform image processing operations here
  // For example, grayscale conversion
  data_out <= (pixel[7:5] + pixel[4:2] + pixel[1:0]) / 3;
end

endmodule
