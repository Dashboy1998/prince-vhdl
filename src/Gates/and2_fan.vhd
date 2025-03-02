library ieee;
use ieee.std_logic_1164.all;

entity and2_fan is
	port( 
	A, B: in std_logic_vector;
	Z: out std_logic_vector 
	);
end entity and2_fan;

architecture structural of and2_fan is
component and2
	port(
	A, B: in std_logic;
	Z: out std_logic
	);	
end component and2;
alias BA : std_logic_vector (A'range) is B;
alias ZA : std_logic_vector (A'range) is Z;
begin
	GEN: for i in A'range generate
		Gate: and2 port map(
			A => A(i),
            B => BA(i),
			Z => ZA(i)
		);
	end generate GEN;
end architecture structural;