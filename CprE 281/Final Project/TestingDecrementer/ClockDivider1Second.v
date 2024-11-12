module ClockDivider1Second(clock_in, sevenSegment);
	input clock_in;
	output sevenSegment;
	
	reg[25:0] count = 0;
	reg clock_out;
	
	always @(posedge clock_in)
	begin
	count <= count + 1;
	if(count == 50_000_000)
	begin
	count <= 0;
	clock_out = -clock_out;
	end
	end
	
	assign sevenSegment = clock_out;
	
endmodule