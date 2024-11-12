module lab7step1(Cin, X, Y, S, Cout);
	input Cin, X, Y;
	output S, Cout;
	
	assign S = (~Cin&(X^Y))|(X&Y&Cin)|(~X&~Y&Cin);
	assign Cout = (Cin&(X^Y))|(X&Y&~Cin)|(X&Y&Cin);
	
endmodule