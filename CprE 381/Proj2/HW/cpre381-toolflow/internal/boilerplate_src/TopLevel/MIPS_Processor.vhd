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
  signal s_NewPC	: std_logic_vector(31 downto 0);
  signal s_PCPlusFour	: std_logic_vector(31 downto 0);
  signal s_IFIDinput	: std_logic_vector(63 downto 0);
  signal s_IFIDoutput	: std_logic_vector(63 downto 0);
  signal s_DINST	: std_logic_vector(31 downto 0);
  signal s_DPCPlusFour	: std_logic_vector(31 downto 0);
  signal s_RegRead1	: std_logic_vector(31 downto 0);
  signal s_RegRead2	: std_logic_vector(31 downto 0);
  signal s_ALUSrc	: std_logic;
  signal s_ALUControl	: std_logic_vector(5 downto 0);
  signal s_MemtoReg	: std_logic;
  signal s_MemRead	: std_logic;
  signal s_RegDst	: std_logic;
  signal s_Jal		: std_logic;
  signal s_Jr		: std_logic;
  signal s_Jump		: std_logic;
  signal s_Branch	: std_logic;
  signal s_SignExt	: std_logic;
  signal s_Bne		: std_logic;
  signal s_Halt1	: std_logic;
  signal s_JumpAddress	: std_logic_vector(31 downto 0);
  signal s_BranchAddressAdderInput	: std_logic_vector(31 downto 0);
  signal s_BranchAddress	: std_logic_vector(31 downto 0);
  signal s_BranchCheckOut	: std_logic;
  signal s_BranchSel	: std_logic;
  signal s_BranchMuxOut	: std_logic_vector(31 downto 0);
  signal s_JumpMuxOut	: std_logic_vector(31 downto 0);
  signal s_JrMuxOut	: std_logic_vector(31 downto 0);
  signal s_BranchOrJump	: std_logic;
  signal s_PCWriteBackMuxOut	: std_logic_vector(31 downto 0);
  signal s_SignExtOut	: std_logic_vector(31 downto 0);
  signal s_ZeroExtOut	: std_logic_vector(31 downto 0);
  signal s_ImmExtended	: std_logic_vector(31 downto 0);
  signal s_IDEXinput	: std_logic_vector(161 downto 0);
  signal s_IDEXoutput	: std_logic_vector(161 downto 0);
  signal s_ALUInput	: std_logic_vector(31 downto 0);
  signal s_ALUOut	: std_logic_vector(31 downto 0);
  signal s_Ovf		: std_logic;
  signal s_EXDMinput	: std_logic_vector(113 downto 0);
  signal s_EXDMoutput	: std_logic_vector(113 downto 0);
  signal s_DMWBinput	: std_logic_vector(111 downto 0);
  signal s_DMWBoutput	: std_logic_vector(111 downto 0);
  signal s_MemOrRegOut	: std_logic_vector(31 downto 0);
  signal s_RegSelOut	: std_logic_vector(4 downto 0);
  signal s_RegWr1	: std_logic;
  signal s_MemWrite	: std_logic;
  signal s_FwdSel1	: std_logic;
  signal s_FwdSel2	: std_logic;
  signal s_ForwardReg1	: std_logic_vector(31 downto 0);
  signal s_ForwardReg2	: std_logic_vector(31 downto 0);
  signal s_WriteAddr	: std_logic_vector(4 downto 0);
  signal s_Stall	: std_logic;
  signal s_StallOrInst	: std_logic_vector(31 downto 0);
  signal s_NotStall	: std_logic;

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
      generic(N : integer := 32);
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

     component org2 is
	port(i_A	: in std_logic;
	     i_B	: in std_logic;
	     o_F	: out std_logic);
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

     component BranchChecker is
	port(A : in std_logic_vector(31 downto 0);
	     B : in std_logic_vector(31 downto 0);
	     bne: in std_logic;
	     output : out std_logic);
     end component;

     component ForwardingUnit is
	port(ReadAddr1	: in std_logic_vector(4 downto 0);
	     ReadAddr2	: in std_logic_vector(4 downto 0);
	     WriteAddr	: in std_logic_vector(4 downto 0);
	     WriteEnable : in std_logic;
	     FwdSel1	: out std_logic;
	     FwdSel2	: out std_logic);
     end component;

     component HazardDetector is
	port(Jump		: in std_logic;
	     Branch		: in std_logic;
	     Jal_ID		: in std_logic;
	     Jal_EX		: in std_logic;
	     Jal_MEM		: in std_logic;
	     ReadAddr1		: in std_logic_vector(4 downto 0);
	     ReadAddr2		: in std_logic_vector(4 downto 0);
	     WriteAddr_ID	: in std_logic_vector(4 downto 0);
	     WriteAddr_EX	: in std_logic_vector(4 downto 0);
	     WriteEn_ID		: in std_logic;
	     WriteEn_EX		: in std_logic;
	     stall		: out std_logic);
     end component;

begin

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

   PC: Reg_N
	generic map(N => 32)
	port map(write_data => s_NewPC,
		 write_en => s_NotStall,
		 i_CLK => iCLK,
		 i_RST => '0',
		 read_data => s_NextInstAddr);

   PCFourAdder: Add4
	port map(input => s_NextInstAddr,
		 output => s_PCPlusFour);

   HazardUnit: HazardDetector
	port map(Jump	=> s_Jump,
		 Branch	=> s_Branch,
		 Jal_ID	=> s_Jal,
		 Jal_EX	=> s_IDEXoutput(156),
		 Jal_MEM => s_EXDMoutput(113),
		 ReadAddr1 => s_Inst(25 downto 21),
		 ReadAddr2 => s_Inst(20 downto 16),
		 WriteAddr_ID => s_WriteAddr, 
		 WriteAddr_EX => s_IDEXoutput(161 downto 157),
		 WriteEn_ID   => s_RegWr1,
		 WriteEn_EX   => s_IDEXoutput(117),
		 stall	      => s_Stall); 

   StallMux: mux2t1_N
	generic map(N => 32)
	port map(i_S => s_Stall,
		 i_D0 => s_Inst,
		 i_D1 => x"00000000",
		 o_O => s_StallOrInst); 

   s_NotStall <= '0' when s_Stall = '1' else '1';
--------------------------------------------------------------------------------------------------------
   IFID: Reg_N
	generic map(N => 64)
	port map(write_data => s_IFIDinput,
		 write_en => '1',
		 i_CLK => iCLK,
		 i_RST => iRST,
		 read_data => s_IFIDoutput);

   s_IFIDinput <= s_PCPLusFour & s_StallOrInst;
   
   s_DINST <= s_IFIDoutput(31 downto 0);
   s_DPCPlusFour <= s_IFIDoutput(63 downto 32); 

   RegisterFile: RegFile
	port map(i_CLK		=> iCLK,
		 i_RST  	=> iRST,
		 write_en	=> s_RegWr,
		 read_sel1	=> s_DINST(25 downto 21),
		 read_sel2	=> s_DINST(20 downto 16),
		 write_sel	=> s_RegWrAddr,
		 write_data	=> s_RegWrData,
		 read_data1	=> s_RegRead1, 
		 read_data2	=> s_RegRead2); 

   FowardMux1: mux2t1_N
	generic map(N => 32)
	port map(i_S => s_FwdSel1, 
		 i_D0 => s_RegRead1,
		 i_D1 => s_RegWrData,
		 o_O => s_ForwardReg1); 

   FowardMux2: mux2t1_N
	generic map(N => 32)
	port map(i_S => s_FwdSel2,
		 i_D0 => s_RegRead2,
		 i_D1 => s_RegWrData,
		 o_O => s_ForwardReg2); 

   Cunit: ControlUnit
	port map(funct		=> s_DINST(5 downto 0),
		 OpCode		=> s_DINST(31 downto 26),
		 ALUSrc		=> s_ALUSrc,
		 ALUControl	=> s_ALUControl,
		 MemtoReg	=> s_MemtoReg, 
		 MemRead	=> s_MemRead,
		 MemWrite	=> s_MemWrite,
		 RegWrite	=> s_RegWr1, 	
		 RegDst		=> s_RegDst,
		 Jal		=> s_Jal,
		 Jr		=> s_Jr,
		 Jump		=> s_Jump,
		 Branch		=> s_Branch,
		 SignExt	=> s_SignExt,
		 Bne		=> s_Bne,
		 halt		=> s_Halt1);

   s_JumpAddress <= s_DPCPlusFour(31 downto 28) & s_DINST(25 downto 0) & "00"; 
   s_BranchAddressAdderInput <= "00000000000000" & s_DINST(15 downto 0) & "00" when s_DINST(15) = '0' else 
		      		"11111111111111" & s_DINST(15 downto 0) & "00" when s_DINST(15) = '1';

   BranchAddressAdder: Adder_32bits
	port map(A => s_DPCPlusFour,
		 B => s_BranchAddressAdderInput,
		 output => s_BranchAddress);

   BranchChkr: BranchChecker
	port map(A => s_RegRead1,
		 B => s_RegRead2,
		 bne => s_Bne,
		 output => s_BranchCheckOut); 

   AndGate: andg2
	port map(i_A => s_Branch,
		 i_B => s_BranchCheckOut,
		 o_F => s_BranchSel); 
  
   MuxBranch: mux2t1_N
	generic map(N => 32)
	port map(i_S => s_BranchSel,
		 i_D0 => s_DPCPlusFour,
		 i_D1 => s_BranchAddress,
		 o_O => s_BranchMuxOut); 

   MuxJump: mux2t1_N
	generic map(N => 32)
	port map(i_S => s_Jump,
		 i_D0 => s_BranchMuxOut,
		 i_D1 => s_JumpAddress,
		 o_O => s_JumpMuxOut);

   MuxJr: mux2t1_N
	generic map(N => 32)
	port map(i_S => s_Jr,
		 i_D0 => s_JumpMuxOut,
		 i_D1 => s_RegRead1,
		 o_O => s_JrMuxOut); 

   OrGate: org2
	port map(i_A => s_Branch,
		 i_B => s_Jump,
		 o_F => s_BranchOrJump); 

   MuxPCWriteBack: mux2t1_N
	generic map(N => 32)
	port map(i_S => s_BranchOrJump,
		 i_D0 => s_PCPlusFour,
		 i_D1 => s_JrMuxOut,
		 o_O => s_PCWriteBackMuxOut);

   MuxReset: mux2t1_N
	generic map(N => 32)
	port map(i_S => iRST,
		 i_D0 => s_PCWriteBackMuxOut,
		 i_D1 => x"00400000",
		 o_O => s_NewPC); 

   SignExt: SignExtender
	port map(input16 => s_DINST(15 downto 0),
		 output32 => s_SignExtOut);
   ZeroExt: ZeroExtender
	port map(input16 => s_DINST(15 downto 0),
		 output32 => s_ZeroExtOut);  

   MuxSignExt: mux2t1_N
	generic map(N => 32)
	port map(i_S => s_SignExt,
		 i_D0 => s_ZeroExtOut,
		 i_D1 => s_SignExtOut,
		 o_O => s_ImmExtended);

   WriteAddrMux: mux2t1_N
	generic map(N => 5)
	port map(i_S => s_RegDst,
		 i_D0 => s_DINST(20 downto 16),
		 i_D1 => s_DINST(15 downto 11),
		 o_O  => s_WriteAddr);

   ForwardUnit: ForwardingUnit 
	port map(ReadAddr1 => s_DINST(25 downto 21),
		 ReadAddr2 => s_DINST(20 downto 16),
		 WriteAddr => s_RegWrAddr,
		 WriteEnable => s_RegWr,
		 FwdSel1 => s_FwdSel1,
		 FwdSel2 => s_FwdSel2);
--------------------------------------------------------------------------------------------------------

   s_IDEXinput <= s_WriteAddr & s_Jal & s_DPCPlusFour & s_DINST(10 downto 6) & s_Halt1 & s_RegWr1 & s_RegDst & s_MemtoReg & s_MemRead & s_MemWrite & s_ALUSrc & s_ALUControl & s_DINST(15 downto 11) & s_DINST(20 downto 16) & s_ImmExtended & s_ForwardReg2 & s_ForwardReg1;

   IDEX: Reg_N
	generic map(N => 162)
	port map(write_data => s_IDEXinput,
		 write_en => '1',
		 i_CLK => iCLK,
		 i_RST => iRST,
		 read_data => s_IDEXoutput); 

   MuxALUSel: mux2t1_N
	generic map(N => 32)
	port map(i_S => s_IDEXoutput(112),
		 i_D0 => s_IDEXoutput(63 downto 32),
		 i_D1 => s_IDEXoutput(95 downto 64),
		 o_O => s_ALUInput);

   ArithmeticLogicUnit: ALU
	port map(A		=> s_IDEXoutput(31 downto 0),
	    	 B		=> s_ALUInput,
	    	 shamt		=> s_IDEXoutput(123 downto 119),
	    	 ALUControl	=> s_IDEXoutput(111 downto 106),
	    	 ALUOut		=> s_ALUOut, 
	    	 zero		=> open,
	    	 ovf		=> s_Ovf);

   oALUout <= s_ALUOut;
--------------------------------------------------------------------------------------------------------
   s_EXDMinput <= s_IDEXoutput(156 downto 124) & s_Ovf & s_IDEXoutput(118 downto 113) & s_IDEXoutput(105 downto 96) & s_IDEXoutput(63 downto 32) & s_ALUOut;

   EXDM: Reg_N
	generic map(N => 114)
	port map(write_data => s_EXDMinput,
		 write_en => '1',
		 i_CLK => iCLK,
		 i_RST => iRST,
		 read_data => s_EXDMoutput); 

   s_DMemWr <= s_EXDMoutput(74);
   s_DMemAddr <= s_EXDMoutput(31 downto 0);
   s_DMemData <= s_EXDMoutput(63 downto 32);
--------------------------------------------------------------------------------------------------------
   s_DMWBinput <= s_EXDMoutput(113 downto 76) & s_EXDMoutput(73 downto 64) & s_EXDMoutput(31 downto 0) & s_DMemOut;

   DMWB: Reg_N
	generic map(N => 112)
	port map(write_data => s_DMWBinput,
		 write_en => '1',
		 i_CLK => iCLK,
		 i_RST => iRST,
		 read_data => s_DMWBoutput); 

   s_Halt <= s_DMWBoutput(77);
   s_Ovfl <= s_DMWBoutput(78);

   MuxMemOrReg: mux2t1_N
	generic map(N => 32)
	port map(i_S => s_DMWBoutput(74),
		 i_D0 => s_DMWBoutput(63 downto 32),
		 i_D1 => s_DMWBoutput(31 downto 0),
		 o_O => s_MemOrRegOut); 

   MuxJal: mux2t1_N
	generic map(N => 32)
	port map(i_S => s_DMWBoutput(111),
		 i_D0 => s_MemOrRegOut,
		 i_D1 => s_DMWBoutput(110 downto 79),
		 o_O => s_RegWrData); 

   MuxRegSel: mux2t1_N
	generic map(N => 5)
	port map(i_S => s_DMWBoutput(75),
		 i_D0 => s_DMWBoutput(68 downto 64),
		 i_D1 => s_DMWBoutput(73 downto 69),
		 o_O => s_RegSelOut); 

   MuxRegSelJal: mux2t1_N
	generic map(N => 5)
	port map(i_S => s_DMWBoutput(111),
		 i_D0 => s_RegSelOut,
		 i_D1 => "11111",
		 o_O => s_RegWrAddr); 

   MuxRegWriteSel: mux2t1
	port map(i_S => s_DMWBoutput(111),
		 i_D0 => s_DMWBoutput(76),
		 i_D1 => '1',
		 o_O  => s_RegWr);


end structure;

