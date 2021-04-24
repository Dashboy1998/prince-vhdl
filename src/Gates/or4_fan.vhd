library ieee;
use ieee.std_logic_1164.all;

entity or4_fan is
	port( 
	A, B, C, D: in std_logic_vector;
	Z: out std_logic_vector 
	);
end entity or4_fan;

architecture structural of or4_fan is
component or4
	port(
	A, B, C, D: in std_logic;
	Z: out std_logic
	);	
end component or4;
alias BA : std_logic_vector (A'range) is B;
alias CA : std_logic_vector (A'range) is C;
alias DA : std_logic_vector (A'range) is D;
alias ZA : std_logic_vector (A'range) is Z;
begin
	GEN: for i in A'range generate
		Gate: or4 port map(
			A => A(i),
            B => BA(i),
            C => CA(i),
            D => DA(i),
			Z => ZA(i)
		);
	end generate GEN;
end architecture structural;