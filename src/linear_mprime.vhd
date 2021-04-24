library ieee;
use ieee.std_logic_1164.all;

-- Linear layer of PRINCE
-- This entity multiplies the 64 bit state with a fixed 64x64 matrix. Each row
-- and column of this matrix has exactly 3 bits set to 1, while the rest is
-- set to 0.
entity linear_mprime is
	port(data_in:  in std_logic_vector(63 downto 0);
		data_out: out std_logic_vector(63 downto 0)
		);
end linear_mprime;

architecture structural of linear_mprime is
component xor3 is
	port( 
	A, B, C: in std_logic;
	Z: out std_logic 
	);
end component xor3;
begin
	XORG63: xor3 port map(data_in(59),data_in(55),data_in(51),data_out(63));
	XORG62: xor3 port map(data_in(62),data_in(54),data_in(50),data_out(62));
	XORG61: xor3 port map(data_in(61),data_in(57),data_in(49),data_out(61));
	XORG60: xor3 port map(data_in(60),data_in(56),data_in(52),data_out(60));
	XORG59: xor3 port map(data_in(63),data_in(59),data_in(55),data_out(59));
	XORG58: xor3 port map(data_in(58),data_in(54),data_in(50),data_out(58));
	XORG57: xor3 port map(data_in(61),data_in(53),data_in(49),data_out(57));
	XORG56: xor3 port map(data_in(60),data_in(56),data_in(48),data_out(56));
	XORG55: xor3 port map(data_in(63),data_in(59),data_in(51),data_out(55));
	XORG54: xor3 port map(data_in(62),data_in(58),data_in(54),data_out(54));
	XORG53: xor3 port map(data_in(57),data_in(53),data_in(49),data_out(53));
	XORG52: xor3 port map(data_in(60),data_in(52),data_in(48),data_out(52));
	XORG51: xor3 port map(data_in(63),data_in(55),data_in(51),data_out(51));
	XORG50: xor3 port map(data_in(62),data_in(58),data_in(50),data_out(50));
	XORG49: xor3 port map(data_in(61),data_in(57),data_in(53),data_out(49));
	XORG48: xor3 port map(data_in(56),data_in(52),data_in(48),data_out(48));
	XORG47: xor3 port map(data_in(47),data_in(43),data_in(39),data_out(47));
	XORG46: xor3 port map(data_in(42),data_in(38),data_in(34),data_out(46));
	XORG45: xor3 port map(data_in(45),data_in(37),data_in(33),data_out(45));
	XORG44: xor3 port map(data_in(44),data_in(40),data_in(32),data_out(44));
	XORG43: xor3 port map(data_in(47),data_in(43),data_in(35),data_out(43));
	XORG42: xor3 port map(data_in(46),data_in(42),data_in(38),data_out(42));
	XORG41: xor3 port map(data_in(41),data_in(37),data_in(33),data_out(41));
	XORG40: xor3 port map(data_in(44),data_in(36),data_in(32),data_out(40));
	XORG39: xor3 port map(data_in(47),data_in(39),data_in(35),data_out(39));
	XORG38: xor3 port map(data_in(46),data_in(42),data_in(34),data_out(38));
	XORG37: xor3 port map(data_in(45),data_in(41),data_in(37),data_out(37));
	XORG36: xor3 port map(data_in(40),data_in(36),data_in(32),data_out(36));
	XORG35: xor3 port map(data_in(43),data_in(39),data_in(35),data_out(35));
	XORG34: xor3 port map(data_in(46),data_in(38),data_in(34),data_out(34));
	XORG33: xor3 port map(data_in(45),data_in(41),data_in(33),data_out(33));
	XORG32: xor3 port map(data_in(44),data_in(40),data_in(36),data_out(32));
	XORG31: xor3 port map(data_in(31),data_in(27),data_in(23),data_out(31));
	XORG30: xor3 port map(data_in(26),data_in(22),data_in(18),data_out(30));
	XORG29: xor3 port map(data_in(29),data_in(21),data_in(17),data_out(29));
	XORG28: xor3 port map(data_in(28),data_in(24),data_in(16),data_out(28));
	XORG27: xor3 port map(data_in(31),data_in(27),data_in(19),data_out(27));
	XORG26: xor3 port map(data_in(30),data_in(26),data_in(22),data_out(26));
	XORG25: xor3 port map(data_in(25),data_in(21),data_in(17),data_out(25));
	XORG24: xor3 port map(data_in(28),data_in(20),data_in(16),data_out(24));
	XORG23: xor3 port map(data_in(31),data_in(23),data_in(19),data_out(23));
	XORG22: xor3 port map(data_in(30),data_in(26),data_in(18),data_out(22));
	XORG21: xor3 port map(data_in(29),data_in(25),data_in(21),data_out(21));
	XORG20: xor3 port map(data_in(24),data_in(20),data_in(16),data_out(20));
	XORG19: xor3 port map(data_in(27),data_in(23),data_in(19),data_out(19));
	XORG18: xor3 port map(data_in(30),data_in(22),data_in(18),data_out(18));
	XORG17: xor3 port map(data_in(29),data_in(25),data_in(17),data_out(17));
	XORG16: xor3 port map(data_in(28),data_in(24),data_in(20),data_out(16));
	XORG15: xor3 port map(data_in(11),data_in(7) ,data_in(3),data_out(15));
	XORG14: xor3 port map(data_in(14),data_in(6) ,data_in(2),data_out(14));
	XORG13: xor3 port map(data_in(13),data_in(9) ,data_in(1),data_out(13));
	XORG12: xor3 port map(data_in(12),data_in(8) ,data_in(4),data_out(12));
	XORG11: xor3 port map(data_in(15),data_in(11),data_in(7),data_out(11));
	XORG10: xor3 port map(data_in(10),data_in(6) ,data_in(2),data_out(10));
	XORG9: xor3 port map(data_in(13),data_in(5) ,data_in(1),data_out(9) );
	XORG8: xor3 port map(data_in(12),data_in(8) ,data_in(0),data_out(8) );
	XORG7: xor3 port map(data_in(15),data_in(11),data_in(3),data_out(7) );
	XORG6: xor3 port map(data_in(14),data_in(10),data_in(6),data_out(6) );
	XORG5: xor3 port map(data_in(9) ,data_in(5) ,data_in(1),data_out(5) );
	XORG4: xor3 port map(data_in(12),data_in(4) ,data_in(0),data_out(4) );
	XORG3: xor3 port map(data_in(15),data_in(7) ,data_in(3),data_out(3) );
	XORG2: xor3 port map(data_in(14),data_in(10),data_in(2),data_out(2) );
	XORG1: xor3 port map(data_in(13),data_in(9) ,data_in(5),data_out(1) );
	XORG0: xor3 port map(data_in(8) ,data_in(4) ,data_in(0),data_out(0) );
end architecture structural;
