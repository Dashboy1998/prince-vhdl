library ieee;
use ieee.std_logic_1164.all;

entity not1_fan is
	port( 
	A: in std_logic_vector;
	Z: out std_logic_vector 
	);
end entity not1_fan;

architecture structural of not1_fan is
component not1
	port(
	A: in std_logic;
	Z: out std_logic
	);	
end component not1;
alias ZA is Z (A'range);
begin
	GEN: for i in A'range generate
		Gate: not1 port map(
			A => A(i),
			Z => ZA(i)
		);
	end generate GEN;
end architecture structural;