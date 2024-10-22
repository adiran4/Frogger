module DE1_SoC (CLOCK_50, GPIO_1, HEX0, LEDR, KEY, SW);
	
	input logic				CLOCK_50; // 50MHz clock
	output logic [6:0] HEX0;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	output logic	[35:0] GPIO_1;
	
	// Generate clk off of CLOCK_50, whichClock picks rate.
	logic  [31:0] clk;
	parameter whichClock1 = 12;
	clock_divider cdiv (CLOCK_50, clk);

	logic [15:0][15:0] greenArray, redArray;
	logic L, R, up, down;
	logic resetGame;
	
	//logic level1, level2, level3, level4, pause, reset, k1, k2, k3, k4, changeControl;
	logic level1, level2, level3, level4, pause, reset, k1, k2, k3, k4;
	assign level1 = SW[3];
	assign level2 = SW[4];
	assign level3 = SW[5];
	assign level4 = SW[6];
	assign pause = SW[0];
	assign reset = SW[9];
	
	
	always_comb begin
		if (!SW[1]) begin
			k1 = KEY[1];
			k2 = KEY[3];
			k3 = KEY[2];
			k4 = KEY[0];
		end else begin
			k1 = KEY[3];
			k2 = KEY[2];
			k3 = KEY[1];
			k4 = KEY[0];
		end
	end
	

	button butLeft(.clk(clk[whichClock1]), .reset, .inputButton(k1), .out(L));
	button butUp(.clk(clk[whichClock1]), .reset, .inputButton(k2), .out(up));
	button butDown(.clk(clk[whichClock1]), .reset, .inputButton(k3), .out(down));
	button butRight(.clk(clk[whichClock1]), .reset, .inputButton(k4), .out(R));
	counters score(.clk(clk[whichClock1]), .reset(reset), .up(up), .topRow(greenArray[15]), .HEX0);
	collision c(.clk(clk[whichClock1]), .gA(greenArray), .rA(redArray), .resetgame(resetGame));
	frog f(.clk(clk[whichClock1]), .reset(reset), .resetField(resetGame), .pause(pause), .left(L), .right(R), .up(up), .down(down) , .currentArray(greenArray), .greenArray);
	cars car(.clk(clk[whichClock1]), .reset(reset), .resetField(resetGame), .pause(pause), .currentArray(redArray), .redArray, .level({level4, level3, level2, level1}));
	LEDDriver test (.GPIO_1, .RedPixels(redArray), .GrnPixels(greenArray), .EnableCount(1'b1), .CLK(clk[whichClock1]), .RST(resetGame));

endmodule 

// divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ... [23] = 3Hz, [24] = 1.5Hz, [25] = 0.75Hz, ...

module clock_divider (clock, divided_clocks);
	input logic 			clock;
	output logic [31:0] 	divided_clocks = 0;

	always_ff @(posedge clock) begin
		divided_clocks <= divided_clocks + 1;
	end

endmodule

/*
module DE1_SoC_testbench ();
	logic clk, reset;
	logic [3:0] KEY;
	logic [9:0] SW;
	logic [9:0] LEDR;
	logic [6:0] HEX0;
	logic [35:0] GPIO_1;

	DE1_SoC dut (clk, GPIO_1,HEX0, LEDR, KEY, SW);

	// Set up the clock
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	// Set up the inputs to the design (each line is a clock cycle)
	initial begin
		SW[9] <= 1; SW[8:0] <= 9'b100000000; @(posedge clk); 
		SW[9] <= 0;				         @(posedge clk); 

												@(posedge clk);  // cars should move left
		KEY[3]<=1;					 	   @(posedge clk); 
		KEY[3] <=0;						   @(posedge clk);
		KEY[3] <= 1;						@(posedge clk);
		KEY[3]<=0; 							@(posedge clk);
												@(posedge clk);
		KEY[0] <= 1;					   @(posedge clk);
	 
		 
		KEY[0]<= 0;				 			@(posedge clk); 
												@(posedge clk);
		KEY[2] <= 1;						@(posedge clk);
		KEY[2] <= 0;						@(posedge clk);
		KEY[2] <= 1;						@(posedge clk);
		KEY[2] <= 0;						@(posedge clk);
		KEY[2] <= 1;						@(posedge clk);
		KEY[2] <= 0;						@(posedge clk);
		KEY[2] <= 1;						@(posedge clk);
		KEY[2] <= 0;						@(posedge clk);
		KEY[2] <= 1;						@(posedge clk);
		KEY[2] <= 0;						@(posedge clk);
		KEY[2] <= 1;						@(posedge clk);
		KEY[2] <= 0;						@(posedge clk);  // Going up, we can crash also
		KEY[1] <= 1;						@(posedge clk);
		KEY[1] <= 0;						@(posedge clk);
		KEY[2] <= 1;						@(posedge clk);
		KEY[2] <= 0;						@(posedge clk);
		KEY[0] <= 1;						@(posedge clk);
		KEY[0] <= 0;						@(posedge clk);
		KEY[3] <= 1;						@(posedge clk);
		KEY[3] <= 0;						@(posedge clk);
		SW[9] <= 1;						@(posedge clk);
	 $stop; // End the simulation
	end

endmodule */