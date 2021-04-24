library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

-- The cipher without the key whitening layer
entity prince_core is
	port(data_in:  in std_logic_vector(63 downto 0);
		key:      in std_logic_vector(63 downto 0);
		data_out: out std_logic_vector(63 downto 0);
		CLK: in std_logic
		);
end prince_core;

architecture structural of prince_core is
	-- Signals for transporting the data between rounds
	signal ims: intermediate_signals;
	signal middle1, middle2: std_logic_vector(63 downto 0);
	
	-- Required component declarations
	component sbox
		port(data_in:  in std_logic_vector(3 downto 0);
			data_out: out std_logic_vector(3 downto 0)
			);
	end component;
	
	component sbox_inv
		port(data_in:  in std_logic_vector(3 downto 0);
			data_out: out std_logic_vector(3 downto 0)
			);
	end component;
	
	component linear_m
		port(data_in:  in std_logic_vector(63 downto 0);
			data_out: out std_logic_vector(63 downto 0)
			);
	end component;
	
	component linear_m_inv
		port(data_in:  in std_logic_vector(63 downto 0);
			data_out: out std_logic_vector(63 downto 0)
			);
	end component;
	
	component linear_mprime
		port(data_in:  in std_logic_vector(63 downto 0);
			data_out:  out std_logic_vector(63 downto 0)
			);
	end component;
	component xor3_fan
		port( 
		A, B, C: in std_logic_vector;
		Z: out std_logic_vector 
		);
	end component xor3_fan;
begin
	-- Round 0
	R0: xor3_fan port map (data_in,key,rcs(0),ims(0));
	
	-- Round 1 to 5
	FIRST_HALF: for i in 1 to 5 generate
		signal sb_out, m_out: std_logic_vector(63 downto 0);
		
		begin
		SB_FH: for j in 0 to 15 generate
			SX_FH: sbox port map(
				data_in => ims(i - 1)(63 - 4*j downto 63 - 4*j - 3),
				data_out => sb_out(63 - 4*j downto 63 - 4*j - 3)
				);
		end generate;
		
		LIN_M: linear_m port map(
			data_in => sb_out,
			data_out => m_out
			);
		RI: xor3_fan port map (m_out,key,rcs(i),ims(i));
	end generate;
	
	-- Middle layer
	SB_MID: for i in 0 to 15 generate
		SX_M1: sbox port map(
			data_in => ims(5)(63 - 4*i downto 63 - 4*i - 3),
			data_out => middle1(63 - 4*i downto 63 - 4*i - 3)
			);
	end generate;
	
	MP_MID: linear_mprime port map(
		data_in => middle1,
		data_out => middle2
		);
	
	SB_MID_INV: for i in 0 to 15 generate
		SX_M2: sbox_inv port map(
			data_in => middle2(63 - 4*i downto 63 - 4*i - 3),
			data_out => ims(6)(63 - 4*i downto 63 - 4*i - 3)
			);
	end generate;
	
	-- Round 6 to 10
	SECOND_HALF: for i in 6 to 10 generate
		signal m_in, sb_in: std_logic_vector(63 downto 0);
		
		begin
		m_in <= ims(i) xor key xor rcs(i);
		
		LIN_M_INV: linear_m_inv port map(
			data_in => m_in,
			data_out => sb_in
			);
		
		SB_SH: for j in 0 to 15 generate
			SX_SH: sbox_inv port map(
				data_in => sb_in(63 - 4*j downto 63 - 4*j - 3),
				data_out => ims(i + 1)(63 - 4*j downto 63 - 4*j - 3)
				);
		end generate;
	end generate;
	
	-- Round 11
	R11: xor3_fan port map (key,rcs(11),ims(11),data_out);
end architecture structural;