module reg8(out,in,rst,clk);
  input clk,rst;
  output reg [7:0] out;
  input [7:0] in;
  always @(posedge clk) begin 
    if (rst)
      out = 8'b0;
    else 
      out = in;
  end 
endmodule 
