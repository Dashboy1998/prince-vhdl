library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
	-- Add your library and packages declaration here ...

entity linear_mprime_tb is
end linear_mprime_tb;

architecture TB_ARCHITECTURE of linear_mprime_tb is
	-- Component declaration of the tested unit
	component linear_mprime
	port(
		data_in : in STD_LOGIC_VECTOR(63 downto 0);
		data_out : out STD_LOGIC_VECTOR(63 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal data_in : STD_LOGIC_VECTOR(63 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal DM_data_out, SM_data_out : STD_LOGIC_VECTOR(63 downto 0);

	-- Add your code here ...
	signal SM_Error: boolean := false; 
begin

	-- Unit Under Test port map
	DM : linear_mprime
		port map (
			data_in => data_in,
			data_out => DM_data_out
		);

	SM : linear_mprime
	port map (
		data_in => data_in,
		data_out => SM_data_out
	);

	-- Add your stimulus here ...
	process
	begin
		for i in 0 to 256 loop
			data_in <= std_logic_vector(to_unsigned(i*7919,data_in'length));
			wait for 10ns;			
			if DM_data_out /= SM_data_out then
				SM_Error <= true;  	
			else
				SM_Error <= false;
			end if;
		end loop;
	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_linear_mprime of linear_mprime_tb is
	for TB_ARCHITECTURE
		for DM : linear_mprime
			use entity work.linear_mprime(dataflow);
		end for;
		for SM : linear_mprime
			use entity work.linear_mprime(structural);
		end for;
	end for;
end TESTBENCH_FOR_linear_mprime;

