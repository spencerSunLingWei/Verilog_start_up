module segment(input[3:0]c, output[6:0]f);
	assign f[0]=(~c[3]&~c[2]&~c[1]&c[0]) | (~c[3]&c[2]&~c[1]&~c[0]) | (c[3]&~c[2]&c[1]&c[0]) | (c[3]&c[2]&~c[1]&c[0]);
	assign f[1]=(~c[3]&c[2]&~c[1]&c[0]) | (~c[3]&c[2]&c[1]&~c[0]) | (c[3]&~c[2]&c[1]&c[0]) | (c[3]&c[2]&~c[1]&~c[0]) | (c[3]&c[2]&c[1]&~c[0]) | (c[3]&c[2]&c[1]&c[0]);
	assign f[2]=(~c[3]&~c[2]&c[1]&~c[0]) | (c[3]&c[2]&~c[1]&~c[0]) | (c[3]&c[2]&c[1]&~c[0]) | (c[3]&c[2]&c[1]&c[0]);
	assign f[3]=(~c[3]&~c[2]&~c[1]&c[0]) | (~c[3]&c[2]&~c[1]&~c[0]) | (~c[3]&c[2]&c[1]&c[0]) | (c[3]&~c[2]&c[1]&~c[0]) | (c[3]&c[2]&c[1]&c[0]);
	assign f[4]=(~c[3]&~c[2]&~c[1]&c[0]) | (~c[3]&~c[2]&c[1]&c[0]) | (~c[3]&c[2]&~c[1]&~c[0]) | (~c[3]&c[2]&~c[1]&c[0]) | (~c[3]&c[2]&c[1]&c[0]) | (c[3]&~c[2]&~c[1]&c[0]);
	assign f[5]=(~c[3]&~c[2]&~c[1]&c[0]) | (~c[3]&~c[2]&c[1]&~c[0]) | (~c[3]&~c[2]&c[1]&c[0]) | (~c[3]&c[2]&c[1]&c[0]) | (c[3]&c[2]&~c[1]&c[0]);
	assign f[6]=(~c[3]&~c[2]&~c[1]&~c[0]) | (~c[3]&~c[2]&~c[1]&c[0]) | (~c[3]&c[2]&c[1]&c[0]) | (c[3]&c[2]&~c[1]&~c[0]);
endmodule



module top (SW, KEY, HEX0, HEX2, HEX4, HEX5);
	input [9:0]SW;
	input [3:0]KEY;
	output [6:0]HEX0, HEX2, HEX4, HEX5;
	wire [3:0]q;
	ram32x4 r1 (SW[8:4], KEY[0], SW[3:0], SW[9], q);
	segment s1 (SW[7:4], HEX4[6:0]);
	segment s2 ({3'b0,SW[8]}, HEX5[6:0]);
	segment s3 (SW[3:0], HEX2[6:0]);
	segment s4 (q, HEX0);
endmodule

module ram32x4 (
	address,
	clock,
	data,
	wren,
	q);

	input	[4:0]  address;
	input	  clock;
	input	[3:0]  data;
	input	  wren;
	output	[3:0]  q;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri1	  clock;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire [3:0] sub_wire0;
	wire [3:0] q = sub_wire0[3:0];

	altsyncram	altsyncram_component (
				.address_a (address),
				.clock0 (clock),
				.data_a (data),
				.wren_a (wren),
				.q_a (sub_wire0),
				.aclr0 (1'b0),
				.aclr1 (1'b0),
				.address_b (1'b1),
				.addressstall_a (1'b0),
				.addressstall_b (1'b0),
				.byteena_a (1'b1),
				.byteena_b (1'b1),
				.clock1 (1'b1),
				.clocken0 (1'b1),
				.clocken1 (1'b1),
				.clocken2 (1'b1),
				.clocken3 (1'b1),
				.data_b (1'b1),
				.eccstatus (),
				.q_b (),
				.rden_a (1'b1),
				.rden_b (1'b1),
				.wren_b (1'b0));
	defparam
		altsyncram_component.clock_enable_input_a = "BYPASS",
		altsyncram_component.clock_enable_output_a = "BYPASS",
		altsyncram_component.intended_device_family = "Cyclone V",
		altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",
		altsyncram_component.lpm_type = "altsyncram",
		altsyncram_component.numwords_a = 32,
		altsyncram_component.operation_mode = "SINGLE_PORT",
		altsyncram_component.outdata_aclr_a = "NONE",
		altsyncram_component.outdata_reg_a = "UNREGISTERED",
		altsyncram_component.power_up_uninitialized = "FALSE",
		altsyncram_component.read_during_write_mode_port_a = "NEW_DATA_NO_NBE_READ",
		altsyncram_component.widthad_a = 5,
		altsyncram_component.width_a = 4,
		altsyncram_component.width_byteena_a = 1;


endmodule
