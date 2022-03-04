----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:32:17 04/19/2021 
-- Design Name: 
-- Module Name:    Memory_Unit - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Memory_Unit is
    Port ( memread : in  STD_LOGIC;
           memwrite : in  STD_LOGIC;
           Wdata : in  STD_LOGIC_VECTOR (31 downto 0);
           address : in  STD_LOGIC_VECTOR (31 downto 0);
           Rdata : out  STD_LOGIC_VECTOR (31 downto 0);
			  CLK : in STD_LOGIC);
end Memory_Unit;

architecture Behavioral of Memory_Unit is
type A is array(0 to 127) of STD_LOGIC_VECTOR (7 downto 0);
signal mem: A := (x"50",x"40",x"30",x"20",x"15",x"05",x"14",x"11",x"08",x"09",x"15",x"05",others=>x"00");

begin

process(memread, memwrite, Wdata, address, CLK)

begin

if(rising_edge(CLK) and memread = '1' and memwrite = '0') then
	Rdata(31 downto 24) <= mem(conv_integer(address));
	Rdata(23 downto 16) <= mem(conv_integer(address)+1);
	Rdata(15 downto 8) <= mem(conv_integer(address)+2);
	Rdata(7 downto 0) <= mem(conv_integer(address)+3);
end if;

if(rising_edge(CLK) and memread = '0' and memwrite = '1') then
	mem(conv_integer(address)) <= Wdata(31 downto 24);
	mem(conv_integer(address)+1) <= Wdata(23 downto 16);
	mem(conv_integer(address)+2) <= Wdata(15 downto 8);
	mem(conv_integer(address)+3) <= Wdata(7 downto 0);
end if;

end process;

end Behavioral;

