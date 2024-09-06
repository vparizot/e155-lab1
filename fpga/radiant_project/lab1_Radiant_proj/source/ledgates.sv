// Victoria Parizot
// vparizot@g.hmc.edu
// 9/5/2024

module ledgates(
	input logic [3:0] s,
	output logic [2:0] led
);

// variables
	logic int_osc;
	logic pulse;
	logic led_state = 0;
	logic [24:0] counter = 0;
	logic LEDVAL = 0;

// LED 0 - XOR
	xor (led[0], s[0], s[1]);

// LED 1 - AND
	and (led[1], s[3], s[2]);

// LED 2 - blinks at 2.4 Hz
// Internal high-speed oscillator

	HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
	
// Simple clock divider
	always_ff @(posedge int_osc)
	begin
		counter <= counter + 1;
		// at hz
		if (counter == 10000000)
		begin
			counter <= 0;
			if (LEDVAL == 0) LEDVAL <= 1 ; // turn on LED if off
			else LEDVAL <= 0; //turn OFF led
		end
	end

// Asssign LED outputs
	assign led[2] = LEDVAL;
	

endmodule