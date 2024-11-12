module FA(Cin, X, Y, S, Cout);
	input Cin, X, Y;
	output S, Cout;
	
	assign S = (~X & ~Y & Cin) | (~X & Y & ~Cin) | (X & Y & Cin) | (X & ~Y & ~Cin);
	assign Cout = (X & Y) | (Y & Cin) | (X & Cin);
endmodule