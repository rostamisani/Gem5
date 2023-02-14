module timer(
  input clk,
  input rst,
  output reg timeout
);

parameter COUNT_MAX = 1023;
reg [10:0] count;

always @(posedge clk) begin
  if(rst) begin
    count <= 0;
    timeout <= 0;
  end else begin
    if(count == COUNT_MAX) begin
      count <= 0;
      timeout <= 1;
    end else begin
      count <= count + 1;
      timeout <= 0;
    end
  end
end

endmodule
