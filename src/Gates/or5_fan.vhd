library ieee;
use ieee.std_logic_1164.all;

entity or5_fan is
	port( 
	A, B, C, D, E: in std_logic_vector;
	Z: out std_logic_vector 
	);
end entity or5_fan;

architecture structural of or5_fan is
component or5
	port(
	A, B, C, D, E: in std_logic;
	Z: out std_logic
	);	
end component or5;
alias BA is B (A'range);
alias CA is C (A'range);
alias DA is D (A'range);
alias EA is E (A'range);
alias ZA is Z (A'range);
begin
	GEN: for i in A'range generate
		Gate: or5 port map(
			A => A(i),
            B => BA(i),
            C => CA(i),
            D => DA(i),
            E => EA(i),
			Z => ZA(i)
		);
	end generate GEN;
end architecture structural;