library IEEE;
use IEEE.std_logic_1164.all;

entity ALU is
	port(A : in std_logic_vector(31 downto 0);
	     B : in std_logic_vector(31 downto 0);
	     shamt : in std_logic_vector(4 downto 0);
	     ALUControl : in std_logic_vector(5 downto 0);
	     ALUOut : out std_logic_vector(31 downto 0);
	     zero : out std_logic;
	     ovf : out std_logic);
end ALU;

architecture structural of ALU is
	component ADD
		port(A : in std_logic_vector(31 downto 0);
	     	     B : in std_logic_vector(31 downto 0);
	     	     output : out std_logic_vector(31 downto 0);
	     	     ovf : out std_logic);
	end component;

	component ADDU
		port(A : in std_logic_vector(31 downto 0);
	     	     B : in std_logic_vector(31 downto 0);
	     	     output : out std_logic_vector(31 downto 0));
	end component;

	component SUB
		port(A : in std_logic_vector(31 downto 0);
	     	     B : in std_logic_vector(31 downto 0);
	     	     output : out std_logic_vector(31 downto 0);
	     	     ovf : out std_logic);
	end component;

	component SUBU
		port(A : in std_logic_vector(31 downto 0);
	     	     B : in std_logic_vector(31 downto 0);
	     	     output : out std_logic_vector(31 downto 0));
	end component;

	component AndG
		port(input1 : in std_logic_vector(31 downto 0);
	     	     input2 : in std_logic_vector(31 downto 0);
	     	     output : out std_logic_vector(31 downto 0));
	end component;

	component NorG
		port(input1 : in std_logic_vector(31 downto 0);
	     	     input2 : in std_logic_vector(31 downto 0);
	     	     output : out std_logic_vector(31 downto 0));
	end component;

	component XorG
		port(input1 : in std_logic_vector(31 downto 0);
	     	     input2 : in std_logic_vector(31 downto 0);
	     	     output : out std_logic_vector(31 downto 0));
	end component;

	component OrG
		port(input1 : in std_logic_vector(31 downto 0);
	     	     input2 : in std_logic_vector(31 downto 0);
	     	     output : out std_logic_vector(31 downto 0));
	end component;

	component SLT
		port(A : in std_logic_vector(31 downto 0);
	     	     B : in std_logic_vector(31 downto 0);
             	     SLT_result : out std_logic_vector(31 downto 0));
	end component;

	component Barrel_Shifter
		port(input	: in std_logic_vector(31 downto 0);
	     	     sType	: in std_logic_vector(1 downto 0);
	     	     shamt	: in std_logic_vector(4 downto 0);
	     	     output	: out std_logic_vector(31 downto 0));
	end component;

	component LUI
		port(A : in std_logic_vector(31 downto 0);
	     	     output : out std_logic_vector(31 downto 0));
	end component;

	component mux16t1_32bit		--32 bit
		port(i_D0 : in std_logic_vector(31 downto 0);
	     	     i_D1 : in std_logic_vector(31 downto 0);
	     	     i_D2 : in std_logic_vector(31 downto 0);
	     	     i_D3 : in std_logic_vector(31 downto 0);
	     	     i_D4 : in std_logic_vector(31 downto 0);
	     	     i_D5 : in std_logic_vector(31 downto 0);
	     	     i_D6 : in std_logic_vector(31 downto 0);
	     	     i_D7 : in std_logic_vector(31 downto 0);
	     	     i_D8 : in std_logic_vector(31 downto 0);
	     	     i_D9 : in std_logic_vector(31 downto 0);
	     	     i_D10 : in std_logic_vector(31 downto 0);
	     	     i_D11 : in std_logic_vector(31 downto 0);
	     	     i_D12 : in std_logic_vector(31 downto 0);
	     	     i_D13 : in std_logic_vector(31 downto 0);
	     	     i_D14 : in std_logic_vector(31 downto 0);
	     	     i_D15 : in std_logic_vector(31 downto 0);
	     	     i_S  : in std_logic_vector(3 downto 0);
	     	     o_O  : out std_logic_vector(31 downto 0));
	end component;

	component mux16t1	--1 bit
		port(i_D0 : in std_logic;
	     	     i_D1 : in std_logic;
	     	     i_D2 : in std_logic;
	     	     i_D3 : in std_logic;
	     	     i_D4 : in std_logic;
	     	     i_D5 : in std_logic;
	     	     i_D6 : in std_logic;
	     	     i_D7 : in std_logic;
	     	     i_D8 : in std_logic;
	    	     i_D9 : in std_logic;
	     	     i_D10 : in std_logic;
	    	     i_D11 : in std_logic;
	     	     i_D12 : in std_logic;
	     	     i_D13 : in std_logic;
	     	     i_D14 : in std_logic;
	     	     i_D15 : in std_logic;
	     	     i_S  : in std_logic_vector(3 downto 0);
	     	     o_O  : out std_logic);
	end component;

	--Signals
	signal AddOvf : std_logic;
	signal SubOvf : std_logic;
	signal MUXIn0 : std_logic_vector(31 downto 0);
	signal MUXIn1 : std_logic_vector(31 downto 0);
	signal MUXIn2 : std_logic_vector(31 downto 0);
	signal MUXIn3 : std_logic_vector(31 downto 0);
	signal MUXIn4 : std_logic_vector(31 downto 0);
	signal MUXIn5 : std_logic_vector(31 downto 0);
	signal MUXIn6 : std_logic_vector(31 downto 0);
	signal MUXIn7 : std_logic_vector(31 downto 0);
	signal MUXIn8 : std_logic_vector(31 downto 0);
	signal MUXIn9 : std_logic_vector(31 downto 0);
	signal MUXIn10 : std_logic_vector(31 downto 0);
	signal sType : std_logic_vector(1 downto 0);
	signal MUXSel : std_logic_vector(3 downto 0);
	signal s_ALUOut : std_logic_vector(31 downto 0);

begin

	sType <= ALUControl(1 downto 0);
	MUXSel <= ALUControl(5 downto 2);

	--ADD
	Adder: ADD
		port map(A => A,
			 B => B,
			 output => MUXIn0,
			 ovf => AddOvf);

	--ADDU
	AdderU: ADDU
		port map(A => A,
			 B => B,
			 output => MUXIn1);

	--SUB
	Subtractor: SUB
		port map(A => A,
			 B => B,
			 output => MUXIn2,
			 ovf => SubOvf);

	--SUBU
	SubtractorU: SUBU 
		port map(A => A,
			 B => B,
			 output => MUXIn3);

	--AND
	AndGate: AndG
		port map(input1 => A,
			 input2 => B,
			 output => MUXIn4);

	--NOR
	NorGate: NorG
		port map(input1 => A,
			 input2 => B,
			 output => MUXIn5);

	--XOR
	XorGate: XorG
		port map(input1 => A,
			 input2 => B,
			 output => MUXIn6);

	--OR
	OrGate: OrG
		port map(input1 => A,
			 input2 => B,
			 output => MUXIn7);

	--SLT
	SetLessThan: SLT
		port map(A => A,
			 B => B,
			 SLT_result => MUXIn8);

	--BarrelShifter
	BarrelShifter: Barrel_Shifter
		port map(input => B,
			 sType => sType,
			 shamt => shamt,
			 output => MUXIn9);

	--LUI
	LoadUpperImm: LUI
		port map(A => B,
			 output => MUXIn10);

	--32 Bit 16:1 MUX
	MUX1: mux16t1_32bit
		port map(i_D0 => MUXIn0,
	     		 i_D1 => MUXIn1,
	     		 i_D2 => MUXIn2,
	     		 i_D3 => MUXIn3,
	     		 i_D4 => MUXIn4,
	     		 i_D5 => MUXIn5,
	     		 i_D6 => MUXIn6,
	     		 i_D7 => MUXIn7,
	    		 i_D8 => MUXIn8,
	     		 i_D9 => MUXIn9,
	     		 i_D10 => MUXIn10,
	     		 i_D11 => x"00000000",
	     		 i_D12 => x"00000000",
	     		 i_D13 => x"00000000",
	    		 i_D14 => x"00000000",
	     		 i_D15 => x"00000000",
	     		 i_S => MUXSel, 
	     		 o_O => s_ALUOut);

	--1 Bit 16:1 MUX
	MUX2: mux16t1
		port map(i_D0 => AddOvf,
	     		 i_D1 => '0',
	     		 i_D2 => SubOvf,
	     		 i_D3 => '0',
	     		 i_D4 => '0',
	     		 i_D5 => '0',
	     		 i_D6 => '0',
	     		 i_D7 => '0',
	    		 i_D8 => '0',
	     		 i_D9 => '0',
	     		 i_D10 => '0',
	     		 i_D11 => '0',
	     		 i_D12 => '0',
	     		 i_D13 => '0',
	    		 i_D14 => '0',
	     		 i_D15 => '0',
	     		 i_S => MUXSel, 
	     		 o_O => ovf);

	--Set the zero output
	zero <= '1' when s_ALUOut = x"00000000" else '0';

	--Set ALUOut
	ALUOut <= s_ALUOut;

end structural;