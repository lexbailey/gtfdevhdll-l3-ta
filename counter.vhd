library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           count : in  STD_LOGIC;
           addr_out : out  UNSIGNED (3 downto 0));
end counter;

architecture Behavioral of counter is

	signal count_signal : UNSIGNED (3 downto 0);

begin

	count_proc: process (clk)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				count_signal <= "0000";
			else
				if count = '1' then
					if count_signal = "1101" then
						count_signal <= "0000";
					else
						count_signal <= count_signal + 1;
					end if;
				end if;
			end if;
		end if;
	end process count_proc;

	addr_out <= count_signal;

end Behavioral;

