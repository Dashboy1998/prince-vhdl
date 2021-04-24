library ieee;
use ieee.std_logic_1164.all;

entity dff_fan is
	port( 
	D: in std_logic_vector;
	CLK: in std_logic;
	Q: out std_logic_vector 
	);
end entity dff_fan;

architecture structural of dff_fan is
component dff
	port( 
	D, CLK: in std_logic;
	Q: out std_logic 
	);
end component dff;
alias QA is Q (D'range);
begin
	GEN: for i in D'range generate
		FF: dff port map(
			D => D(i),
			CLK => CLK,
			Q => QA(i)
		);
	end generate;
end architecture structural;