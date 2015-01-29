
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY ROM_tb IS
END ROM_tb;
 
ARCHITECTURE behavior OF ROM_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ROM
    PORT(
         addr : IN  UNSIGNED(3 downto 0);
         fib_out : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal addr : UNSIGNED(3 downto 0) := (others => '0');

 	--Outputs
   signal fib_out : std_logic_vector(7 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ROM PORT MAP (
          addr => addr,
          fib_out => fib_out
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		addr<= "0000";
      wait for 10ns;
		
		addr <="0001";
		wait for 10ns;
		
		addr <="0010";
		wait for 10ns;
		
		addr <="0011";
		wait for 10ns;
		
		addr <="0100";
		wait for 10ns;

		addr <="0101";
		wait for 10ns;
		
		addr <="0110";
		wait for 10ns;
		
		addr <="0111";
		wait for 10ns;
		
		addr <="1000";
		wait for 10ns;
		addr <="1001";
		wait for 10ns;
		
		addr <="1010";
		wait for 10ns;
		
		addr <="1011";
		wait for 10ns;
		
		addr <="1100";
		wait for 10ns;
		addr <="1101";
		wait for 10ns;
		
		addr <="1110";
		wait for 10ns;
		
		addr <="1111";
		wait for 10ns;
		
      wait;
   end process;

END;
