library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter is
    Port ( clk : in  STD_LOGIC;							--clock input
           rst : in  STD_LOGIC;							--reset signal
           count : in  STD_LOGIC;						--count enable
           addr_out : out  UNSIGNED (3 downto 0));	--counter output (address)
end counter;

architecture Behavioral of counter is

	--internal counter signal
	signal count_signal : UNSIGNED (3 downto 0);

begin

	--count process
	count_proc: process (clk)
	begin
		--on rising edge of clock
		if rising_edge(clk) then
			--if reset is high
			if rst = '1' then
				--set count to zero
				count_signal <= (others => '0');
			else
				--if count is high
				if count = '1' then
					--if the counter has reached the end of the address range
					if count_signal = "1101" then
						--counter should loop around to 0
						count_signal <= (others => '0');
					else
						--counter should increment by one
						count_signal <= count_signal + 1;
					end if;
				end if;
			end if;
		end if;
	end process count_proc;

	--connect the output
	addr_out <= count_signal;

end Behavioral;

