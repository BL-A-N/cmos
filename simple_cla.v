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

module cla(
    input [3:0] A, B,
    input Cin,
    output [3:0] S,
    output Cout
);

    wire [3:0] P;
    wire [3:0] G;
    wire [3:0] Ci;

    assign P = A ^ B;
    assign G = A & B;

    assign Ci[0] = Cin;

    assign Ci[1] = G[0] | (P[0] & Ci[0]);
    assign Ci[2] = G[1] | (P[1] & Ci[1]);
    assign Ci[3] = G[2] | (P[2] & Ci[2]);

    assign Cout = G[3] | (P[3] & Ci[3]);

    assign S = P ^ Ci;
endmodule
