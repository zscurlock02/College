module lab3step1(A,C,G,W);
	input C,G,W;
	output A;
	
	not(Z, C);
	not(X, W);
	not(Y, G);
	
	or(Q,Z,G,X);
	or(R,C,Y,W);
	
	and(A,R,Q);
	
endmodule
	
	
	