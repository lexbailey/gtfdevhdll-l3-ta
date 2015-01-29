library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fibonacci_system is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           count : in  STD_LOGIC;
           fib_out : out  STD_LOGIC_VECTOR (7 downto 0));
end fibonacci_system;

architecture Behavioral of fibonacci_system is

	signal deb_rst: STD_LOGIC;
	signal deb_count: STD_LOGIC;
	signal fib_addr: UNSIGNED (3 downto 0);

	--uses debouncer component
	COMPONENT debouncer
   PORT(
        clk : IN  std_logic;
        Sig : IN  std_logic;
        Deb_Sig : OUT  std_logic
       );
   END COMPONENT;

	--uses counter component
	COMPONENT counter
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		count : IN std_logic;          
		addr_out : OUT UNSIGNED(3 downto 0)
		);
	END COMPONENT;
	
	--uses ROM component
	COMPONENT ROM
	PORT(
		addr : IN UNSIGNED(3 downto 0);          
		fib_out : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

begin

	--debouncer for the reset input button
	debouncerRst: debouncer port map(
		Sig => rst,
		Deb_Sig => deb_rst,
		clk => clk
	);
	
	--debouncer for the count input button
	debouncerCount: debouncer port map(
		Sig => count,
		Deb_Sig => deb_count,
		clk => clk
	);
	
	--Counter (0-13) for generating addresses for rom
	counter0: counter port map(
		rst => deb_rst,
		count => deb_count,
		addr_out => fib_addr,
		clk => clk
	);

	--fibonacci rom, takes an address and provides the fibonacci number
	fib_rom: ROM port map(
		addr => fib_addr,
		fib_out => fib_out
	);


end Behavioral;

