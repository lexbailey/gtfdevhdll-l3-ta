
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fib_counter is
    Port ( clk : in  STD_LOGIC;
           count : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           fib_out : out  STD_LOGIC_VECTOR (7 downto 0));
end fib_counter;

architecture Behavioral of fib_counter is

	signal addr : unsigned (3 downto 0);
	signal deb_count : std_logic;
	signal deb_reset : std_logic;

begin

	debounce_count: entity work.Debouncer
		port map (clk => clk, sig => count, deb_sig => deb_count);
		
	debounce_reset: entity work.Debouncer
		port map (clk => clk, sig => reset, deb_sig => deb_reset);

	fib_rom: entity work.ROM
		port map (addr => addr, fib_out => fib_out);
		

	counter: process (clk) begin
		if rising_edge(clk) then
			if deb_reset = '1' then
				addr <= "0000";
			else
				if deb_count = '1' then
					addr <= addr + 1;
				end if;
			end if;
		end if;
	end process;

end Behavioral;

