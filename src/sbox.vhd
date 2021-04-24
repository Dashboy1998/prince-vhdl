library ieee;
use ieee.std_logic_1164.all;

-- Substitution box of PRINCE
entity sbox is
	port(data_in:  in std_logic_vector(3 downto 0);
		data_out: out std_logic_vector(3 downto 0)
		);
end sbox;

architecture structural of sbox is
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
	component and3
		port( 
		A, B, C: in std_logic;
		Z: out std_logic 
		);
	end component and3;
	component or3
		port( 
		A, B, C: in std_logic;
		Z: out std_logic 
		);
	end component or3;
	component or5
		port( 
		A, B, C, D, E: in std_logic;
		Z: out std_logic 
		);
	end component or5;
	alias A is data_in(3);
	alias B is data_in(2);
	alias C is data_in(1);
	alias D is data_in(0);
	signal nA, nB, nC, nD: std_logic; -- NOT Gates
	signal nAnC, BnD, ACnD, nCD, AnC, AB, nAnB, nBnC, nCnD, nAnBnC, nAnBnD, nABC, BCnD, AnCD: std_logic; -- AND Gates
begin 
	-- NOT Gates
	N3: not1 port map(A,nA);
	N2: not1 port map(B,nB);
	N1: not1 port map(C,nC);
	N0: not1 port map(D,nD);

	-- Products of dataout(3)
	AND_nAnC: and2 port map(nA,nC,nAnC);
	AND_BnD: and2 port map(B,nD,BnD);
	AND_ACnD: and3 port map(A,C,nD,ACnD);

	-- Products of dataout(2)
	AND_nCD: and2 port map(nC,D,nCD);
	AND_AnC: and2 port map(A,nC,AnC);
	AND_AB: and2 port map(A,B,AB);

	-- Products of dataout(1)
	AND_nAnB: and2 port map(nA,nB,nAnB);
	AND_nBnC: and2 port map(nB,nC,nBnC);
	AND_nCnD: and2 port map(nC,nD,nCnD);

	-- Products of dataout(0)
	AND_nAnBnC: and3 port map(nA,nB,nC,nAnBnC);
	AND_nAnBnD: and3 port map(nA,nB,nD,nAnBnD);
	AND_nABC: and3 port map(nA,B,C,nABC);
	AND_BCnD: and3 port map(B,C,nD,BCnD);
	AND_AnCD: and3 port map(A,nC,D,AnCD);

	-- Sum of Products
	D3: or3 port map(nAnC,BnD,ACnD,data_out(3));
	D2:	or3 port map(nCD,AnC,AB,data_out(2));
	D1:	or3 port map(nAnB,nBnC,nCnD,data_out(1));
	D0: or5 port map(nAnBnC,nAnBnD,nABC,BCnD,AnCD,data_out(0));
end architecture structural;
