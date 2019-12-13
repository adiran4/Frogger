module enable1 (clk, enable);

	input clk;
	output reg enable;
	reg [13:0] num = 14'b00000000000000;
	
	always @(posedge clk)
		if (num == 14'b00000000000000) begin
			enable <= 1'b1;
			num <= 14'b00000000000001;
		end
		else begin
			enable <= 1'b0;
			num <= num + 14'b00000000000001;
		end
		
endmodule

module enable2 (clk, enable);

	input clk;
	output reg enable;
	reg [12:0] num = 13'b0000000000000;
	
	always @(posedge clk)
		if (num == 13'b0000000000000) begin
			enable <= 1'b1;
			num <= 13'b0000000000001;
		end
		else begin
			enable <= 1'b0;
			num <= num + 13'b0000000000001;
		end
		
endmodule

module enable3 (clk, enable);

	input clk;
	output reg enable;
	reg [11:0] num = 12'b000000000000;
	
	always @(posedge clk)
		if (num == 12'b000000000000) begin
			enable <= 1'b1;
			num <= 12'b000000000001;
		end
		else begin
			enable <= 1'b0;
			num <= num + 12'b000000000001;
		end
		
endmodule

module enable4 (clk, enable);

	input clk;
	output reg enable;
	reg [10:0] num = 11'b00000000000;
	
	always @(posedge clk)
		if (num == 11'b00000000000) begin
			enable <= 1'b1;
			num <= 11'b00000000001;
		end
		else begin
			enable <= 1'b0;
			num <= num + 11'b00000000001;
		end
		
endmodule
