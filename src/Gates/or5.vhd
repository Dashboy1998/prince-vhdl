library ieee;
use ieee.std_logic_1164.all;
use work.delays.all;

entity or5 is
	port( 
	A, B, C, D, E: in std_logic;
	Z: out std_logic 
	);
end entity or5;

architecture structural of or5 is
begin
	Z <= A or B or C or D or E after propagation_delay_or5;	
end architecture structural;