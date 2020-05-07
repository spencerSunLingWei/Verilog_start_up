module method(select, in, out);
	input	[2:0]select;
	input [5:0]in;
	output reg out;
	
	always@(select,in)
	begin
		case(select[2:0])
			3'b000: out=in[0];
			3'b001: out=in[1];
			3'b010: out=in[2];
			3'b011: out=in[3];
			3'b100: out=in[4];
			3'b101: out=in[5];
			default: out=1'b0;
		endcase
	end
endmodule

module top(SW,LEDR);
	input [9:0]SW;
	output [9:0]LEDR;
	method u1 (SW[9:7],SW[5:0],LEDR[0]);
endmodule

			
		
	