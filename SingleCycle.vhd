----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:24:02 05/08/2021 
-- Design Name: 
-- Module Name:    SingleCycle - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SingleCycle is
    Port ( CLK_MIN : in  STD_LOGIC);
end SingleCycle;

architecture Behavioral of SingleCycle is
COMPONENT ALU_control
	PORT(
		Function_Field : IN std_logic_vector(5 downto 0);
		ALU_OP : IN std_logic_vector(1 downto 0);          
		operation : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	
COMPONENT ALU_32bit
	PORT(
		A : IN std_logic_vector(31 downto 0);
		B : IN std_logic_vector(31 downto 0);
		ALUControl : IN std_logic_vector(3 downto 0);          
		Output : OUT std_logic_vector(31 downto 0);
		Zero : OUT std_logic
		);
	END COMPONENT;
	
COMPONENT Adder
	PORT(
		Adder_in_1: IN std_logic_vector(31 downto 0);
      Adder_in_2 : IN std_logic_vector(31 downto 0);          
		Adder_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT Control
	PORT(
		OP : IN std_logic_vector(5 downto 0);          
		RegDst : OUT std_logic;
		ALUSrc : OUT std_logic;
		MemToReg : OUT std_logic;
		RegWrite : OUT std_logic;
		MemRead : OUT std_logic;
		MemWrite : OUT std_logic;
		Branch : OUT std_logic;
		ALUop : OUT std_logic_vector(1 downto 0)
		);
	END COMPONENT;
	
COMPONENT Memory_Unit
	PORT(
		memread : IN std_logic;
		memwrite : IN std_logic;
		Wdata : IN std_logic_vector(31 downto 0);
		address : IN std_logic_vector(31 downto 0);          
		Rdata : OUT std_logic_vector(31 downto 0);
		CLK : in STD_LOGIC
		);
	END COMPONENT;
	
COMPONENT Instruction_Memory
	PORT(
		PC : IN std_logic_vector(31 downto 0);          
		instruct : OUT std_logic_vector(31 downto 0);
		CLK: in STD_LOGIC
		);
	END COMPONENT;
	
COMPONENT mux2to1
	port(	a : IN std_logic_vector(31 downto 0);
		b : IN std_logic_vector(31 downto 0);
		sel : IN std_logic;          
		output : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT mux2to1_for_reg
	PORT(
		a : IN std_logic_vector(4 downto 0);
		b : IN std_logic_vector(4 downto 0);
		sel : IN std_logic;          
		output : OUT std_logic_vector(4 downto 0)
		);
	END COMPONENT;
	
COMPONENT PC
	PORT(
		CLK : IN std_logic;
		PCin : IN std_logic_vector(31 downto 0);          
		PCout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT Register_File
	PORT(
		rs : IN std_logic_vector(4 downto 0);
		rt : IN std_logic_vector(4 downto 0);
		rd : IN std_logic_vector(4 downto 0);
		WriteData : IN std_logic_vector(31 downto 0);
		RegWrite : IN std_logic;          
		ReadData1 : OUT std_logic_vector(31 downto 0);
		ReadData2 : OUT std_logic_vector(31 downto 0);
		CLK : in STD_LOGIC
		);
	END COMPONENT;
	
COMPONENT Shift_Left_2
	PORT(
		Shift_Left_2_in: IN std_logic_vector(31 downto 0);          
		Shift_Left_2_out: OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT Sign_Extend
     port( SignExtend_in : IN std_logic_vector(15 downto 0);          
		SignExtend_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	signal ALUinput1: std_logic_vector(31 downto 0);
	signal ALUinput2: std_logic_vector(31 downto 0);
	signal ALUoutput: std_logic_vector(31 downto 0);
	signal ALUzeroFlag: std_logic;
	signal ALUselect: std_logic_vector(3 downto 0);
	
	signal PCoutput: std_logic_vector(31 downto 0);
	signal PCinput: std_logic_vector (31 downto 0);
	signal AdderOut: std_logic_vector (31 downto 0);
	
	signal inputInstruction: std_logic_vector (31 downto 0);
	signal readData2: std_logic_vector (31 downto 0);
	signal dataMemoryOut: std_logic_vector (31 downto 0);
	signal writeDataIn: std_logic_vector (31 downto 0);
	signal MUXregDstOut:std_logic_vector (4 downto 0);
	
	signal regDst: std_logic;
	signal branch: std_logic;
	signal memRead: std_logic;
	signal memToReg: std_logic;
	signal ALUopControl: std_logic_vector (1 downto 0);
	signal memWrite: std_logic;
	signal ALUSrc: std_logic;
	signal RegWrite: std_logic;
	
	signal signExtend: std_logic_vector (31 downto 0);
	signal shiftLeft2: std_logic_vector (31 downto 0);
	
	signal ALUoutputToPCMUX: std_logic_vector (31 downto 0);
	signal PCMUXcontrol: std_logic;
	
begin

	PC_Min: PC PORT MAP(
		CLK => CLK_MIN,
		PCin => PCinput,
		PCout => PCoutput 
	);
	
	Adder1: Adder PORT MAP(
		Adder_in_1 => PCoutput,
		Adder_in_2 => "00000000000000000000000000000100",
		Adder_out => AdderOut
	);
	
	InstructionMemory_Min: Instruction_Memory PORT MAP(
		PC => PCoutput,
		instruct => inputInstruction,
		CLK => CLK_MIN
	);
	
	ControlUnit: Control PORT MAP(
		OP => inputInstruction (31 downto 26),
		RegDst => regDst,
		ALUSrc => ALUSrc,
		MemToReg => memToReg,
		RegWrite => RegWrite,
		MemRead => memRead,
		MemWrite => memWrite,
		Branch => branch,
		ALUop => ALUopControl
	);
	
	MUXRegDst: mux2to1_for_reg	 PORT MAP(
		a => inputInstruction (20 downto 16),
		b => inputInstruction (15 downto 11),
		sel => regDst,
		output => MUXregDstOut 
	);
	
	RegisterFile_Min: Register_File PORT MAP(
		ReadData1 => ALUinput1,
		ReadData2 => readData2,
		rs => inputInstruction (25 downto 21),
		rt => inputInstruction (20 downto 16),
		rd => MUXregDstOut,
		WriteData => writeDataIn,
		RegWrite => RegWrite,
      CLK => CLK_MIN		
	);
	
	SignExtend_Min: Sign_Extend PORT MAP(
		SignExtend_in => inputInstruction (15 downto 0),
		SignExtend_out => signExtend
	);
	
	ShiftLeft2_Min: Shift_Left_2 PORT MAP(
		Shift_Left_2_in => signExtend,
		Shift_Left_2_out => shiftLeft2
	);
	
	Adder2: Adder PORT MAP(
		Adder_in_1 => AdderOut,
		Adder_in_2 => shiftLeft2,
		Adder_out => ALUoutputToPCMUX
	);

	ALUControl: ALU_control PORT MAP(
		Function_Field => inputInstruction (5 downto 0),
		ALU_OP => ALUopControl,
		operation => ALUselect
	);
	
	ALUMUX: mux2to1 PORT MAP(
		a => readData2,
		b => signExtend,
		sel => ALUSrc,
		output => ALUinput2 
	);
	
	ALU: ALU_32bit PORT MAP(
		A => ALUinput1,
		B => ALUinput2,
		ALUControl => ALUselect,
		Output => ALUoutput,
		Zero => ALUzeroFlag
	);
	
	PCMUXcontrol <= (branch AND ALUzeroFlag);
	
	PCMUX: mux2to1 PORT MAP(
		a => AdderOut,
		b => ALUoutputToPCMUX,
		sel => PCMUXcontrol,
		output => PCinput
	);
	
	   MemoryUnit_Min: Memory_Unit PORT MAP(
		memread => memRead,
		memwrite => memWrite,
		Wdata => readData2,
		address => ALUoutput,
		Rdata => dataMemoryOut,
		CLK => CLK_MIN	
	);
	
	MemoryMUX: mux2to1 PORT MAP(
		a => ALUoutput,
		b => dataMemoryOut,
		sel => memToReg,
		output => writeDataIn
	);

end Behavioral;



