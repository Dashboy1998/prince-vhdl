library ieee;
use ieee.std_logic_1164.all;
use work.delays.all;

entity and2 is
	port( 
	A, B: in std_logic;
	Z: out std_logic 
	);
end entity and2;

architecture structural of and2 is
begin
	Z <= A and B after propagation_delay_and2;	
end architecture structural;