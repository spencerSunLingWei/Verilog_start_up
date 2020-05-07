module top
	(
		CLOCK_50,						//	On Board 50 MHz
		// Your inputs and outputs here
		SW,
		KEY,							// On Board Keys
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   						//	VGA Blue[9:0]
	);

	input			CLOCK_50;				//	50 MHz
	input	[3:0]	KEY;					
	// Declare your inputs and outputs here
	input [9:0] SW;
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[7:0]	VGA_R;   				//	VGA Red[7:0] Changed from 10 to 8-bit DAC
	output	[7:0]	VGA_G;	 				//	VGA Green[7:0]
	output	[7:0]	VGA_B;   				//	VGA Blue[7:0]
	
	wire resetn;
	assign resetn = KEY[0];
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.

	wire [2:0] colour;
	wire [7:0] x;
	wire [6:0] y;
	wire writeEn;
	
	mymodule (CLOCK_50, SW[9:7], KEY[0], colour, x, y, writeEn);
	 
	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(writeEn),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
			
	// Put your code here. Your code should produce signals x,y,colour and writeEn
	// for the VGA controller, in addition to any other functionality your design may require.
endmodule





module mymodule (clk, colour_in, resetn, colour, x, y, writeEn);
	input clk;
	input [2:0]colour_in;
	input resetn;
	output [2:0]colour;
	output [7:0]x;
	output [6:0]y;
	output writeEn;
	
	wire done_draw, done_divide, go_draw, go_divide, go_count, go_clear;
	
	control c1 (clk, resetn, done_draw, done_divide, go_draw, go_divide, go_count, go_clear);
	datapath d1 (clk, resetn, colour_in, colour, go_draw, go_divide, go_count, go_clear, done_draw, done_divide, x, y);
	
	assign writeEn = go_draw;

endmodule










module control (clk, resetn, done_draw, done_divide, go_draw, go_divide, go_count, go_clear);
	input clk;
	input	resetn;
	input done_draw;
	input	done_divide;
	output reg go_draw;
	output reg go_divide;
	output reg go_count;
	output reg go_clear;

	//declare four states
	localparam reset_state= 4'b0000, draw_state = 4'b0001, wait_state = 4'b0010, erase_state = 4'b0011, update_state = 4'b0100;

	reg [3:0] current_state = reset_state, next_state;
	
	//state transition
	always@(*)
		begin: state_table
			case (current_state)
				reset_state:   next_state = draw_state;
				draw_state:		next_state = done_draw ? wait_state : draw_state;
				wait_state:		next_state = done_divide ? erase_state : wait_state;
				erase_state:	next_state = done_draw ? update_state : erase_state;
				update_state:	next_state = draw_state;
			endcase
		end 

	//signal changes in each state
	always @(*) 
		begin: enable_signals
			go_draw=0;
			go_divide=0;
			go_count=0;
			go_clear=0;
			case (current_state)
				reset_state: 
					begin
						go_draw=0;
						go_divide=0;
						go_count=0;
						go_clear=0;
					end	
				draw_state:	
					begin
						go_draw=1;
						go_divide=0;
						go_count=0;
						go_clear=0;
					end	
				wait_state:	
					begin
						go_draw=0;
						go_divide=1;
						go_count=0;
						go_clear=0;
					end		
				erase_state:
					begin
						go_draw=1;
						go_divide=0;
						go_count=0;
						go_clear=1;
					end		
				update_state:	
					begin
						go_draw=0;
						go_divide=0;
						go_count=1;
						go_clear=0;
					end	
			endcase
		end
	
	//the actual state changes according to the clock edge
	always @(posedge clk)
    begin: state_FFs
         if(resetn == 0)
					current_state <=  reset_state;
			else
					current_state <= next_state;
    end 
endmodule






module datapath (clk_50, resetn, colour_in, colour_out, go_draw, go_divide, go_count, go_clear, done_draw, done_divide, x_position, y_position);
	input clk_50;
	input resetn;
	input go_draw;
	input go_divide;
	input go_count;
	input go_clear;
	input [2:0]colour_in;
	output [2:0]colour_out;
	output done_draw;
	output done_divide;
	output reg [7:0]x_position;
	output reg [6:0]y_position;
	
	
		
	//divider
	reg [27:0]out=1;
	always@(posedge clk_50)
		begin
			if(!resetn)
				out<=1;
			else if (go_divide)
				begin
					if(out[27:0]==28'd0)
						out<=1;
					else 
						out<=out-1;
				end
		end
	assign done_divide = (out==28'd0) ? 1:0;

	//x_counter	
	localparam x_min=0, x_max=156;
	reg [7:0]x=0;
	reg x_count_up=1;
	reg x_count_down=0;
	always@(posedge clk_50)
		begin
			if (!resetn)
				x=0;
			else
				begin
					if (go_count)
						begin
							if (x_count_up && x<x_max)
								x=x+1;
							if (x==x_max && !x_count_down)
								begin 
									x_count_up=0; 
									x_count_down=1;
									x=x+1;
								end
							if (x>x_min && x_count_down)
								x=x-1;
							if (x==x_min)
								begin
									x_count_down=0;
									x_count_up=1;
								end
						end
				end	
		end

	
	//y_counter
	localparam y_min=0, y_max=116;
	reg [6:0]y=0;
	reg y_count_up=1;
	reg y_count_down=0;
	always@(posedge clk_50)
		begin
			if (!resetn)
				y=0;
			else
				begin
				if (go_count)
					begin
						if (y_count_up && y<y_max)
							y=y+1;
						if (y==y_max && !y_count_down)
							begin 
								y_count_up=0; 
								y_count_down=1;
								y=y+1;
							end
						if (y>y_min && y_count_down)
							y=y-1;
						if (y==y_min)
							begin
								y_count_down=0;
								y_count_up=1;
							end
					end
				end	
		end	
		
	reg [4:0]temp;
	always@(posedge clk_50)
	begin
		if(!go_draw)
			begin
				temp<=16;
				x_position <= x;
				y_position <= y;
			end
		else if (go_draw && !done_draw)
			begin
				if(temp!=0) temp <= temp-1;
				x_position <= x + (temp-1)%4;
				y_position <= y + (temp-1)/4;	
			end

	end
	assign done_draw=(temp==0);
	assign colour_out = (go_clear || temp==16) ? 3'b000 : colour_in;
	
endmodule


		