library ieee;
use ieee.std_logic_1164.all;
use work.delays.all;

entity and3_fan is
	port( 
	A, B, C: in std_logic_vector;
	Z: out std_logic_vector 
	);
end entity and3_fan;

architecture structural of and3_fan is
component and3
	port(
	A, B, C: in std_logic;
	Z: out std_logic
	);	
end component and3;
alias BA is B (A'range);
alias CA is C (A'range);
alias ZA is Z (A'range);
begin
	GEN: for i in A'range generate
		Gate: and3 port map(
			A => A(i),
            B => BA(i),
            C => CA(i),
			Z => ZA(i)
		);
	end generate GEN;
end architecture structural;