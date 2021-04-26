library ieee;
use ieee.std_logic_1164.all; 
use work.constants.all;

-- The top level module of PRINCE
entity prince_top is
	port(data_in:  in std_logic_vector(63 downto 0);  -- 64 bit plaintext block
		key:        in std_logic_vector(127 downto 0); -- 128 bit key
		data_out: out std_logic_vector(63 downto 0);  -- 64 bit encrypted block
		decrypt: in std_logic;
		CLK: in std_logic
		);
end prince_top;

architecture structural of prince_top is
	-- Intermediate signals for splitting the key into the whitening keys k0
	-- and k0_end, and the key k1 which is used in prince_core
	alias k0 is key(127 downto 64);
	alias k1 is key(63 downto 0);
	signal k0_start: std_logic_vector(63 downto 0); -- key used in first XOR
	signal key_core: std_logic_vector(63 downto 0); -- Key used in Encryption/Decryption core rounds
	signal k0_prime: std_logic_vector(63 downto 0); 
	signal k0_end: std_logic_vector(63 downto 0); -- Value used in last XOR
	signal decrypt_vector: std_logic_vector(63 downto 0); 
	signal xor_val: std_logic_vector(63 downto 0);
	-- Data I/O for prince_core
	signal core_in,
	core_out: std_logic_vector(63 downto 0);
	
	component prince_core
		port(data_in:  in std_logic_vector(63 downto 0);
			key:      in std_logic_vector(63 downto 0);
			data_out: out std_logic_vector(63 downto 0);
			CLK: in std_logic
			);
	end component;
	component xor2
		port( 
		A, B: in std_logic;
		Z: out std_logic 
		);
	end component xor2;
	component xor2_fan
		port( 
		A, B: in std_logic_vector;
		Z: out std_logic_vector 
		);
	end component xor2_fan;
	component and2_fan
		port( 
		A, B: in std_logic_vector;
		Z: out std_logic_vector 
		);
	end component and2_fan;
	component mux2_fan
		port( 
		A, B: in std_logic_vector;
		S: in std_logic;
		Z: out std_logic_vector 
		);
	end component mux2_fan;
begin
	decrypt_vector <= (others => decrypt); 
	XV: and2_fan port map(alpha,decrypt_vector,xor_val);
	KC: xor2_fan port map(k1,xor_val,key_core); -- XOR K1
	
	KS: mux2_fan port map(k0,k0_prime,decrypt,k0_start);
	KE: mux2_fan port map(k0_prime,k0,decrypt,k0_end);	

	-- Key extension/whitening keys
	XRK: xor2 port map(key(65),key(127),k0_prime(0));
	k0_prime(63 downto 1) <= key(64) & key(127 downto 66);
	
	-- PRINCE_core
	CI: xor2_fan port map(data_in,k0_start,core_in);
	DO: xor2_fan port map(core_out,k0_end,data_out);
	
	PC: prince_core port map(
		data_in => core_in,
		key => key_core,
		data_out => core_out,
		CLK => CLK
		);
end architecture structural;
