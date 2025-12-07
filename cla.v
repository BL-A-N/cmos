module GP(A,B,G,P);
input [3:0] A,B;
output [3:0] G,P;
assign P = A^B;
assign G = A&B;
endmodule

module Group_GP(G,P,group_g,group_p);
input [3:0] G,P;
output group_p,group_g;
assign group_p= P[0] & P[1] & P[2] & P[3];
assign group_g= G[3] | G[2] & P[3] | G[1] & P[3] & P[2] | G[0] & P[3] & P[2] & P[1];
endmodule

module PG_RCA(G,P,S,CIN);
input [3:0] G,P;
input CIN;
output [3:0] S;
assign S[0] = P[0] ^ CIN;
assign S[1] = P[1] ^  (G[0] | P[0] & CIN);
assign S[2] = P[2] ^ (G[1] | G[0] & P[1] | CIN & P[1] & P[0]);
assign S[3] = P[3] ^ (G[2] | G[1] & P[2] | P[2] & P[1] & G[0] | P[2] & P[1] & P[0] & CIN);
endmodule

module add8(A,B,CIN,OUT,COUT);
input CIN;
input [7:0] A,B;
output [7:0] OUT;
output COUT;

wire [7:0] G,P;
wire g4_1, g8_5;
wire p4_1, p8_5;

wire c4;

GP GP1(A[3:0], B[3:0], G[3:0], P[3:0]);
GP GP2(A[7:4], B[7:4], G[7:4], P[7:4]);

Group_GP Group_GP1 (G[3:0], P[3:0], g4_1, p4_1);
Group_GP Group_GP2 (G[7:4], P[7:4], g8_5, p8_5);

assign c4= g4_1 | p4_1 & CIN;
assign COUT = g8_5 | p8_5 & c4;

PG_RCA PG_RCA1(G[3:0], P[3:0], OUT [3:0], CIN);
PG_RCA PG_RCA2(G[7:4], P[7:4], OUT [7:4], c4);
endmodule
