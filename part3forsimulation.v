module alu(s,in1, in2, in3, in4,in5, in6, in7,in8, out);
	input [12:0]in1, in2, in3, in4, in5, in6, in7, in8;
	input [2:0]s;
	output reg [12:0]out;
	always@(*)
		case(s[2:0])
			3'b000: out=in1;
			3'b001: out=in2;
			3'b010: out=in3;
			3'b011: out=in4;
			3'b100: out=in5;
			3'b101: out=in6;
			3'b110: out=in7;
			3'b111: out=in8;
			default: out=13'd0;
		endcase
endmodule

module rate_divide (clock,in,out);
	input clock;
	input [1:0]in;
	output reg [1:0]out=2'b01;
	always@(posedge clock)
		begin
			if(out[1:0]==2'b00)
				out<=in;
			else 
				out<=out-1;
		end
endmodule

module norGate(in,out);
	input [1:0]in;
	output out;
	assign out = (in==2'b00) ? 1:0;
endmodule

module pause(clock, in, out);
	input clock;
	input [1:0]in;
	output out;
	wire [1:0]dividerout;
	rate_divide r1 (clock, in, dividerout);
	norGate n1 (dividerout, out);
endmodule
	
module combination(enable, i, clock, loadn, resetn, out);
	input enable;
	input clock;
	input resetn;
	input [12:0]i;
	input loadn;
	output out;
	reg [12:0]in;
	always@(negedge resetn, posedge enable)
		begin
			if(resetn==0)
				in<=0;
			else if(loadn==0)
				in[12:0]<=i[12:0];
			else if(enable==1)
				begin
					in[12]<=in[11];
					in[11]<=in[10];
					in[10]<=in[9];
					in[9]<=in[8];
					in[8]<=in[7];
					in[7]<=in[6];
					in[6]<=in[5];
					in[5]<=in[4];
					in[4]<=in[3];
					in[3]<=in[2];
					in[2]<=in[1];
					in[1]<=in[0];
					in[0]<=1'b0;
				end
		end
		assign out=in[12];
endmodule

module top(SW, LEDR, KEY, CLOCK_50);
	input CLOCK_50;
	input [9:0]SW;
	input [3:0]KEY;
	output [9:0]LEDR;
	wire [12:0]aluout;
	wire [12:0]in1, in2, in3, in4, in5, in6, in7, in8;
	assign in1[12:0]=13'b1010000000000;
	assign in2[12:0]=13'b1011101110111;
	assign in3[12:0]=13'b1110101110000;
	assign in4[12:0]=13'b1011101010000;
	assign in5[12:0]=13'b1110111000000;
	assign in6[12:0]=13'b1110100000000;
	assign in7[12:0]=13'b1110111011100;
	assign in8[12:0]=13'b1011101110100;
	wire enable;
	wire [1:0]in;
	assign in=2'b01;
	alu a1 (SW[2:0],in1, in2, in3, in4, in5, in6, in7,in8, aluout);
	pause p1 (CLOCK_50, in, enable);
	combination m1 (enable, aluout, CLOCK_50, KEY[1], KEY[0], LEDR[0]);
endmodule
	
	
	
	