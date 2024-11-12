module B_to_D_HundredsPlace(x0,x1,x2,x3,x4,x5,x6,x7,A,B,C,D,E,F,G);

	input x0,x1,x2,x3,x4,x5,x6,x7;
	output A,B,C,D,E,F,G;
	reg A,B,C,D,E,F,G;
	
	always@(x7,x6,x5,x4,x3,x2,x1,x0)
	begin
		case({x7,x6,x5,x4,x3,x2,x1,x0})
			8'b00000000:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00000001:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00000010:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00000011:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00000100:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00000101:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00000110:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00000111:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00001000:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00001001:{A,B,C,D,E,F,G}=7'b0000001;
         
         8'b00001010:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00001011:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00001100:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00001101:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00001110:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00001111:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00010000:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00010001:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00010010:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00010011:{A,B,C,D,E,F,G}=7'b0000001;
         
         8'b00010100:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00010101:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00010110:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00010111:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00011000:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00011001:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00011010:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00011011:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00011100:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00011101:{A,B,C,D,E,F,G}=7'b0000001;
         
         8'b00011110:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00011111:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00100000:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00100001:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00100010:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00100011:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00100100:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00100101:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00100110:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00100111:{A,B,C,D,E,F,G}=7'b0000001;
         
         8'b00101000:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00101001:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00101010:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00101011:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00101100:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00101101:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00101110:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00101111:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00110000:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00110001:{A,B,C,D,E,F,G}=7'b0000001;
         
         8'b00110010:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00110011:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00110100:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00110101:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00110110:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00110111:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00111000:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00111001:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00111010:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00111011:{A,B,C,D,E,F,G}=7'b0000001;
         
         8'b00111100:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00111101:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00111110:{A,B,C,D,E,F,G}=7'b0000001;
         8'b00111111:{A,B,C,D,E,F,G}=7'b0000001;
         8'b01000000:{A,B,C,D,E,F,G}=7'b0000001;
         8'b01000001:{A,B,C,D,E,F,G}=7'b0000001;
         8'b01000010:{A,B,C,D,E,F,G}=7'b0000001;
         8'b01000011:{A,B,C,D,E,F,G}=7'b0000001;
         8'b01000100:{A,B,C,D,E,F,G}=7'b0000001;
         8'b01000101:{A,B,C,D,E,F,G}=7'b0000001;
         
         8'b01000110:{A,B,C,D,E,F,G}=7'b0000001;
         8'b01000111:{A,B,C,D,E,F,G}=7'b0000001;
         8'b01001000:{A,B,C,D,E,F,G}=7'b0000001;
         8'b01001001:{A,B,C,D,E,F,G}=7'b0000001;
         8'b01001010:{A,B,C,D,E,F,G}=7'b0000001;
         8'b01001011:{A,B,C,D,E,F,G}=7'b0000001;
         8'b01001100:{A,B,C,D,E,F,G}=7'b0000001;
         8'b01001101:{A,B,C,D,E,F,G}=7'b0000001;
         8'b01001110:{A,B,C,D,E,F,G}=7'b0000001;
         8'b01001111:{A,B,C,D,E,F,G}=7'b0000001;
         
         8'b01010000:{A,B,C,D,E,F,G}=7'b0000001;
         8'b01010001:{A,B,C,D,E,F,G}=7'b0000001;
         8'b01010010:{A,B,C,D,E,F,G}=7'b0000001;
         8'b01010011:{A,B,C,D,E,F,G}=7'b0000001;
         8'b01010100:{A,B,C,D,E,F,G}=7'b0000001;
         8'b01010101:{A,B,C,D,E,F,G}=7'b0000001;
         8'b01010110:{A,B,C,D,E,F,G}=7'b0000001;
         8'b01010111:{A,B,C,D,E,F,G}=7'b0000001;
         8'b01011000:{A,B,C,D,E,F,G}=7'b0000001;
         8'b01011001:{A,B,C,D,E,F,G}=7'b0000001;
         
         8'b01011010:{A,B,C,D,E,F,G}=7'b0000001;
         8'b01011011:{A,B,C,D,E,F,G}=7'b0000001;
         8'b01011100:{A,B,C,D,E,F,G}=7'b0000001;
         8'b01011101:{A,B,C,D,E,F,G}=7'b0000001;
         8'b01011110:{A,B,C,D,E,F,G}=7'b0000001;
         8'b01011111:{A,B,C,D,E,F,G}=7'b0000001;	//90-99
         8'b01100000:{A,B,C,D,E,F,G}=7'b0000001;
         8'b01100001:{A,B,C,D,E,F,G}=7'b0000001;
         8'b01100010:{A,B,C,D,E,F,G}=7'b0000001;
         8'b01100011:{A,B,C,D,E,F,G}=7'b0000001;
         
         8'b01100100:{A,B,C,D,E,F,G}=7'b1001111;
         8'b01100101:{A,B,C,D,E,F,G}=7'b1001111;
         8'b01100110:{A,B,C,D,E,F,G}=7'b1001111;
         8'b01100111:{A,B,C,D,E,F,G}=7'b1001111;
         8'b01101000:{A,B,C,D,E,F,G}=7'b1001111;
         8'b01101001:{A,B,C,D,E,F,G}=7'b1001111;	//100-109
         8'b01101010:{A,B,C,D,E,F,G}=7'b1001111;
         8'b01101011:{A,B,C,D,E,F,G}=7'b1001111;
         8'b01101100:{A,B,C,D,E,F,G}=7'b1001111;
         8'b01101101:{A,B,C,D,E,F,G}=7'b1001111;
         
         8'b01101110:{A,B,C,D,E,F,G}=7'b1001111;
         8'b01101111:{A,B,C,D,E,F,G}=7'b1001111;
         8'b01110000:{A,B,C,D,E,F,G}=7'b1001111;
         8'b01110001:{A,B,C,D,E,F,G}=7'b1001111;
         8'b01110010:{A,B,C,D,E,F,G}=7'b1001111;
         8'b01110011:{A,B,C,D,E,F,G}=7'b1001111;
         8'b01110100:{A,B,C,D,E,F,G}=7'b1001111;
         8'b01110101:{A,B,C,D,E,F,G}=7'b1001111;
         8'b01110110:{A,B,C,D,E,F,G}=7'b1001111;
         8'b01110111:{A,B,C,D,E,F,G}=7'b1001111;
         
         8'b01111000:{A,B,C,D,E,F,G}=7'b1001111;
         8'b01111001:{A,B,C,D,E,F,G}=7'b1001111;
         8'b01111010:{A,B,C,D,E,F,G}=7'b1001111;
         8'b01111011:{A,B,C,D,E,F,G}=7'b1001111;
         8'b01111100:{A,B,C,D,E,F,G}=7'b1001111;
         8'b01111101:{A,B,C,D,E,F,G}=7'b1001111;
         8'b01111110:{A,B,C,D,E,F,G}=7'b1001111;
         8'b01111111:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10000000:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10000001:{A,B,C,D,E,F,G}=7'b1001111;
         
         8'b10000010:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10000011:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10000100:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10000101:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10000110:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10000111:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10001000:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10001001:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10001010:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10001011:{A,B,C,D,E,F,G}=7'b1001111;
         
         8'b10001100:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10001101:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10001110:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10001111:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10010000:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10010001:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10010010:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10010011:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10010100:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10010101:{A,B,C,D,E,F,G}=7'b1001111;
         
         8'b10010110:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10010111:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10011000:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10011001:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10011010:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10011011:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10011100:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10011101:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10011110:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10011111:{A,B,C,D,E,F,G}=7'b1001111;
         
         8'b10100000:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10100001:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10100010:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10100011:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10100100:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10100101:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10100110:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10100111:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10101000:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10101001:{A,B,C,D,E,F,G}=7'b1001111;
         
         8'b10101010:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10101011:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10101100:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10101101:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10101110:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10101111:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10110000:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10110001:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10110010:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10110011:{A,B,C,D,E,F,G}=7'b1001111;
         
         8'b10110100:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10110101:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10110110:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10110111:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10111000:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10111001:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10111010:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10111011:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10111100:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10111101:{A,B,C,D,E,F,G}=7'b1001111;
         
         8'b10111110:{A,B,C,D,E,F,G}=7'b1001111;
         8'b10111111:{A,B,C,D,E,F,G}=7'b1001111;
         8'b11000000:{A,B,C,D,E,F,G}=7'b1001111;
         8'b11000001:{A,B,C,D,E,F,G}=7'b1001111;
         8'b11000010:{A,B,C,D,E,F,G}=7'b1001111;
         8'b11000011:{A,B,C,D,E,F,G}=7'b1001111;	//190-199
         8'b11000100:{A,B,C,D,E,F,G}=7'b1001111;
         8'b11000101:{A,B,C,D,E,F,G}=7'b1001111;
         8'b11000110:{A,B,C,D,E,F,G}=7'b1001111;
         8'b11000111:{A,B,C,D,E,F,G}=7'b1001111;
         
         8'b11001000:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11001001:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11001010:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11001011:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11001100:{A,B,C,D,E,F,G}=7'b0010010;	//200-209
         8'b11001101:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11001110:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11001111:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11010000:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11010001:{A,B,C,D,E,F,G}=7'b0010010;
         
         8'b11010010:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11010011:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11010100:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11010101:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11010110:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11010111:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11011000:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11011001:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11011010:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11011011:{A,B,C,D,E,F,G}=7'b0010010;
         
         8'b11011100:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11011101:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11011110:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11011111:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11100000:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11100001:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11100010:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11100011:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11100100:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11100101:{A,B,C,D,E,F,G}=7'b0010010;
         
         8'b11100110:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11100111:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11101000:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11101001:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11101010:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11101011:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11101100:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11101101:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11101110:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11101111:{A,B,C,D,E,F,G}=7'b0010010;
         
         8'b11110000:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11110001:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11110010:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11110011:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11110100:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11110101:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11110110:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11110111:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11111000:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11111001:{A,B,C,D,E,F,G}=7'b0010010;
         
         8'b11111010:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11111011:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11111100:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11111101:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11111110:{A,B,C,D,E,F,G}=7'b0010010;
         8'b11111111:{A,B,C,D,E,F,G}=7'b0010010;
		endcase
	end
endmodule