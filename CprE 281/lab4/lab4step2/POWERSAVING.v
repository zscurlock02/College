

//  Module Declaration
module POWERSAVING
(
// {{ALTERA_ARGS_BEGIN}} DO NOT REMOVE THIS LINE!
T, H, P, F
// {{ALTERA_ARGS_END}} DO NOT REMOVE THIS LINE!
);
// Port Declaration

// {{ALTERA_IO_BEGIN}} DO NOT REMOVE THIS LINE!
input T;
input H;
input P;
output F;
reg F;
// {{ALTERA_IO_END}} DO NOT REMOVE THIS LINE!

	always@ (T or H or P)
	begin
	
		case({T,H,P})
		
			3'b000: F = 'b0;
			3'b001: F = 'b0;
			3'b010: F = 'b0;
			3'b011: F = 'b0;
			3'b100: F = 'b0;
			3'b101: F = 'b0;
			3'b110: F = 'b0;
			3'b111: F = 'b1;
		endcase
	end


endmodule
