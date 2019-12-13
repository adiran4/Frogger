module button (clk, reset, inputButton, out);
	input logic clk, reset;
	input logic inputButton;
	output logic out;
	logic tempOut;

	DFF_2 d0 (.clk, .reset, .D(~inputButton), .Q(tempOut));
	
	
	enum logic [1:0]{off = 2'b00, semi= 2'b01, on = 2'b11} ps, ns;

	always_comb begin
		case (ps)
			off:
				if(tempOut)	begin											ns = semi;
				end else begin												ns = off;
				end 
			
			semi:
				if(tempOut)	begin											ns = semi;
				end else begin												ns = on;
				end
			on:
				begin															ns = off;
				end	
				
			//default: ns = off;
		endcase
	end
	
	assign out = (ps == on);
   
	always_ff @(posedge clk) begin
		if (reset)				ps <= off;						
		else 		 				ps <= ns;						
	end
endmodule