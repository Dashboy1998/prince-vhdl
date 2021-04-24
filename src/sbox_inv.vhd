library ieee;
use ieee.std_logic_1164.all;

-- Inverted substitution box of PRINCE
entity sbox_inv is
	port(data_in:  in std_logic_vector(3 downto 0);
		data_out: out std_logic_vector(3 downto 0)
		);
end sbox_inv;

architecture behavioral of sbox_inv is
begin
	process(data_in)
	begin
		case data_in is
			when x"0" => data_out <= x"B";
			when x"1" => data_out <= x"7";
			when x"2" => data_out <= x"3";
			when x"3" => data_out <= x"2";
			when x"4" => data_out <= x"F";
			when x"5" => data_out <= x"D";
			when x"6" => data_out <= x"8";
			when x"7" => data_out <= x"9";
			when x"8" => data_out <= x"A";
			when x"9" => data_out <= x"6";
			when x"A" => data_out <= x"4";
			when x"B" => data_out <= x"0";
			when x"C" => data_out <= x"5";
			when x"D" => data_out <= x"E";
			when x"E" => data_out <= x"C";
			when x"F" => data_out <= x"1";
			when others => null; -- GHDL complains without this statement
		end case;
	end process;
end behavioral;

architecture dataflow of sbox_inv is
begin
	with data_in select data_out <=
	x"B" when x"0",
	x"7" when x"1",
	x"3" when x"2",
	x"2" when x"3",
	x"F" when x"4",
	x"D" when x"5",
	x"8" when x"6",
	x"9" when x"7",
	x"A" when x"8",
	x"6" when x"9",
	x"4" when x"A",
	x"0" when x"B",
	x"5" when x"C",
	x"E" when x"D",
	x"C" when x"E",
	x"1" when x"F",
	x"X" when others; -- Prevents latches
end architecture dataflow;

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