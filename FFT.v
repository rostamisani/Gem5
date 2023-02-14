module fft(
  input clk,
  input rst,
  input [15:0] real,
  input [15:0] imag,
  output reg [15:0] real_out,
  output reg [15:0] imag_out
);
  
  // Declare internal variables for intermediate calculation
  reg [15:0] real_temp, imag_temp;
  reg [3:0] stage, i;
  reg [2:0] j;
  reg [1:0] k;
  
  // State machine to implement FFT stages
  always @(posedge clk) begin
    if (rst) begin
      real_out <= 0;
      imag_out <= 0;
    end else begin
      case (stage)
        4'b0000: begin
          real_out <= real;
          imag_out <= imag;
        end
        4'b0001: begin
          // Perform first stage of butterfly calculation
          real_temp <= real + (1<<(15-i)) * real;
          imag_temp <= imag + (1<<(15-i)) * imag;
        end
        4'b0010: begin
          // Perform second stage of butterfly calculation
          real_out <= real_temp + (1<<(15-j)) * real_temp;
          imag_out <= imag_temp + (1<<(15-j)) * imag_temp;
        end
        4'b0011: begin
          // Perform third stage of butterfly calculation
          real_out <= real_temp + (1<<(15-k)) * real_temp;
          imag_out <= imag_temp + (1<<(15-k)) * imag_temp;
        end
        default: begin
          // Do nothing
        end
      endcase
    end
  end
  
  // Sequential logic to increment the stages
  always @(posedge clk) begin
    if (rst) begin
      stage <= 4'b0000;
      i <= 0;
      j <= 0;
      k <= 0;
    end else begin
      case (stage)
        4'b0000: begin
          stage <= 4'b0001;
        end
        4'b0001: begin
          i <= i + 1;
          if (i == 4) begin
            stage <= 4'b0010;
          end
        end
        4'b0010: begin
          j <= j + 1;
          if (j == 3) begin
            stage <= 4'b0011;
          end
        end
        4'b0011: begin
          k <= k + 1;
          if (k == 2) begin
            stage <= 4'b0100;
          end
        end
        default: begin
          // Do nothing
        end
      endcase
    end
  end
endmodule
