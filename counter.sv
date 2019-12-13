module counters (clk, reset, up, topRow, HEX0);

	input logic clk, reset, up;
	input logic [15:0] topRow;
	output logic [6:0] HEX0;
	
	logic [3:0] ps, ns;
	
	parameter zero = 5'b00000, one = 5'b00001, two = 5'b00010, three = 5'b00011, four = 5'b00100, five = 5'b00101, six = 5'b00110, seven = 5'b00111, eight = 5'b01000, nine = 5'b01001,
	          ten = 5'b01010 , eleven = 5'b01011, twelve = 5'b01100, thirteen = 5'b01101, fourteen = 5'b01110, fifteen = 5'b01111,
				 sixteen = 5'b10000, seventeen = 5'b10001;

	logic increase;
	assign increase = up & (topRow != 16'b0000000000000000); // if there is frog on top row and up is pressed

	always_comb begin
	
		if ((ps == seventeen) & (increase)) begin		ns = zero;
		end
		else if ((ps == zero) & increase) begin	   ns = one;
		end
		else if ((ps == one) & increase) begin		   ns = two;
		end
		else if ((ps == two) & increase) begin		   ns = three;
		end
		else if ((ps == three) & increase) begin	ns = four;
		end
		else if ((ps == four) & increase) begin	ns = five;
		end
		else if ((ps == five) & increase) begin	ns = six;
		end
		else if ((ps == six) & increase) begin		ns = seven;
		end
		else if ((ps == seven) & increase) begin	ns = eight;
		end
		else if ((ps == eight) & increase) begin	ns = nine;
		end
	   else if ((ps == nine) & increase) begin	ns = ten;
		end
		else if ((ps == ten) & increase) begin	ns = eleven;
		end
		else if ((ps == eleven) & increase) begin	ns = twelve;
		end
		else if ((ps == twelve) & increase) begin	ns = thirteen;
		end
		else if ((ps == thirteen) & increase) begin	ns = fourteen;
		end
		else if ((ps == fourteen) & increase) begin	ns = fifteen;
		end
		else if ((ps == fifteen) & increase) begin	ns = sixteen;
		end
		else if ((ps == sixteen) & increase) begin	ns = seventeen;
		end
		else begin											ns = ps;
		end
	end

	HEXDisplay score (.state(ps), .HEX0);

	// DFFs
   always_ff @(posedge clk) begin
    	if (reset) begin
            ps <= zero;
      end
      else begin
				ps <= ns;
      end
	end

endmodule


module HEXDisplay (state, HEX0);
	input [3:0] state;
	output logic [6:0] HEX0;
	
	parameter zero = 4'b0000, one = 4'b0001, two = 4'b0010, three = 4'b0011, four = 4'b0100, five = 4'b0101, six = 4'b0110, seven = 4'b0111, eight = 4'b1000, nine = 4'b1001;

	logic [6:0] off, ZERO, ONE, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE;
	
	assign off  = 7'b1111111; 
	assign ZERO = 7'b1000000;
	assign ONE  = 7'b1111001;
	assign TWO  = 7'b0100100;
	assign THREE= 7'b0110000;
	assign FOUR = 7'b0011001;
	assign FIVE = 7'b0010010;
	assign SIX  = 7'b0000010;
	assign SEVEN= 7'b1111000;
	assign EIGHT= 7'b0000000;
	assign NINE = 7'b0010000;

	always_comb begin
		case (state)
			zero    : HEX0 = ZERO;
			one     : HEX0 = ONE;
			two     : HEX0 = TWO;
			three   : HEX0 = THREE;
			four    : HEX0 = FOUR;
			five    : HEX0 = FIVE;
			six     : HEX0 = SIX;
			seven   : HEX0 = SEVEN;
			eight   : HEX0 = EIGHT;
			nine    : HEX0 = NINE;
			default : HEX0 = off;
		endcase
	end
endmodule

/*

module counters_testbench ();
	logic clk;
	logic reset, up;
	logic [7:0] topRow;
	logic [6:0] HEX0;
	
	counters dut (clk, reset, up, topRow, HEX0);
	
	
	// Set up the clock
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end 

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin	
		reset <= 1;	up <= 0; topRow <= 8'b00000000;@(posedge clk);
		reset <= 0;;										@(posedge clk);
																@(posedge clk);
		up <= 1; topRow <= 8'b10000000;				@(posedge clk);
		up <= 0; topRow <= 8'b01000000;				@(posedge clk);
		up <= 1; topRow <= 8'b00100000;				@(posedge clk);
		up <= 1; topRow <= 8'b00010000;				@(posedge clk);
		up <= 1; topRow <= 8'b00001000;				@(posedge clk);
		up <= 0; topRow <= 8'b00000100;				@(posedge clk);
		up <= 1; topRow <= 8'b00000010;				@(posedge clk);
		up <= 1; topRow <= 8'b00000010;				@(posedge clk);
		up <= 1; topRow <= 8'b00000010;				@(posedge clk);
		reset <= 1;											@(posedge clk);
	$stop;
	end

endmodule*/
