module MULTIPLEXER
(
	// {{ALTERA_ARGS_BEGIN}} DO NOT REMOVE THIS LINE!
	M, E, F, AC
	// {{ALTERA_ARGS_END}} DO NOT REMOVE THIS LINE!
);
// Port Declaration

	// {{ALTERA_IO_BEGIN}} DO NOT REMOVE THIS LINE!
	input M;
	input E;
	input F;
	output AC;
	reg AC;
	// {{ALTERA_IO_END}} DO NOT REMOVE THIS LINE!

		always@(M or E or F)
		begin
			case({M,E,F})
			
				3'b000: AC = 'b0;
				3'b010: AC = 'b1;
				3'b011: AC = 'b1;
				3'b100: AC = 'b0;
				3'b110: AC = 'b0;
				3'b111: AC = 'b1;
		endcase
	end


endmodule
