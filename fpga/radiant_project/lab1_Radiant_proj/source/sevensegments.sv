// Victoria Parizot
// vparizot@g.hmc.edu
// 9/5/2024

module sevensegments(
	input logic [3:0] s,
	output logic [6:0] seg
);
// takes in dipswitch as 4 digit binary value and 
// outputs hexidecimal value on seven segment display
always_comb
	begin
		case (s) 
			4'b0000 : seg = 7'b0100011; //1100010; 
			4'b0001 : seg = 7'b1111001; //b1111001;
			4'b0010 : seg = 7'b0100100; //b0010010;
			4'b0011 : seg = 7'b0110000; //b0000110;
			4'b0100 : seg = 7'b0011001; //b1001100;
			4'b0101 : seg = 7'b0010010; //b0100100;
			4'b0110 : seg = 7'b0000010; //b0100000;
			4'b0111 : seg = 7'b1111000; //b0001111;
			4'b1000 : seg = 7'b0000000; //b0000000;
			4'b1001 : seg = 7'b0011000; //b0001100;
			4'b1010 : seg = 7'b0100000; //b0000010;
			4'b1011 : seg = 7'b0000011; //b1100000;
			4'b1100 : seg = 7'b1000110; //b0110001;
			4'b1101 : seg = 7'b0100001; //b1100010;
			4'b1110 : seg = 7'b0000100; //b0010000;
			4'b1111 : seg = 7'b0001110; //b0111000;
			default: seg = 7'b1111111;
		endcase
	end
endmodule
