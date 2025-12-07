module shiftL(Dout,Din,clk,rst,SI,shift,ld);
  output reg [7:0] Dout;
  input [7:0] Din;
  input clk,rst,ld,SI,shift;
  always @(posedge clk) begin 
    if (rst)
      Dout <= 8'b0;
    else if (ld)
      Dout <= Din;
    else if (shift)
      Dout <= {Din[6:0],SI};
  end 
endmodule 

module asyn_shift(Dout,Din,clk,rst,SI,shift,ld);
  output reg [7:0] Dout;
  input [7:0] Din;
  input clk,rst,ld,SI,shift;
  always @(posedge clk or rst) begin 
    if (rst)
      Dout <= 8'b0;
    else if (ld)
      Dout <= Din;
    else if (shift)
      Dout <= {Din[6:0],SI};
  end 
endmodule 

module univ_shift(Dout,Din,clk,rst,SI,shift,ld);
  output reg [7:0] Dout;
  input [7:0] Din;
  input clk,rst,ld,SI,shift;
  always @(posedge clk) begin 
    if (rst)
      Dout <= 8'b0;
    else if (ld)
      Dout <= Din;
    else if (shift)
      Dout <= {Din[6:0],SI};
    else if (~shift)
      Dout <= {SI,Din[7:1]};
  end 
endmodule 
