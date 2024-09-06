// victoria Parizot
// vparizot@g.hmc.edu
// 9/5/2024
module top(
	input logic [3:0] s,
	output logic [2:0] led, logic [6:0] seg
);

// call other module
ledgates s1(s, led);
sevensegments s2(s, seg);


endmodule