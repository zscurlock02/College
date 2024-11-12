-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- MIPS_Processor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a skeleton of a MIPS_Processor  
-- implementation.

-- 01/29/2019 by H3::Design created.
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

library work;
use work.MIPS_types.all;

entity MIPS_Processor is
  generic(N : integer := DATA_WIDTH);
  port(iCLK            : in std_logic;
       iRST            : in std_logic;
       iInstLd         : in std_logic;
       iInstAddr       : in std_logic_vector(N-1 downto 0);
       iInstExt        : in std_logic_vector(N-1 downto 0);
       oALUOut         : out std_logic_vector(N-1 downto 0)); -- TODO: Hook this up to the output of the ALU. It is important for synthesis that you have this output that can effectively be impacted by all other components so they are not optimized away.

end  MIPS_Processor;

architecture structure of MIPS_Processor is

  -- Required data memory signals
  signal s_DMemWr       : std_logic; -- TODO: use this signal as the final active high data memory write enable signal
  signal s_DMemAddr     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory address input
  signal s_DMemData     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input
  signal s_DMemOut      : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the data memory output
 
  -- Required register file signals 
  signal s_RegWr        : std_logic; -- TODO: use this signal as the final active high write enable input to the register file
  signal s_RegWrAddr    : std_logic_vector(4 downto 0); -- TODO: use this signal as the final destination register address input
  signal s_RegWrData    : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input

  -- Required instruction memory signals
  signal s_IMemAddr     : std_logic_vector(N-1 downto 0); -- Do not assign this signal, assign to s_NextInstAddr instead
  signal s_NextInstAddr : std_logic_vector(N-1 downto 0); -- TODO: use this signal as your intended final instruction memory address input.
  signal s_Inst         : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the instruction signal 

  -- Required halt signal -- for simulation
  signal s_Halt         : std_logic;  -- TODO: this signal indicates to the simulation that intended program execution has completed. (Opcode: 01 0100)

  -- Required overflow signal -- for overflow exception detection
  signal s_Ovfl         : std_logic;  -- TODO: this signal indicates an overflow exception would have been initiated

  -- Custom Signals
  signal RegRead1	: std_logic_vector(31 downto 0);
  signal RegRead2	: std_logic_vector(31 downto 0);
  signal s_MuxOut1	: std_logic_vector(4 downto 0);
  signal s_ALUControl	: std_logic_vector(5 downto 0);
  signal s_ALUSrc	: std_logic;
  signal s_MemtoReg	: std_logic;
  signal s_MemRead	: std_logic;
  signal s_RegDst	: std_logic;
  signal s_Jal		: std_logic;
  signal s_Jr		: std_logic;
  signal s_Jump		: std_logic;
  signal s_Branch	: std_logic;
  signal s_SignExt	: std_logic;
  signal s_Bne		: std_logic;
  signal s_SignExtOut	: std_logic_vector(31 downto 0);
  signal s_ZeroExtOut	: std_logic_vector(31 downto 0);
  signal s_ImmExtended	: std_logic_vector(31 downto 0);
  signal s_ALUSrcOut	: std_logic_vector(31 downto 0);
  signal s_ALUOut	: std_logic_vector(31 downto 0);
  signal s_NewFetch	: std_logic_vector(31 downto 0);
  signal s_Zero		: std_logic;
  signal s_WriteBackData : std_logic_vector(31 downto 0);
  signal s_PCPlusFour	: std_logic_vector(31 downto 0);
  signal s_NewPC	: std_logic_vector(31 downto 0);
  signal s_JumpAddress  : std_logic_vector(31 downto 0);
  signal s_ImmSLL2	: std_logic_vector(31 downto 0);
  signal s_BranchAddress : std_logic_vector(31 downto 0);
  signal s_BranchControl : std_logic;
  signal s_BranchMuxOut : std_logic_vector(31 downto 0);
  signal s_ZeroNot	: std_logic;
  signal s_BranchSelOut : std_logic;
  signal s_JumpSelOut 	: std_logic_vector(31 downto 0);

  component mem is
    generic(ADDR_WIDTH : integer;
            DATA_WIDTH : integer);
    port(
          clk          : in std_logic;
          addr         : in std_logic_vector((ADDR_WIDTH-1) downto 0);
          data         : in std_logic_vector((DATA_WIDTH-1) downto 0);
          we           : in std_logic := '1';
          q            : out std_logic_vector((DATA_WIDTH -1) downto 0));
    end component;

  component ALU is
    port(
	  A		: in std_logic_vector(31 downto 0);
	  B		: in std_logic_vector(31 downto 0);
	  shamt		: in std_logic_vector(4 downto 0);
	  ALUControl	: in std_logic_vector(5 downto 0);
	  ALUOut	: out std_logic_vector(31 downto 0);
	  zero		: out std_logic;
	  ovf		: out std_logic);
   end component;

  component ControlUnit is
    port( funct 	: in std_logic_vector(5 downto 0);
	     OpCode 	: in std_logic_vector(5 downto 0);
	     ALUSrc 	: out std_logic;
	     ALUControl : out std_logic_vector(5 downto 0);
	     MemtoReg 	: out std_logic;
	     MemRead 	: out std_logic;
	     MemWrite 	: out std_logic;
	     RegWrite 	: out std_logic;
	     RegDst	: out std_logic;
	     Jal 	: out std_logic;
	     Jr 	: out std_logic;
	     Jump 	: out std_logic;
	     Branch 	: out std_logic;
	     SignExt 	: out std_logic;
	     Bne 	: out std_logic;
	     halt	: out std_logic);
    end component;

    component mux2t1 is
      port(i_D0		: in std_logic;
		i_D1	: in std_logic;
		i_S	: in std_logic;
		o_O	: out std_logic);
    end component;

    component mux2t1_N is
      generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
      port(i_S          : in std_logic;
           i_D0         : in std_logic_vector(N-1 downto 0);
           i_D1         : in std_logic_vector(N-1 downto 0);
           o_O          : out std_logic_vector(N-1 downto 0));
     end component;

     component andg2 is
       port(i_A          : in std_logic;
       	    i_B          : in std_logic;
       	    o_F          : out std_logic);
     end component;

     component invg is 
       port(i_A          : in std_logic;
            o_F          : out std_logic);
     end component;

     component Add4 is
       port(input : in std_logic_vector(31 downto 0);
	    output : out std_logic_vector(31 downto 0));
     end component;

     component Adder_32bits is
       port(A : in std_logic_vector(31 downto 0);
	    B : in std_logic_vector(31 downto 0);
	    output : out std_logic_vector(31 downto 0));
     end component;

     component SignExtender is
       port(input16 : in std_logic_vector(15 downto 0);
	    output32 : out std_logic_vector(31 downto 0));
     end component;

     component SLL2_32bits is
       port(input : in std_logic_vector(31 downto 0);
	    output : out std_logic_vector(31 downto 0));
     end component;

     component ZeroExtender is 
       port(input16 : in std_logic_vector(15 downto 0);
	    output32 : out std_logic_vector(31 downto 0));
     end component;

     component RegFile is 
       port (i_CLK 	 : in std_logic;
	      i_RST 	 : in std_logic;
	      write_en   : in std_logic;
	      read_sel1  : in std_logic_vector(4 downto 0);
	      read_sel2  : in std_logic_vector(4 downto 0);
	      write_sel  : in std_logic_vector(4 downto 0);
	      write_data : in std_logic_vector(31 downto 0);
	      read_data1 : out std_logic_vector(31 downto 0);
	      read_data2 : out std_logic_vector(31 downto 0));
     end component;

     component Reg_N is
       generic(N : integer := 32);
	port(write_data 	: in std_logic_vector(N-1 downto 0);
		write_en 	: in std_logic;
		i_CLK 		: in std_logic;
		i_RST 		: in std_logic;
		read_data 	: out std_logic_vector(N-1 downto 0));
     end component;
begin

  -- TODO: This is required to be your final input to your instruction memory. This provides a feasible method to externally load the memory module which means that the synthesis tool must assume it knows nothing about the values stored in the instruction memory. If this is not included, much, if not all of the design is optimized out because the synthesis tool will believe the memory to be all zeros.
  with iInstLd select
    s_IMemAddr <= s_NextInstAddr when '0',
      iInstAddr when others;


  IMem: mem
    generic map(ADDR_WIDTH => ADDR_WIDTH,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_IMemAddr(11 downto 2),
             data => iInstExt,
             we   => iInstLd,
             q    => s_Inst);
  
  DMem: mem
    generic map(ADDR_WIDTH => ADDR_WIDTH,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_DMemAddr(11 downto 2),
             data => s_DMemData,
             we   => s_DMemWr,
             q    => s_DMemOut);

  RegisterFile: RegFile
	port map(i_CLK		=> iCLK,
		 i_RST  	=> iRST,
		 write_en	=> s_RegWr,
		 read_sel1	=> s_Inst(25 downto 21),
		 read_sel2	=> s_Inst(20 downto 16),
		 write_sel	=> s_RegWrAddr,
		 write_data	=> s_RegWrData,
		 read_data1	=> RegRead1,
		 read_data2	=> RegRead2);

   MuxWriteReg1: mux2t1_N
	generic map(N => 5)
	port map(i_S		=> s_RegDst,
		 i_D0		=> s_Inst(20 downto 16),
		 i_D1		=> s_Inst(15 downto 11),
		 o_O		=> s_MuxOut1);

   MuxWriteReg2: mux2t1_N
	generic map(N => 5)
	port map(i_S		=> s_Jal,
		 i_D0		=> s_MuxOut1,
		 i_D1		=> "11111",
		 o_O		=> s_RegWrAddr);

   Cunit: ControlUnit
	port map(funct		=> s_Inst(5 downto 0),
		 OpCode		=> s_Inst(31 downto 26),
		 ALUSrc		=> s_ALUSrc,
		 ALUControl	=> s_ALUControl,
		 MemtoReg	=> s_MemtoReg, 
		 MemRead	=> s_MemRead,
		 MemWrite	=> s_DMemWr,
		 RegWrite	=> s_RegWr,
		 RegDst		=> s_RegDst,
		 Jal		=> s_Jal,
		 Jr		=> s_Jr,
		 Jump		=> s_Jump,
		 Branch		=> s_Branch,
		 SignExt	=> s_SignExt,
		 Bne		=> s_Bne,
		 halt		=> s_Halt);

   SignExt: SignExtender
	port map(input16 => s_Inst(15 downto 0),
		 output32 => s_SignExtOut);

   ZeroExt: ZeroExtender
	port map(input16 => s_Inst(15 downto 0),
		 output32 => s_ZeroExtOut);

   MuxSignExt: mux2t1_N
	generic map(N => 32)
	port map(i_S => s_SignExt,
		 i_D0 => s_ZeroExtOut,
		 i_D1 => s_SignExtOut,
		 o_O => s_ImmExtended);

   MuxReadOut: mux2t1_N
	generic map(N => 32)
	port map(i_S => s_ALUSrc,
		 i_D0 => RegRead2,
		 i_D1 => s_ImmExtended,
		 o_O => s_ALUSrcOut);

   ArithmeticLogicUnit: ALU
	port map(A		=> RegRead1,
	    	 B		=> s_ALUSrcOut,
	    	 shamt		=> s_Inst(10 downto 6),
	    	 ALUControl	=> s_ALUControl,
	    	 ALUOut		=> s_ALUOut,
	    	 zero		=> s_Zero,
	    	 ovf		=> s_Ovfl);

   oALUOut <= s_ALUOut;
   s_DMemAddr <= s_ALUOut;
   s_DMemData <= RegRead2;

   MuxMemOrAlu: mux2t1_N
	generic map(N => 32)
	port map(i_S => s_MemtoReg,
		 i_D0 => s_ALUOut,
		 i_D1 => s_DMemOut,
		 o_O => s_WriteBackData);

   MuxWriteData: mux2t1_N
	generic map(N => 32)
	port map(i_S => s_Jal,
		 i_D0 => s_WriteBackData,
		 i_D1 => s_PCPlusFour,
		 o_O => s_RegWrData);

   MuxNewPCVal: mux2t1_N
	generic map(N => 32)
	port map(i_S => iRST,
		 i_D0 => s_NewFetch, -- MAKE NEW SIG
		 i_D1 => x"00400000",
		 o_O => s_NewPC);

   PC: Reg_N
	generic map(N => 32)
	port map(write_data => s_NewPC,
		 write_en => '1',
		 i_CLK => iCLK,
		 i_RST => '0',
		 read_data => s_NextInstAddr);

   PCFourAdder: Add4
	port map(input => s_NextInstAddr,
		 output => s_PCPlusFour);

   s_JumpAddress <= s_PCPlusFour(31 downto 28) & s_Inst(25 downto 0) & "00";

   BranchAddressShifter: SLL2_32bits
	port map(input => s_ImmExtended,
		 output => s_ImmSLL2);

   BranchAddressAdder: Adder_32bits
	port map(A => s_PCPlusFour,
		 B => s_ImmSLL2,
		 output => s_BranchAddress);

   MuxBranch: mux2t1_N
	generic map(N => 32)
	port map(i_S => s_BranchControl,
		 i_D0 => s_PCPlusFour,
		 i_D1 => s_BranchAddress,
		 o_O => s_BranchMuxOut);

   NotG: invg
	port map(i_A => s_Zero,
		 o_F => s_ZeroNot);

   MuxBranchSel: mux2t1
	port map(i_D0 => s_Zero,
		 i_D1 => s_ZeroNot,
		 i_S => s_Bne,
		 o_O => s_BranchSelOut);

   AndGate: andg2
	port map(i_A => s_Branch,
		 i_B => s_BranchSelOut,
		 o_F => s_BranchControl);

   MuxJumpSel: mux2t1_N
	generic map(N => 32)
	port map(i_S => s_Jump,
		 i_D0 => s_BranchMuxOut,
		 i_D1 => s_JumpAddress,
		 o_O => s_JumpSelOut);

   MuxJrSel: mux2t1_N
	generic map(N => 32)
	port map(i_S => s_Jr,
		 i_D0 => s_JumpSelOut,
		 i_D1 => RegRead1,
		 o_O => s_NewFetch);

end structure;

