library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY InstructionMemory IS
	port (  
		inIM  : in  std_logic_vector(31 downto 0);
		outIM : out std_logic_vector(31 downto 0));
END InstructionMemory;

ARCHITECTURE InstructionMemory_1 of InstructionMemory is

	-- 2^32-1 x 32bit array to store the IM
	type mem_type is array (natural range <>) of std_logic_vector(7 downto 0);
	signal mem: mem_type(0 to 1023) := (
0 => "00000000",
1 => "00100010",
2 => "00101000",
3 => "00100000",
4 => "10101100",
5 => "01100101",
6 => "00000000",
7 => "00000101",
8 => "10001100",
9 => "01101010",
10 => "00000000",
11 => "00000101",		others=> (others => '0'));

	signal FullInstruction: std_logic_vector(31 downto 0); -- to merge the 4 memory bytes
	signal IM_address:      integer;

BEGIN
--
	IM_address <= to_integer(unsigned(inIM));-- when (to_integer(unsigned(inIM)) >= 0) else 0;
	FullInstruction <= mem(IM_address) & mem(IM_address+1) & mem(IM_address+2) & mem(IM_address+3)
		               when (IM_address >= 0) else std_logic_vector(to_signed(-1,32));
	outIM <= FullInstruction;
--
END InstructionMemory_1;