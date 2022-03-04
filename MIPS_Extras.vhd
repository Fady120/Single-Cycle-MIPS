----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:03:51 04/25/2021 
-- Design Name: 
-- Module Name:    MIPS_Extras - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MIPS_Extras is
    Port ( Shift_Left_2in : in  STD_LOGIC_VECTOR (31 downto 0);
           Shift_Left_2out : out  STD_LOGIC_VECTOR (31 downto 0);
           Adderin1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Adderin2 : in  STD_LOGIC_VECTOR (31 downto 0);
           PCin : in  STD_LOGIC_VECTOR (31 downto 0);
           AdderSum : out  STD_LOGIC_VECTOR (31 downto 0);
           Signextendin : in  STD_LOGIC_VECTOR (15 downto 0);
           Signextendout : out  STD_LOGIC_VECTOR (31 downto 0);
           PCout : out  STD_LOGIC_VECTOR (31 downto 0);
			  CLK : out STD_LOGIC;
			  ReadData : out  STD_LOGIC_VECTOR (31 downto 0);
			  Address : in  STD_LOGIC_VECTOR (31 downto 0));
end MIPS_Extras;

architecture Behavioral of MIPS_Extras is
type InstructionMemoory is array (0 to 255) of STD_LOGIC_VECTOR (7 downto 0);
signal Instruction : InstructionMemoory := 
(x"50",x"40",x"30",x"20",x"15",x"05",x"14",x"11",x"08",x"09",x"15",x"05",others=>x"00");

begin
process(Signextendin,PCin,Adderin1,Adderin2, Shift_Left_2in)

if(Signextendin[15] = '0')
then
Signextendout <= Signextendin & x"0000";
else
Signextendout <= Signextendin & x"FFFF";
end if;

Shift_Left_2out <= STD_LOGIC_VECTOR(unsigned(Shift_Left_2in),"2");

if( rising_edge(CLK))
then 
PCout <= PCin;

ReadData  <=  Instruction(to_integer(unsigned(Address)))&
              Instruction(to_integer(unsigned(Address))+1)&
				  Instruction(to_integer(unsigned(Address))+2)&
				  Instruction(to_integer(unsigned(Address))+3);

end if;

AdderSum <= to_integer(unsigned(Adderin1)) + to_integer(unsigned(Adderin1));





end Behavioral;

