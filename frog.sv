module frog(clk, reset, resetField, pause, left, right, up, down , currentArray, greenArray );

	input logic clk, left, right, up, down, reset, resetField, pause;
	input logic [15:0][15:0] currentArray;
	output logic [15:0][15:0] greenArray;
	always_ff @(posedge clk) begin
    	if (reset | resetField | (up & currentArray[15] != 16'b0000000000000000)) begin
          greenArray <= {{16'b0000000000000000},
								{16'b00000000000000000},
								{16'b00000000000000000},
								{16'b00000000000000000},
								{16'b00000000000000000},
								{16'b00000000000000000},
								{16'b00000000000000000},
								{16'b00000000000000000},
								{16'b00000000000000000},
								{16'b00000000000000000},
								{16'b00000000000000000},
								{16'b00000000000000000},
								{16'b00000000000000000},
								{16'b00000000000000000},
								{16'b00000000000000000},
								{16'b00000001000000000}
								};
		end else if (down & currentArray[0] != 16'b0000000000000000) begin  
			greenArray <= currentArray;
		end else if (down) begin   
			greenArray[15] <= 16'b0000000000000000;
			greenArray[14:0] <= currentArray[15:1];
		end else if (up) begin
			greenArray[15:1] <= currentArray[14:0];
			greenArray[0] <= 16'b0000000000000000;
		end else if (right & (currentArray[0][0] == 1'b1 | currentArray[1][0] == 1'b1 | currentArray[2][0] == 1'b1 | currentArray[3][0] == 1'b1 | currentArray[4][0] == 1'b1 |
					currentArray[5][0] == 1'b1  | currentArray[6][0] == 1'b1 | currentArray[7][0] == 1'b1  |
					currentArray[8][0] == 1'b1  | currentArray[9][0] == 1'b1  | currentArray[10][0] == 1'b1 |
					currentArray[11][0] == 1'b1 | currentArray[12][0] == 1'b1 | currentArray[13][0] == 1'b1 |
					currentArray[14][0] == 1'b1 | currentArray[15][0] == 1'b1)) begin  // The player is trying to go right after the right most position
			greenArray[0] <= {currentArray[0][0], currentArray[0][15:1]};
			greenArray[1] <= {currentArray[1][0], currentArray[1][15:1]};
			greenArray[2] <= {currentArray[2][0], currentArray[2][15:1]};
			greenArray[3] <= {currentArray[3][0], currentArray[3][15:1]};
			greenArray[4] <= {currentArray[4][0], currentArray[4][15:1]};
			greenArray[5] <= {currentArray[5][0], currentArray[5][15:1]};
			greenArray[6] <= {currentArray[6][0], currentArray[6][15:1]};
			greenArray[7] <= {currentArray[7][0], currentArray[7][15:1]};
			greenArray[8] <= {currentArray[8][0], currentArray[8][15:1]};
			greenArray[9] <= {currentArray[9][0], currentArray[9][15:1]};
			greenArray[10] <= {currentArray[10][0], currentArray[10][15:1]};
			greenArray[11] <= {currentArray[11][0], currentArray[11][15:1]};
			greenArray[12] <= {currentArray[12][0], currentArray[12][15:1]};
			greenArray[13] <= {currentArray[13][0], currentArray[13][15:1]};
			greenArray[14] <= {currentArray[14][0], currentArray[14][15:1]};
			greenArray[15] <= {currentArray[15][0], currentArray[15][15:1]};
		end else if (right) begin  // Shift everything right
			greenArray[0] <= {1'b0, currentArray[0][15:1]};
			greenArray[1] <= {1'b0, currentArray[1][15:1]};
			greenArray[2] <= {1'b0, currentArray[2][15:1]};
			greenArray[3] <= {1'b0, currentArray[3][15:1]};
			greenArray[4] <= {1'b0, currentArray[4][15:1]};
			greenArray[5] <= {1'b0, currentArray[5][15:1]};
			greenArray[6] <= {1'b0, currentArray[6][15:1]};
			greenArray[7] <= {1'b0, currentArray[7][15:1]};
			greenArray[8] <= {1'b0, currentArray[8][15:1]};
			greenArray[9] <= {1'b0, currentArray[9][15:1]};
			greenArray[10] <= {1'b0, currentArray[10][15:1]};
			greenArray[11] <= {1'b0, currentArray[11][15:1]};
			greenArray[12] <= {1'b0, currentArray[12][15:1]};
			greenArray[13] <= {1'b0, currentArray[13][15:1]};
			greenArray[14] <= {1'b0, currentArray[14][15:1]};
			greenArray[15] <= {1'b0, currentArray[15][15:1]};

		end else if (left & (currentArray[0][15] == 1'b1 | currentArray[1][15] == 1'b1 | currentArray[2][15] == 1'b1 | currentArray[3][15] == 1'b1 | currentArray[4][15] == 1'b1 |
					currentArray[5][15] == 1'b1 | currentArray[6][15] == 1'b1 | currentArray[7][15] == 1'b1 | currentArray[8][15] == 1'b1 | currentArray[9][15] == 1'b1 | 
					currentArray[10][15] == 1'b1| currentArray[11][15] == 1'b1| currentArray[12][15] == 1'b1| currentArray[13][15] == 1'b1| currentArray[14][15] == 1'b1| currentArray[15][15] == 1'b1)) begin // Player is trying to go left after the extreme position
			greenArray[0] <= {currentArray[0][14:0], currentArray[0][15]};
			greenArray[1] <= {currentArray[1][14:0], currentArray[1][15]};
			greenArray[2] <= {currentArray[2][14:0], currentArray[2][15]};
			greenArray[3] <= {currentArray[3][14:0], currentArray[3][15]};
			greenArray[4] <= {currentArray[4][14:0], currentArray[4][15]};
			greenArray[5] <= {currentArray[5][14:0], currentArray[5][15]};
			greenArray[6] <= {currentArray[6][14:0], currentArray[6][15]};
			greenArray[7] <= {currentArray[7][14:0], currentArray[7][15]};
			greenArray[8] <= {currentArray[8][14:0], currentArray[8][15]};
			greenArray[9] <= {currentArray[9][14:0], currentArray[9][15]};
			greenArray[10] <= {currentArray[10][14:0], currentArray[10][15]};
			greenArray[11] <= {currentArray[11][14:0], currentArray[11][15]};
			greenArray[12] <= {currentArray[12][14:0], currentArray[12][15]};
			greenArray[13] <= {currentArray[13][14:0], currentArray[13][15]};
			greenArray[14] <= {currentArray[14][14:0], currentArray[14][15]};
			greenArray[15] <= {currentArray[15][14:0], currentArray[15][15]};
		end else if (left) begin
			greenArray[0] <= {currentArray[0][14:0], 1'b0};
			greenArray[1] <= {currentArray[1][14:0], 1'b0};
			greenArray[2] <= {currentArray[2][14:0], 1'b0};
			greenArray[3] <= {currentArray[3][14:0], 1'b0};
			greenArray[4] <= {currentArray[4][14:0], 1'b0};
			greenArray[5] <= {currentArray[5][14:0], 1'b0};
			greenArray[6] <= {currentArray[6][14:0], 1'b0};
			greenArray[7] <= {currentArray[7][14:0], 1'b0};
			greenArray[8] <= {currentArray[8][14:0], 1'b0};
			greenArray[9] <= {currentArray[9][14:0], 1'b0};
			greenArray[10] <= {currentArray[10][14:0], 1'b0};
			greenArray[11] <= {currentArray[11][14:0], 1'b0};
			greenArray[12] <= {currentArray[12][14:0], 1'b0};
			greenArray[13] <= {currentArray[13][14:0], 1'b0};
			greenArray[14] <= {currentArray[14][14:0], 1'b0};
			greenArray[15] <= {currentArray[15][14:0], 1'b0};
		end else if (pause) begin
			greenArray <= currentArray;
		end else begin
			greenArray <= currentArray;
		end
	end
endmodule
	
	/*
module frog_testbench ();
	logic clk, reset, resetField, left, right, up, down, pause;
	logic [15:0][15:0] greenArray, currentArray;
	
	frog dut (clk, reset, resetField, pause, left, right, up, down, currentArray, greenArray );

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
								{8'b11110111}};
			reset <= 1;	resetField <= 0; left <= 0; right<=0; up <= 0; down <= 0; pause<=0;			@(posedge clk);
																																@(posedge clk);
			reset <= 0; @(posedge clk);
			left 	<= 1; @(posedge clk);
			left 	<= 0; @(posedge clk);
			right <= 1; @(posedge clk);
			right <= 0; @(posedge clk);
			down 	<= 1; @(posedge clk); 
			down 	<= 0; @(posedge clk);
			up 	<= 1; @(posedge clk);
							@(posedge clk); 
			up 	<= 0; @(posedge clk);
			right <= 1; @(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk); 
			right <= 0; @(posedge clk);
		$stop;
	 end
	 
endmodule 
		*/	
			
			
			
			
			
			
			
			
			