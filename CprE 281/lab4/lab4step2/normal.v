
module normal
(
// {{ALTERA_ARGS_BEGIN}} DO NOT REMOVE THIS LINE!
P, T, H, E

);

// {{ALTERA_IO_BEGIN}} DO NOT REMOVE THIS LINE!
input P;
input T;
input H;
output E;
reg E;
// {{ALTERA_IO_END}} DO NOT REMOVE THIS LINE!

	always@(P or T or H)
	begin
	
		case({T,H,P})
		
			3'b000: E = 'b0;
			3'b001: E = 'b0;
			3'b010: E = 'b0;
			3'b011: E = 'b1;
			3'b100: E = 'b0;
			3'b101: E = 'b1;
			3'b110: E = 'b1;
			3'b111: E = 'b1;
		endcase
	end

endmodule
