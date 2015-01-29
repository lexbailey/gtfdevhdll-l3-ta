LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY debouncer_tb IS
END debouncer_tb;
 
ARCHITECTURE behavior OF debouncer_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT debouncer
    PORT(
         clk : IN  std_logic;
         Sig : IN  std_logic;
         Deb_Sig : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal Sig : std_logic := '0';

 	--Outputs
   signal Deb_Sig : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: debouncer PORT MAP (
          clk => clk,
          Sig => Sig,
          Deb_Sig => Deb_Sig
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

		--Generate a 'dirty' input signal to test output
		Sig <= '0';
      wait for clk_period/10; --use fractions of clock from small time steps
		Sig <= '1';
		wait for clk_period/8;
		Sig <= '0';
		wait for clk_period/4;
		Sig <= '1';
		wait for clk_period/9;
		Sig <= '0';
		wait for clk_period/2;
		Sig <= '1';
		wait for clk_period*10;
		Sig <= '0';

      wait;
   end process;

END;
