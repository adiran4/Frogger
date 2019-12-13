module collision (clk, gA, rA, resetgame);
	input logic clk;
	input logic [15:0][15:0] gA, rA;
	output logic resetgame;
	
	always_ff @(posedge clk) begin
		if (((gA[0] & rA[0])  != 16'b0000000000000000) | ((gA[1] & rA[1]) != 16'b0000000000000000)  | ((gA[2] & rA[2]) != 16'b0000000000000000)
			|((gA[3] & rA[3])  != 16'b0000000000000000) | ((gA[4] & rA[4]) != 16'b0000000000000000)  | ((gA[5] & rA[5]) != 16'b0000000000000000) 
			|((gA[6] & rA[6])  != 16'b0000000000000000) | ((gA[7] & rA[7]) != 16'b0000000000000000)  | ((gA[8] & rA[8]) != 16'b0000000000000000)
			|((gA[9] & rA[9])  != 16'b0000000000000000) | ((gA[10] & rA[10]) != 16'b0000000000000000)| ((gA[11] & rA[11]) != 16'b0000000000000000)
			|((gA[12] & rA[12]) != 16'b0000000000000000)| ((gA[13] & rA[13]) != 16'b0000000000000000)| ((gA[14] & rA[14]) != 16'b0000000000000000)
			|((gA[15] & rA[15]) != 16'b0000000000000000)) begin
			resetgame <= 1'b1;
		end else begin
			resetgame <= 1'b0;
		end
	end
endmodule

/*
module collision_testbench ();
	logic clk;
	logic [7:0][7:0] gA, rA;
	logic resetgame;
	
	collision dut (clk, gA, rA, resetgame);
	
	
	// Set up the clock
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin	
		rA <= {     {8'b00000000},
						{8'b00000000},
						{8'b00000000},
						{8'b00000000},
						{8'b00000000},
						{8'b00000000},
						{8'b00000000},
						{8'b00000000}};
		gA <= {     {8'b00000000},
						{8'b00000000},
						{8'b00000000},
						{8'b00000000},
						{8'b00000000},
						{8'b00000000},
						{8'b00000000},
						{8'b00000000}};

		gA[0] <= 8'b01000000; rA[0] <= 8'b01000000;   @(posedge clk);  //collision
		gA[0] <= 8'b01000000; rA[0] <= 8'b00100000;   @(posedge clk);
		gA[1] <= 8'b10000000; rA[1] <= 8'b10000000;   @(posedge clk);  // collosion
		gA[1] <= 8'b01000000; rA[1] <= 8'b00000100;   @(posedge clk);
		gA[2] <= 8'b00100000; rA[2] <= 8'b00100000;   @(posedge clk);  //collision
		gA[2] <= 8'b01000000; rA[2] <= 8'b10000000;   @(posedge clk);
		gA[3] <= 8'b00010000; rA[3] <= 8'b00010000;   @(posedge clk);  // collision
		gA[3] <= 8'b01000000; rA[3] <= 8'b10000000;   @(posedge clk);
		gA[4] <= 8'b00001000; rA[4] <= 8'b00001000;   @(posedge clk);  //collision
		gA[4] <= 8'b01000000; rA[4] <= 8'b10000000;   @(posedge clk);
		gA[5] <= 8'b00000100; rA[5] <= 8'b00000100;   @(posedge clk);  // collision
		gA[5] <= 8'b01000000; rA[5] <= 8'b10000000;   @(posedge clk);
		gA[6] <= 8'b00000010; rA[6] <= 8'b00000010;   @(posedge clk);  // collision
		gA[6] <= 8'b01000000; rA[6] <= 8'b10000000;   @(posedge clk);
		gA[7] <= 8'b00000001; rA[7] <= 8'b00000001;   @(posedge clk);  // collision
		gA[7] <= 8'b01000000; rA[2] <= 8'b10000000;   @(posedge clk);
	$stop; // End the simulation
	end
	 
endmodule 
	*/