module state_machine (
  input clk,
  input reset,
  input start,
  input [1:0] state_in,
  output reg [1:0] state_out
);
  reg [1:0] next_state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state_out <= 2'b00;
    end else begin
      state_out <= next_state;
    end
  end

  always @* begin
    next_state = state_out;
    case (state_out)
      2'b00: if (start) next_state = 2'b01;
      2'b01: next_state = 2'b10;
      2'b10: next_state = 2'b11;
      2'b11: next_state = 2'b00;
    endcase
  end

endmodule
