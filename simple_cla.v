module CarryLookAheadAdder(
  input [3:0]A, B, 
  input Cin,
  output [3:0] S,
  output Cout
);
  wire [3:0] Ci; // Carry intermediate for intermediate computation
  
  assign Ci[0] = Cin;
  assign Ci[1] = (A[0] & B[0]) | ((A[0]^B[0]) & Ci[0]);
  //assign Ci[2] = (A[1] & B[1]) | ((A[1]^B[1]) & Ci[1]); expands to
  assign Ci[2] = (A[1] & B[1]) | ((A[1]^B[1]) & ((A[0] & B[0]) | ((A[0]^B[0]) & Ci[0])));
  //assign Ci[3] = (A[2] & B[2]) | ((A[2]^B[2]) & Ci[2]); expands to
  assign Ci[3] = (A[2] & B[2]) | ((A[2]^B[2]) & ((A[1] & B[1]) | ((A[1]^B[1]) & ((A[0] & B[0]) | ((A[0]^B[0]) & Ci[0])))));
  //assign Cout  = (A[3] & B[3]) | ((A[3]^B[3]) & Ci[3]); expands to
  assign Cout  = (A[3] & B[3]) | ((A[3]^B[3]) & ((A[2] & B[2]) | ((A[2]^B[2]) & ((A[1] & B[1]) | ((A[1]^B[1]) & ((A[0] & B[0]) | ((A[0]^B[0]) & Ci[0])))))));

  assign S = A^B^Ci;
endmodule

module cla_8bit(
    input clk,
    input [7:0] A, B,
    input Cin,
    output [7:0] S,
    output Cout
);

    wire [7:0] P;
    wire [7:0] G;
    wire [8:0] Ci;

    assign P = A ^ B;
    assign G = A & B;

    assign Ci[0] = Cin;

    assign Ci[1] = G[0] | (P[0] & Ci[0]);
    assign Ci[2] = G[1] | (P[1] & Ci[1]);
    assign Ci[3] = G[2] | (P[2] & Ci[2]);
    assign Ci[4] = G[3] | (P[3] & Ci[3]);
    assign Ci[5] = G[4] | (P[4] & Ci[4]);
    assign Ci[6] = G[5] | (P[5] & Ci[5]);
    assign Ci[7] = G[6] | (P[6] & Ci[6]);
    assign Ci[8] = G [7] | (p[7] & Ci[7]);

  always @(posedge clk) begin 
    S <= P ^ Ci[7:0];
    Cout <= Ci[8];
  end 
endmodule
