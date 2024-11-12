module Conitionals(x, z);
	input [4:0] x;
	output reg z;
	
	always @(x)
	if(x > 4'b1001)
		z = 4'b1001;
		
endmodule
