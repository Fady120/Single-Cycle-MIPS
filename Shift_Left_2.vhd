----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:54:07 04/27/2021 
-- Design Name: 
-- Module Name:    Shift_Left_2 - Behavioral 
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

entity Shift_Left_2 is
    Port ( Shift_Left_2_in : in  STD_LOGIC_VECTOR (31 downto 0);
           Shift_Left_2_out : out  STD_LOGIC_VECTOR (31 downto 0));
end Shift_Left_2;

architecture Behavioral of Shift_Left_2 is

begin
Shift_Left_2_out <= STD_LOGIC_VECTOR(unsigned(Shift_Left_2_in)  sll 2);

end Behavioral;

