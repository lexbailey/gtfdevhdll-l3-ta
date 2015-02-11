LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY fib_counter_tb IS
END fib_counter_tb;
 
ARCHITECTURE behavior OF fib_counter_tb IS 
 
	type test_array is array
		(natural range <>) of std_logic_vector(7 downto 0);
		
	constant test_vector : test_array := (
		-- expected outputs
		("00000000"),
		("00000001"),
		("00000001"),
		("00000010"),
		("00000011"),
		("00000101"),
		("00001000"),
		("00001101"),
		("00010101"),
		("00100010"),
		("00110111"),
		("01011001"),
		("10010000"),
		("11101001")
	);
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fib_counter
    PORT(
         clk : IN  std_logic;
         count : IN  std_logic;
         reset : IN  std_logic;
         fib_out : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal count : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal fib_out : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fib_counter PORT MAP (
          clk => clk,
          count => count,
          reset => reset,
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

		--Reset the device
		reset <= '1';		
      wait for clk_period*3;
		reset <= '0';
		
		--Check that the output is now 0
		assert fib_out = "00000000"
		report "Initial Reset failed."
		severity error;
		
		--Step twice
		count <= '1';
		wait for clk_period*3;
		count <= '0';
		wait for clk_period*3;
		count <= '1';
		wait for clk_period*3;
		count <= '0';
		wait for clk_period*3;
		
		--Make sure it did step
		assert fib_out = "00000001"
		report "Failed to count up"
		severity error;

      --Reset the device again to check reset from different state
		reset <= '1';		
      wait for clk_period*3;
		reset <= '0';
		
		--Check that the output is now 0
		assert fib_out = "00000000"
		report "Second Reset failed."
		severity error;
		
		--Main test loop
		for i in test_vector'range loop
			--check this output
			assert (fib_out = test_vector(i))
			--report the test input, expected output and actual output if this test failed
			report "Test failed at count " & integer'image(i) &
				" expected " & integer'image(to_integer(unsigned(test_vector(i)))) &
				" but got " & integer'image(to_integer(unsigned(fib_out)))
			severity error;
			--Step the counter again
			count <= '1';
			wait for clk_period*3;
			count <= '0';
			wait for clk_period*3;
		end loop;

      wait;
   end process;

END;
