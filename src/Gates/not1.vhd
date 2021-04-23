library ieee;
use ieee.std_logic_1164.all;
use work.delays.all;

entity not1 is
	port( 
	A: in std_logic;
	Z: out std_logic 
	);
end entity not1;

architecture structural of not1 is
begin
	Z <= not A after propagation_delay_not1;	
end architecture structural;