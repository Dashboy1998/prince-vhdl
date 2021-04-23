library ieee;
use ieee.std_logic_1164.all;
use work.delays.all;

entity and3 is
	port( 
	A, B, C: in std_logic;
	Z: out std_logic 
	);
end entity and3;

architecture structural of and3 is
begin
	Z <= A and B and C after propagation_delay_and3;	
end architecture structural;