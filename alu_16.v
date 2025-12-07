module alu_16(result,cout,a,b,s);
  input [15:0] a,b,s;
  output reg [15:0] result;
  output cout;
  wire [15:0] B_invert;
  wire cin;
  assign B_invert= S ? ~B:B;
  assign cin= s;
  assign {cout,result}= a + B_invert + cin;
endmodule
  
