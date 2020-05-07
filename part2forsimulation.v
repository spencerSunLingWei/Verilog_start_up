module seg7(input [3:0]SW,output [6:0]HEX);
 assign HEX[0]= (~SW[3]&~SW[2]&~SW[1]&SW[0])+(~SW[3]&SW[2]&~SW[1]&~SW[0])+(SW[3]&~SW[2]&SW[1]&SW[0])+(SW[3]&SW[2]&~SW[1]&SW[0]);
 assign HEX[1]=(~SW[3]&SW[2]&~SW[1]&SW[0])+(~SW[3]&SW[2]&SW[1]&~SW[0])+(SW[3]&~SW[2]&SW[1]&SW[0])+(SW[3]&SW[2]&~SW[1]&~SW[0])+(SW[3]&SW[2]&SW[1]&~SW[0])+(SW[3]&SW[2]&SW[1]&SW[0]);
 assign HEX[2]=(~SW[3]&~SW[2]&SW[1]&~SW[0])+(SW[3]&SW[2]&~SW[1]&~SW[0])+(SW[3]&SW[2]&SW[1]&~SW[0])+(SW[3]&SW[2]&SW[1]&SW[0]);
 assign HEX[3]=(~SW[3]&~SW[2]&~SW[1]&SW[0])+(~SW[3]&SW[2]&~SW[1]&~SW[0])+(~SW[3]&SW[2]&SW[1]&SW[0])+(SW[3]&~SW[2]&SW[1]&~SW[0])+(SW[3]&SW[2]&SW[1]&SW[0]);
 assign HEX[4]=(~SW[3]&~SW[2]&~SW[1]&SW[0])+(~SW[3]&~SW[2]&SW[1]&SW[0])+(~SW[3]&SW[2]&~SW[1]&~SW[0])+(~SW[3]&SW[2]&~SW[1]&SW[0])+(~SW[3]&SW[2]&SW[1]&SW[0])+(SW[3]&~SW[2]&~SW[1]&SW[0]);
 assign HEX[5]=(~SW[3]&~SW[2]&~SW[1]&SW[0])+(~SW[3]&~SW[2]&SW[1]&~SW[0])+(~SW[3]&~SW[2]&SW[1]&SW[0])+(~SW[3]&SW[2]&SW[1]&SW[0])+(SW[3]&SW[2]&~SW[1]&SW[0]);
 assign HEX[6]=(~SW[3]&~SW[2]&~SW[1]&SW[0])+(~SW[3]&SW[2]&SW[1]&SW[0])+(SW[3]&SW[2]&~SW[1]&~SW[0])+(~SW[3]&~SW[2]&~SW[1]&~SW[0]);
endmodule

module counter4(clock, enable, q);
	input clock, enable;
	output reg [3:0]q=0;
	always@(posedge clock)
		begin
			if(q==4'b1111 && enable==1)
				q<=4'b0000;
			if(enable==1)
				q<=q+1;
		end
endmodule

module alu(s,in1, in2, in3, in4, out);
	input [2:0]in1, in2, in3, in4;
	input [1:0]s;
	output reg [2:0]out;
	always@(*)
		case(s[1:0])
			2'b00: out=in1;
			2'b01: out=in2;
			2'b10: out=in3;
			2'b11: out=in4;
			default: out=3'b000;
		endcase
endmodule

module rate_divide (clk,in,outf);
	input clk;
	input [2:0]in;
	output outf;
	assign outf =clk;
endmodule


module top(SW, CLOCK_50, HEX0);
	input CLOCK_50;
	input [9:0]SW;
	output [6:0]HEX0;
	
	wire [2:0]in1, in2, in3, in4;
	assign in1[2:0]=CLOCK_50;
	assign in2[2:0]=3'b010;
	assign in3[2:0]=3'b100;
	assign in4[2:0]=3'b111;
	wire [2:0]out;
	wire [2:0]aluout;
	wire dividerout;
	
	alu a1 (SW[1:0],in1, in2, in3, in4, aluout);
	rate_divide r1 (CLOCK_50,aluout,dividerout);
	counter4 c1 (CLOCK_50, dividerout, out);
	seg7 s1 (out, HEX0);
endmodule

