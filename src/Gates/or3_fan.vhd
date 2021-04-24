library ieee;
use ieee.std_logic_1164.all;

entity or3_fan is
	port( 
	A, B, C: in std_logic_vector;
	Z: out std_logic_vector 
	);
end entity or3_fan;

architecture structural of or3_fan is
component or3
	port(
	A, B, C: in std_logic;
	Z: out std_logic
	);	
end component or3;
alias BA : std_logic_vector (A'range) is B;
alias CA : std_logic_vector (A'range) is C;
alias ZA : std_logic_vector (A'range) is Z;
begin
	GEN: for i in A'range generate
		Gate: or3 port map(
			A => A(i),
            B => BA(i),
            C => CA(i),
			Z => ZA(i)
		);
	end generate GEN;
end architecture structural;