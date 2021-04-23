library ieee;
use ieee.std_logic_1164.all;
use work.delays.all;

entity or4 is
	port( 
	A, B, C, D: in std_logic;
	Z: out std_logic 
	);
end entity or4;

architecture structural of or4 is
begin
	Z <= A or B or C or D after propagation_delay_or4;	
end architecture structural;