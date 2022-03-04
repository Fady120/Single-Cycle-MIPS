----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:33:51 04/27/2021 
-- Design Name: 
-- Module Name:    Instruction_Memory - Behavioral 
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

entity Instruction_Memory is
    Port (  PC : in  STD_LOGIC_VECTOR (31 downto 0);
           instruct : out  STD_LOGIC_VECTOR (31 downto 0);
			  CLK: in STD_LOGIC );
end Instruction_Memory;

architecture Behavioral of Instruction_Memory is

type A is array(0 to 1023) of STD_LOGIC_VECTOR (7 downto 0);
signal mem: A:=
(0 => "00000000",
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
11 => "00000101",
12 => "00010001",
13 => "00101000",
14 => "00000000",
15 => "00000010",others=> (others => '0'));

begin
Process(CLK)
begin
if(rising_edge(CLK))
then
instruct (31 downto 24) <=   mem(to_integer(unsigned(PC)));
instruct (23 downto 16) <=   mem(to_integer(unsigned(PC))+1);
instruct (15 downto 8) <=	  mem(to_integer(unsigned(PC))+2);
instruct (7 downto 0) <=	  mem(to_integer(unsigned(PC))+3);

end if;
end process;
end Behavioral;

