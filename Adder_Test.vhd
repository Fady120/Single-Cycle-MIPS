--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:17:43 04/27/2021
-- Design Name:   
-- Module Name:   D:/files for aast/Computer Architecture/Lab/New folder/FadySamyGouda_18102062_2021/Adder_Test.vhd
-- Project Name:  FadySamyGouda_18102062_2021
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Adder
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Adder_Test IS
END Adder_Test;
 
ARCHITECTURE behavior OF Adder_Test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Adder
    PORT(
         Adder_in_1 : IN  std_logic_vector(31 downto 0);
         Adder_in_2 : IN  std_logic_vector(31 downto 0);
         Adder_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Adder_in_1 : std_logic_vector(31 downto 0) := (others => '0');
   signal Adder_in_2 : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Adder_out : std_logic_vector(31 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Adder PORT MAP (
          Adder_in_1 => Adder_in_1,
          Adder_in_2 => Adder_in_2,
          Adder_out => Adder_out
        );
 

   -- Stimulus process
   stim_proc: process
   begin
	
	    Adder_in_1 <= x"0000000f";
       Adder_in_2 <= X"12121212";
       wait for 100 ns;
		 
		 Adder_in_1 <= x"aaaaaaaa";
       Adder_in_2 <= X"01010101";
       wait for 100 ns;	

    
      wait;
   end process;

END;
