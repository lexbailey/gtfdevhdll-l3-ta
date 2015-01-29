LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY fibonacci_system_tb IS
END fibonacci_system_tb;
 
ARCHITECTURE behavior OF fibonacci_system_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fibonacci_system
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         count : IN  std_logic;
         fib_out : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal count : std_logic := '0';

 	--Outputs
   signal fib_out : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fibonacci_system PORT MAP (
          clk => clk,
          rst => rst,
          count => count,
          fib_out => fib_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		rst <= '1';
		count <= '0';
      wait for clk_period*2;

      rst <= '0';
		wait for clk_period*2;
		
		count <= '1';
		wait for clk_period*3;
		count <= '0';
		wait for clk_period*3;
		
		rst <= '1';
		wait for clk_period*2;

		rst <= '0';
		
		COUNT_LOOP : loop
			count <= '1';
			wait for clk_period*3;
			count <= '0';
			wait for clk_period*3;
		end loop COUNT_LOOP;
		

      wait;
   end process;

END;
