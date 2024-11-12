module seven_seg_decoder(x0, x1, x2, x3, A, B, C, D, E, F, G);
	
	input x0, x1, x2, x3;
	output A, B, C, D, E, F, G;
	reg A, B, C, D, E, F, G;
	
	always@(x3, x2, x1, x0)
	begin
		case({x3, x2, x1, x0})
				4'b0000: {A,B,C,D,E,F,G}=7'b0000001;//0
				4'b0001: {A,B,C,D,E,F,G}=7'b1001111;//1
				4'b0010: {A,B,C,D,E,F,G}=7'b0010010;//2
				4'b0011: {A,B,C,D,E,F,G}=7'b0000110;//3
				4'b0100: {A,B,C,D,E,F,G}=7'b1001100;//4
				4'b0101: {A,B,C,D,E,F,G}=7'b0100100;//5
				4'b0110: {A,B,C,D,E,F,G}=7'b0100000;//6
				4'b0111: {A,B,C,D,E,F,G}=7'b0001111;//7
				4'b1000: {A,B,C,D,E,F,G}=7'b0000000;//8
				4'b1001: {A,B,C,D,E,F,G}=7'b0000100;//9
				4'b1010: {A,B,C,D,E,F,G}=7'b0000100;//10 but shows 9
				4'b1011: {A,B,C,D,E,F,G}=7'b0000100;//11 but shows 9
				4'b1100: {A,B,C,D,E,F,G}=7'b0000100;//12 but shows 9
				4'b1101: {A,B,C,D,E,F,G}=7'b0000100;//13 but shows 9
				4'b1110: {A,B,C,D,E,F,G}=7'b0000100;//14 but shows 9
				4'b1111: {A,B,C,D,E,F,G}=7'b0000100;//15 but shows 9
		endcase
	end
endmodule
		