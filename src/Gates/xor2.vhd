library ieee;
use ieee.std_logic_1164.all;
use work.delays.all;

entity xor2 is
	port( 
	A, B: in std_logic;
	Z: out std_logic 
	);
end entity xor2;

architecture structural of xor2 is
begin
	Z <= A xor B after propagation_delay_xor2;	
end architecture structural;