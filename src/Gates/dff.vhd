library ieee;
use ieee.std_logic_1164.all;
use work.delays.all;

entity dff is
	port( 
	D, CLK: in std_logic;
	Q: out std_logic 
	);
end entity dff;

architecture structural of dff is
begin
	process(CLK)
	begin
		if rising_edge(CLK) then
			Q <= D after propagation_delay_dff;
		end if;
	end process;
end architecture structural;