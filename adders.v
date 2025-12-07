module fa(sum,cout,a,b,cin);
  input a,b,cin;
  output sum,cout;
  assign sum=a^b^cin;
  assign cout=(a&b)|(b&cin)|(cin&a);
endmodule 

module fa4(sum,cout,a,b,cin);
  output reg [3:0] sum;
  output cout;
  input [3:0] a,b;
  input cin;
  wire s1,s2,s3;
  fa fa1(sum[0],s1,a[0],b[0],cin);
  fa fa2(sum[1],s2,a[1],b[1],s1);
  fa fa3(sum[2],s3,a[2],b[2],s2);
  fa fa4(sum[3],cout,a[3],b[3],s3);
endmodule 

module fa8(sum,cout,a,b,cin);
  output reg [7:0] sum;
  output cout;
  input [7:0] a,b;
  input cin;
  wire w;
  fa4 f1(sum [3:0], w, a[3:0], b[3:0], cin);
  fa4 f2(sum [7:4], cout, a[7:4], b[7:4],w);
endmodule 

module add32(clk,a,b,sum);
  input clk;
  input [31:0] a,b;
  output reg [31:0] sum;
  always @(posedge clk) begin 
    sum = a + b;
  end 
endmodule 
