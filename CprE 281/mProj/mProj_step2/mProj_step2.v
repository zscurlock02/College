module mProj_step2(W,X,Y,Z,P);
	input W,X,Y,Z;
	output P;
	
	assign P = (X&~Y&Z) | (~W&X&Z) | (~X&Y&Z) | (~W&~X&Y);
	
endmodule