library ieee;
use ieee.std_logic_1164.all;
use work.delays.all;

entity or3 is
	port( 
	A, B, C: in std_logic;
	Z: out std_logic 
	);
end entity or3;

architecture structural of or3 is
begin
	Z <= A or B or C after propagation_delay_or3;	
end architecture structural;