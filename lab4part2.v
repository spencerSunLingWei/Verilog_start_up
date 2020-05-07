
// code for the ripple carry adder
module FA(a, b, cin, s, cout);
	input a,b,cin;
	output s, cout;
	assign s=cin^b^a;
	assign cout=(b&a)| (cin&b) |(cin&a);
endmodule

module methodforripplecarryadder(A, B, Cin, S, Cout);
	input[3:0]A,B;
	input Cin;
	output [3:0]S;
	output Cout;
	wire C1,C2,C3;
	FA u1 (A[0],B[0],Cin,S[0],C1);
	FA u2 (A[1],B[1],C1,S[1],C2);
	FA u3 (A[2],B[2],C2,S[2],C3);
	FA u4 (A[3],B[3],C3,S[3],Cout);
endmodule


//code for the segment7
module segment(input[3:0]c, output[6:0]f);
	assign f[0]=(~c[3]&~c[2]&~c[1]&c[0]) | (~c[3]&c[2]&~c[1]&~c[0]) | (c[3]&~c[2]&c[1]&c[0]) | (c[3]&c[2]&~c[1]&c[0]);
	assign f[1]=(~c[3]&c[2]&~c[1]&c[0]) | (~c[3]&c[2]&c[1]&~c[0]) | (c[3]&~c[2]&c[1]&c[0]) | (c[3]&c[2]&~c[1]&~c[0]) | (c[3]&c[2]&c[1]&~c[0]) | (c[3]&c[2]&c[1]&c[0]);
	assign f[2]=(~c[3]&~c[2]&c[1]&~c[0]) | (c[3]&c[2]&~c[1]&~c[0]) | (c[3]&c[2]&c[1]&~c[0]) | (c[3]&c[2]&c[1]&c[0]);
	assign f[3]=(~c[3]&~c[2]&~c[1]&c[0]) | (~c[3]&c[2]&~c[1]&~c[0]) | (~c[3]&c[2]&c[1]&c[0]) | (c[3]&~c[2]&c[1]&~c[0]) | (c[3]&c[2]&c[1]&c[0]);
	assign f[4]=(~c[3]&~c[2]&~c[1]&c[0]) | (~c[3]&~c[2]&c[1]&c[0]) | (~c[3]&c[2]&~c[1]&~c[0]) | (~c[3]&c[2]&~c[1]&c[0]) | (~c[3]&c[2]&c[1]&c[0]) | (c[3]&~c[2]&~c[1]&c[0]);
	assign f[5]=(~c[3]&~c[2]&~c[1]&c[0]) | (~c[3]&~c[2]&c[1]&~c[0]) | (~c[3]&~c[2]&c[1]&c[0]) | (~c[3]&c[2]&c[1]&c[0]) | (c[3]&c[2]&~c[1]&c[0]);
	assign f[6]=(~c[3]&~c[2]&~c[1]&~c[0]) | (~c[3]&~c[2]&~c[1]&c[0]) | (~c[3]&c[2]&c[1]&c[0]) | (c[3]&c[2]&~c[1]&~c[0]);
endmodule	
	
module segmentmethod(input [3:0]SW, output [6:0]HEX0);
	segment u1 (.c(SW), .f(HEX0));
endmodule
	
	
//code for ALU selection
module alu(select,out, A, B,registerinput);
	input	[3:0]A,B;
	input [2:0]select;
	input [7:0]registerinput;
	output reg [7:0]out;
	
	wire [4:0]Aout;
	methodforripplecarryadder f1 (A, B, 0, Aout[3:0], Aout[4]);
	

	always@(*)
	begin
		case(select[2:0])
			3'b000: out={5'b00000, Aout[4:0]};
			3'b001: out= A+B;
			3'b010: out={(~A&~B),(A&~B)&(~A&B)};
			3'b011: if (A[0] | B[0] | A[1] | B[1] | A[2] | B[2] | A[3]| B[3]==1)
						out=8'b00001111;	
				
			3'b100: if ( ((A[0]+A[1]+A[2]+ A[3])==1) && ( (B[0]+ B[1]+ B[2]+ B[3])==2)) 
						out=8'b11110000;
						
			3'b101: out= {A,~B};
			3'b110: out = registerinput[7:0];
			default: out=8'b00000000;
		endcase
	end
endmodule

	



//code for synchronous reset
module register(invalue, reset_b, q, clock);
	input [7:0]invalue;
	input reset_b, clock; 
	output reg [7:0]q;

	always@(posedge clock)
	begin
		if(reset_b == 1'b0)
			q<=8'b00000000;
		else
			q<=invalue[7:0];
	end
endmodule


//top module
module top(SW,KEY,LEDR,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
	input [9:0]SW;
	input [3:0]KEY;
	output [9:0]LEDR;
	output [6:0]HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;
	
	//[3:0]SW is data input for alu
	//key0 is the clock input for register
	//sw9 is reset_b register
	//key1-3 is select input  register   SW[7:5]
	//ledr7-0 is the final output for q for resigter
	//hex0 value for data
	//hex123 is 0
	//hex4 least-sig-dig
	//hex5 most-sig-dig
	
	wire [7:0]w1,w2;
	alu a1 (KEY[3:1],w1, SW[3:0], w2[3:0],w2);
	register r1 (w1, SW[9], w2, KEY[0]);

	
	
	assign LEDR[7:0]=w2;

	segmentmethod s1 (8'b00000000, HEX2[6:0]);
	segmentmethod s2 (SW[3:0], HEX0[6:0]);
	segmentmethod s4 (LEDR[3:0], HEX4[6:0]);
	segmentmethod s5 (LEDR[7:4], HEX5[6:0]);
	segmentmethod s6 (8'b00000000, HEX1[6:0]);
	segmentmethod s7 (8'b00000000, HEX3[6:0]);
	
endmodule
