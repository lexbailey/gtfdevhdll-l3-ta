
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY ROM_tb IS
END ROM_tb;
 
ARCHITECTURE behavior OF ROM_tb IS 
	
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
		
		for i in test_vector'range loop
			addr <= to_unsigned(i,4);
			wait for 20 ns; -- multiple of period when sequential
			assert (fib_out = test_vector(i))
			report "Test failed with input addr = " & integer'image(i) &
				" expected " & integer'image(to_integer(unsigned(test_vector(i)))) &
				" but got " & integer'image(to_integer(unsigned(fib_out)))
			severity error;
		end loop;
		
      wait;
   end process;

END;
