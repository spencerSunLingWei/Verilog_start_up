// Part 2 skeleton

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
	
	mymodule m1 (CLOCK_50, SW[6:0], SW[9:7], KEY[0], KEY[1], KEY[2], KEY[3], colour[2:0], x, y, writeEn);
	 
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


module mymodule (clk, position, colour_in, KEY0, KEY1, KEY2, KEY3, colour, x, y, writeEn);
	input clk;
	input [6:0]position;
	input [2:0]colour_in;
	input KEY0;
	input KEY1;
	input KEY2;
	input KEY3;
	output [2:0]colour;
	output [7:0]x;
	output [6:0]y;
	output writeEn;
	
	wire ld_x, ld_y, go_plot, go_clear, done_plot;
	
	control c1 (clk, KEY2, KEY1, KEY0, KEY3, done_plot, ld_x, ld_y, go_plot, go_clear);
	datapath d1 (clk, position, colour_in, KEY0, ld_x, ld_y, go_plot, go_clear, x, y, colour, done_plot);
	
	assign writeEn = go_plot;

endmodule

module control (clk, blackn, plot, resetn, load, done_plot, ld_x, ld_y, go_plot, go_clear);
	//user input signal
	input clk;
	input blackn;
	input plot;
	input resetn;
	input load;
	//handshake input signal from datapath
	input done_plot;
	//signal output by contral module
	output reg ld_x;
	output reg ld_y;
	output reg go_plot;
	output reg go_clear;
	
	//declare four states
	localparam s_load_x = 4'b0000, s_load_x_wait = 4'b0001, s_load_y = 4'b0010, s_plot = 4'b0011;
	
	reg [3:0] current_state = s_load_x, next_state;
	
	//state transition
	always@(*)
		begin: state_table
			case (current_state)
           s_load_x:        next_state = load ? s_load_x : s_load_x_wait;
			  s_load_x_wait :  next_state = load ? s_load_y : s_load_x_wait ;
			  s_load_y:        next_state = plot ? s_load_y : s_plot;
			  s_plot:          next_state = done_plot ? s_load_x : s_plot;
			endcase
		end 

	//signal changes in each state
	always @(*) 
		begin: enable_signals
			ld_x = 0;
			ld_y = 0;
			go_plot = 0;
			case (current_state)
				s_load_x:  ld_x = 1;
				s_load_y:  ld_y = 1;
				s_plot:    go_plot = 1;
			endcase
		end
	
	//the actual state changes according to the clock edge
	always @(posedge clk)
    begin: state_FFs
         if(resetn == 0)
            current_state <=  s_load_x;
		   else if (blackn == 0) 
			 	begin
					current_state <=  s_plot;
					go_clear = 1;
				end
			else 
				begin
					if (ld_x == 1)
						go_clear = 0;	
					current_state <= next_state;
				end
    end 
endmodule





module datapath (clk, position, colour_in, resetn, ld_x, ld_y, go_plot, go_clear, x_out, y_out, colour, done_plot);
	//input from user interface
	input clk;
	input [6:0]position;
	input [2:0]colour_in;
	input resetn;
	//input signal from the control
	input ld_x;
	input ld_y;
	input go_plot;
	input go_clear;
	//output to the vpga
	reg [7:0]xposition;
	reg [6:0]yposition;
	
	output [7:0]x_out;
	output [6:0]y_out;
	
	reg [7:0]x_p ;
	reg [6:0]y_p ;
	
	assign x_out = (go_clear ? 0 : xposition) + x_p;
	assign y_out = (go_clear ? 0 : yposition) + y_p;
	
	output [2:0]colour;
	//signal output to the control
	output reg done_plot=0 ;


	wire [9:0]width;
	wire [9:0]height;
	
	initial begin
		x_p =  8'b0 ;
		y_p =  7'b0;
	end

	assign width = go_clear ? 160: 4;
	assign height = go_clear ? 120: 4;
	assign colour = go_clear ? 3'b000 : colour_in;
	
	always@(posedge clk)
		begin
			//reset case
			if (resetn==0)
				begin
					xposition <= 8'b0;
					yposition <= 7'b0;
				end
			
			//load x value to xposition
			else if (ld_x) 
				begin
					xposition <= {1'b0, position};
					done_plot=0;
				end
			
			//load y value to yposition
			else if (ld_y)
				yposition <= position;
			
			//plot 
			else if (go_plot & !done_plot)
				begin
					x_p=x_p+1;
					if (x_p == width)
						begin
							x_p=0;
							y_p=y_p+1;
						end
					
					if (y_p == height)
						begin
							y_p=0;
							done_plot=1;
						end
					
				end
		end
endmodule








