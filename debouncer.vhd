
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity debouncer is
    Port ( clk : in  STD_LOGIC;
           Sig : in  STD_LOGIC;
           Deb_Sig : out  STD_LOGIC);
end debouncer;

architecture Behavioral of debouncer is
	--Three internal signals
	signal Q0, Q1, Q2 : STD_LOGIC;
begin
	process (clk) is
	begin
		if (clk'event and clk = '1') then
			--shift in the current value on each clock pulse
			Q0 <= Sig;
			Q1 <= Q0;
			Q2 <= Q1;
		end if;
	end process;
	
	--only set output high if if Q1 and Q0 are high and Q2 is low
	--This happens when the input signal is consistently high for two clock pulses
	--The "not Q2" makes sure the output is a single clock pulse long even if the input
	--signal stays high.
	Deb_Sig <= Q0 and Q1 and (not Q2);

end Behavioral;

