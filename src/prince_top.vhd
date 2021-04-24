library ieee;
use ieee.std_logic_1164.all;

-- The top level module of PRINCE
entity prince_top is
	port(data_in:  in std_logic_vector(63 downto 0);  -- 64 bit plaintext block
		key:        in std_logic_vector(127 downto 0); -- 128 bit key
		data_out: out std_logic_vector(63 downto 0)  -- 64 bit encrypted block 
		);
end prince_top;

architecture dataflow of prince_top is
	-- Intermediate signals for splitting the key into the whitening keys k0
	-- and k0_end, and the key k1 which is used in prince_core
	alias k0_start is key(127 downto 64);
	alias k1 is key(63 downto 0);   
	signal k0_end: std_logic_vector(63 downto 0);
	-- Data I/O for prince_core
	signal core_in,
	core_out: std_logic_vector(63 downto 0);
	
	component prince_core
		port(data_in:  in std_logic_vector(63 downto 0);
			key:      in std_logic_vector(63 downto 0);
			data_out: out std_logic_vector(63 downto 0)
			);
	end component;
	
begin
	-- Key extension/whitening keys
	k0_end <= key(64) & key(127 downto 66) & (key(65) xor key(127));
	
	-- PRINCE_core
	core_in <= data_in xor k0_start;
	data_out <= core_out xor k0_end;
	
	PC: prince_core port map(
		data_in => core_in,
		key => k1,
		data_out => core_out
		);
end architecture dataflow;	

architecture structural of prince_top is
	-- Intermediate signals for splitting the key into the whitening keys k0
	-- and k0_end, and the key k1 which is used in prince_core
	alias k0_start is key(127 downto 64);
	alias k1 is key(63 downto 0);
	signal k0_end: std_logic_vector(63 downto 0);
	-- Data I/O for prince_core
	signal core_in,
	core_out: std_logic_vector(63 downto 0);
	
	component prince_core
		port(data_in:  in std_logic_vector(63 downto 0);
			key:      in std_logic_vector(63 downto 0);
			data_out: out std_logic_vector(63 downto 0)
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
begin  
	-- Key extension/whitening keys
	XRK: xor2 port map(key(65),key(127),k0_end(0));
	k0_end(63 downto 1) <= key(64) & key(127 downto 66);
	
	-- PRINCE_core
	CI: xor2_fan port map(data_in,k0_start,core_in);
	DO: xor2_fan port map(core_out,k0_end,data_out);
	
	PC: prince_core port map(
		data_in => core_in,
		key => k1,
		data_out => core_out
		);
end architecture structural;
