library ieee;
use ieee.std_logic_1164.all;

package constants is
	type round_constants is array(0 to 11) of std_logic_vector(63 downto 0);
	type intermediate_signals is array(0 to 11) of std_logic_vector(63 downto 0);
	constant alpha: std_logic_vector(63 downto 0) := x"c0ac29b7c97c50dd";
	
	-- Round constants for each round
	constant rcs: round_constants := (
	x"0000000000000000",
	x"13198A2E03707344",
	x"A4093822299F31D0",
	x"082EFA98EC4E6C89",
	x"452821E638D01377",
	x"BE5466CF34E90C6C",
	x"7EF84F78FD955CB1",
	x"85840851F1AC43AA",
	x"C882D32F25323C54",
	x"64A51195E0E3610D",
	x"D3B5A399CA0C2399",
	x"C0AC29B7C97C50DD");
end package constants;