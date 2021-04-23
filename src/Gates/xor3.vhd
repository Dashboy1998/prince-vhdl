library ieee;
use ieee.std_logic_1164.all;
use work.delays.all;

entity xor3 is
	port( 
	A, B, C: in std_logic;
	Z: out std_logic 
	);
end entity xor3;

architecture structural of xor3 is
begin
	Z <= A xor B xor C after propagation_delay_xor3;	
end architecture structural;