## E155 Lab 1
// Onboard LEDs - defining the behavior of 3 LEDS
// Onboard LEDs - defining the behavior of 3 LEDS

module top(
	input logic clk, input logic [3:0] s,
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













// lab1 test vectors
// victoria parizot
// vparizot@g.hmc.edu
// Sept 3, 2025

// s_led_seg
0000_000_0100011;
0001_101_1111001; 
0010_100_0100100; 
0011_000_0110000; 
0100_000_0011001;
0101_100_0010010; 
0110_100_0000010;
0111_000_1111000; 
1000_000_0000000; 
1001_100_0011000;
1010_100_0100000;
1011_000_0000011;
1100_010_1000110;
1101_110_0000011;
1110_110_0000100; 
1111_010_0001110; 

`timescale 1ns/1ns
`default_nettype none
`define N_TV 8

module labone_tb();
 // Set up test signals
 logic clk;
 logic [3:0] s;
 logic [2:0] led;
 logic [6:0] seg;
 logic [2:0] led_expected;
 logic [6:0] seg_expected;
 
 logic [31:0] vectornum, errors;
 logic [10:0] testvectors[10000:0]; // Vectors of format s[3:0]_seg[6:0]

 // Instantiate the device under test
 labone dut(.S(s), .LED(led), .SEG(seg));

 // Generate clock signal with a period of 10 timesteps.
 always
   begin
     clk = 1; #5;
     clk = 0; #5;
   end
  
 // At the start of the simulation:
 //  - Load the testvectors
 //  - Pulse the reset line (if applicable)
 initial
   begin
     $readmemb("fulladder_testvectors.tv", testvectors, 0, `N_TV - 1);
     vectornum = 0; errors = 0;
     reset = 1; #27; reset = 0;
   end
  // Apply test vector on the rising edge of clk
 always @(posedge clk)
   begin
       #1; {a, b, cin, s_expected, cout_expected} = testvectors[vectornum];
   end
  initial
 begin
   // Create dumpfile for signals
   $dumpfile("labone_tb.vcd");
   $dumpvars(0, labone_tb);
 end
  // Check results on the falling edge of clk
 always @(negedge clk)
   begin
     if (~reset) // skip during reset
       begin
         if (cout != cout_expected || s != s_expected)
           begin
             $display("Error: inputs: a=%b, b=%b, cin=%b", a, b, cin);
             $display(" outputs: s=%b (%b expected), cout=%b (%b expected)", s, s_expected, cout, cout_expected);
             errors = errors + 1;
           end

      
       vectornum = vectornum + 1;
      
       if (testvectors[vectornum] === 11'bx)
         begin
           $display("%d tests completed with %d errors.", vectornum, errors);
           $finish;
         end
     end
   end
endmodule
