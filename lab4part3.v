module mux2to1(x,y,s,f);
	input x,y,s;
	output f;
	assign f=(~s&x)|(s&y);
endmodule

module posedge_triggered(d, clock, q, reset_value);
	input d, clock, reset_value;
	output reg q;
	always@(posedge clock)
	begin
		if(reset_value==1)
			q<=1;
		else
			q<=d;
	end
endmodule

module subcircuit(right, left, rotate, data, loadn, clock, q, reset_value);
	input right, left, rotate, data, loadn, clock, reset_value;
	output q;
	wire w1,w2;
	mux2to1 m1 (right,left, rotate, w1);
	mux2to1 m2 (data, w1, loadn, w2);
	posedge_triggered p1 (w2, clock, q, reset_value);
endmodule


module connection (data, rotate, loadn, clock, reset_value, asright, q);
	input [7:0]data;
	input  rotate, loadn, clock, reset_value, asright;
	output [7:0]q;
	//wire temp;
	//assign temp=q[0];
	wire w3;
	
	subcircuit s0 (q[7], q[1], rotate, data[0], loadn, clock, q[0], reset_value);
	subcircuit s1 (q[0], q[2], rotate, data[1], loadn, clock, q[1], reset_value);
	subcircuit s2 (q[1], q[3], rotate, data[2], loadn, clock, q[2], reset_value);
	subcircuit s3 (q[2], q[4], rotate, data[3], loadn, clock, q[3], reset_value);
	subcircuit s4 (q[3], q[5], rotate, data[4], loadn, clock, q[4], reset_value);
	subcircuit s5 (q[4], q[6], rotate, data[5], loadn, clock, q[5], reset_value);
	subcircuit s6 (q[5], q[7], rotate, data[6], loadn, clock, q[6], reset_value);
	subcircuit s7 (q[6], w3, rotate, data[7], loadn, clock, q[7], reset_value);
	mux2to1 s8 (q[0], q[7], asright, w3);
endmodule

module top(SW,KEY,LEDR);
	input [9:0]SW;
	input [3:0]KEY;
	output [9:0]LEDR;
	
	connection C1 (SW[7:0], KEY[2], KEY[1], KEY[0], SW[9], KEY[3],LEDR[7:0]);
	
endmodule
	
	
	
	