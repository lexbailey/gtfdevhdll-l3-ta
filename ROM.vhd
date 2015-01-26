
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ROM is
    Port ( addr : in  UNSIGNED (3 downto 0);
           fib_out : out  STD_LOGIC_VECTOR (7 downto 0));
end ROM;

architecture Behavioral of ROM is
type ROM_Array is array (0 to 15) of std_logic_vector(7 downto 0);	
constant Fibonacci: ROM_Array:=(
		0  => "00000000",
		1  => "00000001",
		2  => "00000001",
		3  => "00000010",
		4  => "00000011",
		5  => "00000101",
		6  => "00001000",
		7  => "00001101",
		8  => "00010101",
		9  => "00100010",
		10 => "00110111",
		11 => "01011001",
		12 => "10010000",
		13 => "11101001",
		others => "00000000");
begin

	fib_out <= Fibonacci(to_integer(addr));

end Behavioral;

