module Tflipflop (clock, Resetn, T,out );
	input clock, Resetn, T;
	output reg out;
	always@(negedge Resetn, posedge clock)
		if (Resetn==0)
			out<=0;
		else if (T==1)
			out<=~out;
endmodule

module counter(enable, clock, clearn, out);
	input enable, clock, clearn;
	output [7:0]out;
	wire in1, in2, in3, in4, in5, in6,in7;
	Tflipflop t1 (clock, clearn, enable, out[0]);
	assign in1=enable&out[0];
	Tflipflop t2 (clock, clearn, in1, out[1]);
	assign in2=in1&out[1];
	Tflipflop t3 (clock, clearn, in2, out[2]);
	assign in3=in2&out[2];
	Tflipflop t4 (clock, clearn, in3, out[3]);
	assign in4=in3&out[3];
	Tflipflop t5 (clock, clearn, in4, out[4]);
	assign in5=in4&out[4];
	Tflipflop t6 (clock, clearn, in5, out[5]);
	assign in6=in5&out[5];
	Tflipflop t7 (clock, clearn, in6, out[6]);
	assign in7=in6&out[6];
	Tflipflop t8 (clock, clearn, in7, out[7]);
endmodule

module seg7(input [3:0]SW,output [6:0]HEX);
 assign HEX[0]= (~SW[3]&~SW[2]&~SW[1]&SW[0])+(~SW[3]&SW[2]&~SW[1]&~SW[0])+(SW[3]&~SW[2]&SW[1]&SW[0])+(SW[3]&SW[2]&~SW[1]&SW[0]);
 assign HEX[1]=(~SW[3]&SW[2]&~SW[1]&SW[0])+(~SW[3]&SW[2]&SW[1]&~SW[0])+(SW[3]&~SW[2]&SW[1]&SW[0])+(SW[3]&SW[2]&~SW[1]&~SW[0])+(SW[3]&SW[2]&SW[1]&~SW[0])+(SW[3]&SW[2]&SW[1]&SW[0]);
 assign HEX[2]=(~SW[3]&~SW[2]&SW[1]&~SW[0])+(SW[3]&SW[2]&~SW[1]&~SW[0])+(SW[3]&SW[2]&SW[1]&~SW[0])+(SW[3]&SW[2]&SW[1]&SW[0]);
 assign HEX[3]=(~SW[3]&~SW[2]&~SW[1]&SW[0])+(~SW[3]&SW[2]&~SW[1]&~SW[0])+(~SW[3]&SW[2]&SW[1]&SW[0])+(SW[3]&~SW[2]&SW[1]&~SW[0])+(SW[3]&SW[2]&SW[1]&SW[0]);
 assign HEX[4]=(~SW[3]&~SW[2]&~SW[1]&SW[0])+(~SW[3]&~SW[2]&SW[1]&SW[0])+(~SW[3]&SW[2]&~SW[1]&~SW[0])+(~SW[3]&SW[2]&~SW[1]&SW[0])+(~SW[3]&SW[2]&SW[1]&SW[0])+(SW[3]&~SW[2]&~SW[1]&SW[0]);
 assign HEX[5]=(~SW[3]&~SW[2]&~SW[1]&SW[0])+(~SW[3]&~SW[2]&SW[1]&~SW[0])+(~SW[3]&~SW[2]&SW[1]&SW[0])+(~SW[3]&SW[2]&SW[1]&SW[0])+(SW[3]&SW[2]&~SW[1]&SW[0]);
 assign HEX[6]=(~SW[3]&~SW[2]&~SW[1]&SW[0])+(~SW[3]&SW[2]&SW[1]&SW[0])+(SW[3]&SW[2]&~SW[1]&~SW[0])+(~SW[3]&~SW[2]&~SW[1]&~SW[0]);
endmodule

module top(KEY, SW, HEX0, HEX1);
	input [3:0]KEY;
	input [9:0]SW;
	output [6:0]HEX0,HEX1;
	wire [7:0]out;
	counter c1 (SW[1],KEY[0],SW[0],out);
	seg7 s1 (out[3:0],HEX0);
	seg7 s2 (out[7:4],HEX1);
endmodule

	
	
	
	
	
	
	