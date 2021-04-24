library ieee;
use ieee.std_logic_1164.all;

entity xor3_fan is
	port( 
	A, B, C: in std_logic_vector;
	Z: out std_logic_vector 
	);
end entity xor3_fan;

architecture structural of xor3_fan is
component xor3
	port(
	A, B, C: in std_logic;
	Z: out std_logic
	);	
end component xor3;
alias BA is B (A'range);
alias CA is C (A'range);
alias ZA is Z (A'range);
begin
	GEN: for i in A'range generate
		Gate: xor3 port map(
			A => A(i),
            B => BA(i),
            C => CA(i),
			Z => ZA(i)
		);
	end generate GEN;
end architecture structural;