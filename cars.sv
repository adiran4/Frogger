module cars (clk, reset, resetField, pause, currentArray, redArray, level);

	input logic clk, reset, resetField, pause;
	input logic [15:0][15:0] currentArray;
	output logic [15:0][15:0] redArray;
	input logic [3:0] level;
	
	logic enable, level1, level2, level3, level4;
	
	// Change for simulation
	
   always_comb begin
		if (level == 4'b0010) begin
			enable = level2;
		end else if (level == 4'b0100) begin
			enable = level3;
		end else if (level == 4'b1000) begin
			enable = level4;
		end else begin
			enable = level1;
		end
	end
	
	// Use this for simulation
	//assign enable = level1;
	
	enable1 lev1(.clk(clk), .enable(level1));
	enable2 lev2(.clk(clk), .enable(level2));
	enable3 lev3(.clk(clk), .enable(level3));
	enable4 lev4(.clk(clk), .enable(level4));
	
	always_ff @(posedge clk) begin
		if (reset || resetField) begin
			redArray <= {  {16'b1001100101100110},
								{16'b1001000001001100},
								{16'b0101100110001101},
								{16'b1010000100100100},
								{16'b1010001100101100},
								{16'b1011000110101100},
								{16'b1010001100101000},
								{16'b1011001100101101},
								{16'b1010101000101100},
								{16'b1011101100100100},
								{16'b1011000100101100},
								{16'b1011001100111100},
								{16'b0010011001101110},
								{16'b1011001100101000},
								{16'b1010101100101100},
								{16'b0000000000000000}
							  };
		end else if (pause) begin
			redArray <= currentArray;
		end else if (enable == 1'b1) begin 
			redArray[0] <= {currentArray[0][14:0], currentArray[0][15]};
			redArray[1] <= {currentArray[1][14:0], currentArray[2][15]};
			redArray[2] <= {currentArray[2][14:0], currentArray[3][15]};
			redArray[3] <= {currentArray[3][14:0], currentArray[6][15]};
			redArray[4] <= {currentArray[4][14:0], currentArray[8][15]};
			redArray[5] <= {currentArray[5][14:0], currentArray[10][15]};
			redArray[6] <= {currentArray[6][14:0], currentArray[12][15]};
			redArray[7] <= {currentArray[7][14:0], currentArray[13][15]};
			redArray[8] <= {currentArray[8][14:0], currentArray[14][15]};
			redArray[9] <= {currentArray[9][14:0], currentArray[15][15]};
			redArray[10] <= {currentArray[10][14:0], currentArray[13][15]};
			redArray[11] <= {currentArray[11][14:0], currentArray[11][15]};
			redArray[12] <= {currentArray[12][14:0], currentArray[9][15]};
			redArray[13] <= {currentArray[13][14:0], currentArray[7][15]};
			redArray[14] <= {currentArray[14][14:0], currentArray[4][15]};
			redArray[15] <= {currentArray[15][14:0], currentArray[1][15]};
		end else begin
			redArray <= currentArray;
		end
	end

endmodule

/*
module cars_testbench ();
	logic clk, reset, resetField, pause; 
	logic [3:0] level; //level won't work in modelsim
	logic [7:0][7:0] redArray;
	logic [7:0][7:0] currentArray;
	cars dut (clk, reset, resetField, pause, currentArray, redArray, level );

	// Set up the clock
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	initial begin	
			currentArray <= {{8'b11111111},
								{8'b11111111},
								{8'b11111111},
								{8'b11111111},
								{8'b11111111},
								{8'b11111111},
								{8'b11111111},
								{8'b11110111}
							  };
			reset <= 1;	resetField <= 0; 	pause<=0;			@(posedge clk);
																														@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			pause <=1; @(posedge clk);
			@(posedge clk); // Should stay same
			@(posedge clk);
			@(posedge clk);
			resetField <= 1; pause <=0; @(posedge clk);
			@(posedge clk);
			@(posedge clk);

		$stop; // End the simulation
	 end
	 
endmodule */
			

