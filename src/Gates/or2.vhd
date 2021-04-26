library ieee;
use ieee.std_logic_1164.all;
use work.delays.all;

entity or2 is
	port( 
	A, B: in std_logic;
	Z: out std_logic 
	);
end entity or2;

architecture structural of or2 is
begin
	Z <= A or B after propagation_delay_or2;	
end architecture structural;