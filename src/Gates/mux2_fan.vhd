library ieee;
use ieee.std_logic_1164.all;

entity mux2_fan is
	port( 
	A, B: in std_logic_vector;
	S: in std_logic;
	Z: out std_logic_vector 
	);
end entity mux2_fan;

architecture structural of mux2_fan is
component mux2
	port(
	A, B, S: in std_logic;
	Z: out std_logic
	);	
end component mux2;
alias BA : std_logic_vector (A'range) is B;
alias ZA : std_logic_vector (A'range) is Z;
begin
	GEN: for i in A'range generate
		Gate: mux2 port map(
			A => A(i),
            B => BA(i),
			S => S,
			Z => ZA(i)
		);
	end generate GEN;
end architecture structural;