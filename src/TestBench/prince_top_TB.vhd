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
		CLK : in STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal data_in : STD_LOGIC_VECTOR(63 downto 0);
	signal key : STD_LOGIC_VECTOR(127 downto 0);
	signal CLK : STD_LOGIC:='0';
	-- Observed signals - signals mapped to the output ports of tested entity
	signal data_out : STD_LOGIC_VECTOR(63 downto 0);

	-- Add your code here ...
	signal expected: std_logic_vector(63 downto 0);
	signal counter: natural:=0; -- Used to track test number
	signal error: boolean:=false;
begin

	-- Unit Under Test port map
	UUT : prince_top
		port map (
			data_in => data_in,
			key => key,
			data_out => data_out,
			CLK => CLK
		);

	-- Add your stimulus here ...
	process
	begin
		wait until rising_edge(CLK);
		data: for j in 0 to 499 loop
			counter <= j;
			data_in <= tests(j).plain;
			key <= tests(j).key;
			expected <= tests(j).cipher;
			
			wait until rising_edge(CLK);
			error <= expected /= data_out;
		end loop data;
		report "End of Test" severity failure;
	end process;
	
	CLOCK: process
	begin			  
		wait for 20ns;
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

