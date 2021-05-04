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
	--signal ims: intermediate_signals;
	signal ims_D: intermediate_signals;
	signal ims_Q: intermediate_signals;
	signal ims_key: intermediate_signals;
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
	component dff_fan
		port( 
		D: in std_logic_vector;
		CLK: in std_logic;
		Q: out std_logic_vector 
		);
	end component dff_fan;
begin
	-- Round 0
	R0: xor3_fan port map (data_in,ims_key(0),rcs(0),ims_D(0));
	D0: dff_fan port map (ims_D(0),CLK,ims_Q(0));
	ims_key(0) <= key;
	
	-- Round 1 to 5
	FIRST_HALF: for i in 1 to 5 generate
		signal sb_out, m_out: std_logic_vector(63 downto 0);
		
		begin
		SB_FH: for j in 0 to 15 generate
			SX_FH: sbox port map(
				data_in => ims_Q(i - 1)(63 - 4*j downto 63 - 4*j - 3),
				data_out => sb_out(63 - 4*j downto 63 - 4*j - 3)
				);
		end generate;
		
		LIN_M: linear_m port map(
			data_in => sb_out,
			data_out => m_out
			);
		RI: xor3_fan port map (m_out,ims_key(i),rcs(i),ims_D(i));
		DKX: dff_fan port map (ims_key(i-1),CLK,ims_key(i));
	end generate;
	
	-- Middle layer
	SB_MID: for i in 0 to 15 generate
		SX_M1: sbox port map(
			data_in => ims_Q(5)(63 - 4*i downto 63 - 4*i - 3),
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
			data_out => ims_D(6)(63 - 4*i downto 63 - 4*i - 3)
			);
	end generate;
	
	-- Round 6 to 10
	SECOND_HALF: for i in 6 to 10 generate
		signal m_in, sb_in: std_logic_vector(63 downto 0);
		
		begin
		m_in <= ims_Q(i) xor ims_key(i-1) xor rcs(i);
		
		LIN_M_INV: linear_m_inv port map(
			data_in => m_in,
			data_out => sb_in
			);
		
		SB_SH: for j in 0 to 15 generate
			SX_SH: sbox_inv port map(
				data_in => sb_in(63 - 4*j downto 63 - 4*j - 3),
				data_out => ims_D(i + 1)(63 - 4*j downto 63 - 4*j - 3)
				);
		end generate;
		DKX: dff_fan port map (ims_key(i-1),CLK,ims_key(i));
	end generate;
	
	-- Round 11
	R11: xor3_fan port map (ims_key(11),rcs(11),ims_Q(11),data_out);
	DK11: dff_fan port map (ims_key(10),CLK,ims_key(11));

	-- Data Flip Flops
	Data_FF: for i in 0 to 11 generate
		DX: dff_fan port map (ims_D(i),CLK,ims_Q(i));
	end generate;
end architecture structural;