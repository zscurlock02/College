module Conditionals(x, z);
	input x;
	output reg z;
	
	always @(x)
	if(x > 4'b1001)
		z = 4'b1001;
		
endmodule
