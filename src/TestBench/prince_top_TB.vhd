library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...
use work.prince_cipher_pkg.all;

entity prince_top_tb is
end prince_top_tb;

architecture TB_ARCHITECTURE of prince_top_tb is
	-- Component declaration of the tested unit
	component prince_top
	port(
		data_in : in STD_LOGIC_VECTOR(63 downto 0);
		key : in STD_LOGIC_VECTOR(127 downto 0);
		data_out : out STD_LOGIC_VECTOR(63 downto 0);
		decrypt: in std_logic;
		CLK : in STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal data_in : STD_LOGIC_VECTOR(63 downto 0);
	signal key : STD_LOGIC_VECTOR(127 downto 0);
	signal decrypt: std_logic;
	signal CLK : STD_LOGIC:='0';
	-- Observed signals - signals mapped to the output ports of tested entity
	signal data_out : STD_LOGIC_VECTOR(63 downto 0);

	-- Add your code here ...
	signal expected: std_logic_vector(63 downto 0);
	signal counter: natural:=0; -- Used to track test number
	signal error: boolean:=false; 
	signal first_done: boolean:=false;
begin

	-- Unit Under Test port map
	UUT : prince_top
		port map (
			data_in => data_in,
			key => key,
			data_out => data_out,
			decrypt => decrypt,
			CLK => CLK
		);

	-- Add your stimulus here ...
	process
	variable first_done: boolean:=false;
	begin
		Enc_dec: for i in 0 to 1 loop
			wait until rising_edge(CLK);
			if i = 0 then 
				decrypt <= '0'; 
			else 
				decrypt <= '1'; 
			end if;
			data: for j in 0 to 499 loop
				if counter >= 12 then
					first_done := true;
				end if;
				if first_done then
					if i = 1 and j <= 12 then
						error <= tests(499-12+j).cipher /= data_out;
						expected <= tests(499-12+j).cipher;
					elsif i = 0 then
						error <= tests(j-13).cipher /= data_out; 
						expected <= tests(j-13).cipher;
					elsif i = 1 then
						error <= tests(j-12).plain /= data_out;	
						expected <= tests(j-12).plain;
					end if;
				end if;
				
				counter <= j;
				data_in <= tests(j).plain when i = 0 else tests(j).cipher;
				key <= tests(j).key;
				
				
				wait until rising_edge(CLK);
			end loop data;
		end loop Enc_dec;
		-- Loop to wait for last data
		for i in 0 to 14 loop 
			wait until rising_edge(CLK);	
		end loop;
		report "End of Test" severity failure;
	end process;
	
	CLOCK: process
	begin			  
		wait for 50ns;
		CLK <= not CLK;
	end process;
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_prince_top of prince_top_tb is
	for TB_ARCHITECTURE
		for UUT : prince_top
			use entity work.prince_top(structural);
		end for;
	end for;
end TESTBENCH_FOR_prince_top;

