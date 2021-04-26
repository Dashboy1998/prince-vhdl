library ieee;
use ieee.std_logic_1164.all;

entity mux2 is
	port( 
	A, B, S: in std_logic;
	Z: out std_logic 
	);
end entity mux2;

architecture structural of mux2 is
component not1
	port(
	A: in std_logic;
	Z: out std_logic
	);	
end component not1;
component and2
	port(
	A, B: in std_logic;
	Z: out std_logic
	);	
end component and2;
component or2
	port(
	A, B: in std_logic;
	Z: out std_logic
	);	
end component or2;
signal AnS, BS, nS: std_logic;
begin
	notS: not1 port map(S, nS);
	andA: and2 port map(A,nS,AnS);
	andB: and2 port map(B,S, BS);
	or_result: or2 port map(AnS,BS,Z);
end architecture structural;