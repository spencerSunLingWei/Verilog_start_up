`timescale 1ns / 1ns

module FA(a,b,cin, s, cout);
	input a,b,cin;
	output s, cout;
	assign s=cin^b^a;
	assign cout=(b&a)| (cin&b) |(cin&a);
endmodule
///
//module method(A,B, cin, S, Cout);
//	input[3:0]A,B;
//	input cin;
//	output [3:0]S;
//	output Cout;
//	wire c1,c2,c3;
//	FA u1 (A[0],B[0],cin,S[0],c1);
//	FA u2 (A[1],B[1],c1,S[1],c2);
//	FA u3 (A[2],B[2],c2,S[2],c3);
//	FA u4 (A[3],B[3],c3,S[3],Cout);
//endmodule

//module top(SW,LEDR);
//	input [9:0]SW;
//	output [9:0]LEDR;
//	method f1 (SW[7:4], SW[3:0], SW[8], LEDR[3:0],LEDR[9]);
//endmodule
///

module top(SW, LEDR);
	input [9:0]SW;
	output [9:0]LEDR;
	wire c1,c2,c3;
		FA u1 (SW[4],SW[0],SW[8],LEDR[0],c1);
		FA u2 (SW[5],SW[1],c1,LEDR[1],c2);
		FA u3 (SW[6],SW[2],c2,LEDR[2],c3);
		FA u4 (SW[7],SW[3],c3,LEDR[3],LEDR[9]);
endmodule
