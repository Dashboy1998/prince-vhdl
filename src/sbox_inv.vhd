library ieee;
use ieee.std_logic_1164.all;

-- Inverted substitution box of PRINCE
entity sbox_inv is
	port(data_in:  in std_logic_vector(3 downto 0);
		data_out: out std_logic_vector(3 downto 0)
		);
end sbox_inv;

architecture structural of sbox_inv is
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
	component or4
		port( 
		A, B, C, D: in std_logic;
		Z: out std_logic 
		);
	end component or4;
	alias A is data_in(3);
	alias B is data_in(2);
	alias C is data_in(1);
	alias D is data_in(0);
	signal nA, nB, nC, nD: std_logic; -- NOT Gates
	signal nAB, nBnCnD, BnCD, BCnD, nCD, BnC, ACnD, nAnB, nBnC, nAnCnD, AnCD, nAnC, nAnBnD, BnCnD, BCD: std_logic; -- AND Gate
begin 
	-- NOT Gates
	N3: not1 port map(A,nA);
	N2: not1 port map(B,nB);
	N1: not1 port map(C,nC);
	N0: not1 port map(D,nD);
	
	-- Products of dataout(3)
	AND_nAB: and2 port map(nA,B,nAB); 
	AND_nBnCnD: and3 port map(nB,nC,nD,nBnCnD);
	AND_BnCD: and3 port map(B,nC,D,BnCD);
	AND_BCnD: and3 port map(B,C,nD,BCnD);
	
	-- Products of dataout(2)
	AND_nCD: and2 port map(nC,D,nCD);
	AND_BnC: and2 port map(B,nC,BnC);
	AND_ACnD: and3 port map(A,C,nD,ACnD);

	-- Products of dataout(1)
	AND_nAnB: and2 port map(nA,nB,nAnB);
	AND_nBnC: and2 port map(nB,nC,nBnC);
	AND_nAnCnD: and3 port map(nA,nC,nD,nAnCnD);
	AND_AnCD: and3 port map(A,nC,D,AnCD);

	-- Products of dataout(0)
	AND_nAnC: and2 port map(nA,nC,nAnC);
	AND_nAnBnD: and3 port map(nA,nB,nD,nAnBnD);
	AND_BnCnD: and3 port map(B,nC,nD,BnCnD);
	AND_BCD: and3 port map(B,C,D,BCD); 

	-- Sum of Products
	D3: or4 port map(nAB,nBnCnD,BnCD,BCnD,data_out(3));
	D2: or3 port map(nCD,BnC,ACnD,data_out(2));
	D1: or4 port map(nAnB,nBnC,nAnCnD,AnCD,data_out(1));
	D0: or4 port map(nAnC,nAnBnD,BnCnD,BCD,data_out(0));
end architecture structural;