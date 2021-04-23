library ieee;
use ieee.std_logic_1164.all;
use work.delays.all;

entity xor2_fan is
	port( 
	A, B: in std_logic_vector;
	Z: out std_logic_vector 
	);
end entity xor2_fan;

architecture structural of xor2_fan is
component xor2
	port(
	A, B: in std_logic;
	Z: out std_logic
	);	
end component xor2;
alias BA is B (A'range);
alias ZA is Z (A'range);
begin
	GEN: for i in A'range generate
		Gate: xor2 port map(
			A => A(i),
            B => BA(i),
			Z => ZA(i)
		);
	end generate GEN;
end architecture structural;