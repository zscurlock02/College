module BinaryCodedDecimalConverter(C0,S3,S2,S1,S0,N1X0,N1X1,N1X2,N1X3,N2X0,N2X1,N2X2,N2X3);
	input C0,S1,S2,S3,S0;
	output N1X0,N1X1,N1X2,N1X3,N2X0,N2X1,N2X2,N2X3;
	
	assign N2X3 = 0;
	assign N2X2 = 0;
	assign N2X1 = (C0&S2)|(C0&S3);
	assign N2X0 = (C0&~S3&~S2)|(~C0&S3&S1)|(~C0&S3&S2)|(S3&S2&S1);
	assign N1X3 = (~C0&S3&~S2&~S1)|(C0&~S3&~S2&S1)|(C0&S3&S2&~S1);
	assign N1X2 = (~C0&~S3&S2)|(C0&~S2&~S1)|(~C0&S2&S1)|(C0&S3&~S2);
	assign N1X1 = (C0&~S3&~S2&~S1)|(~C0&S3&S2&~S1)|(~C0&~S3&S1)|(~S3&S2&S1)|(C0&S3&~S2&S1);
	assign N1X0 = S0;
	
endmodule