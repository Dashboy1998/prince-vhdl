library ieee;
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;

	-- Add your library and packages declaration here ...

entity sbox_tb is
end sbox_tb;

architecture TB_ARCHITECTURE of sbox_tb is
	-- Component declaration of the tested unit
	component sbox
	port(
		data_in : in STD_LOGIC_VECTOR(3 downto 0);
		data_out : out STD_LOGIC_VECTOR(3 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal data_in : STD_LOGIC_VECTOR(3 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal BM_data_out, DM_data_out, SM_data_out : STD_LOGIC_VECTOR(3 downto 0);

	-- Add your code here ...
	signal DM_Error, SM_Error: boolean := false; 
begin

	-- Unit Under Test port map
	BM : sbox
		port map (
			data_in => data_in,
			data_out => BM_data_out
		);
	DM : sbox
		port map (
			data_in => data_in,
			data_out => DM_data_out
		);
	SM : sbox
		port map (
			data_in => data_in,
			data_out => SM_data_out
		);
		
	-- Add your stimulus here ...
	
	process
	begin
		for i in 0 to 15 loop
			data_in <= std_logic_vector(to_unsigned(i,data_in'length));
			wait for 10ns;			
			if BM_data_out /= DM_data_out then
				DM_Error <= true;  	
			else
				DM_Error <= false;
			end if;
			if BM_data_out /= SM_data_out then
				SM_Error <= true;  	
			else
				SM_Error <= false;
			end if;
		end loop;
	end process;
	
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_sbox of sbox_tb is
	for TB_ARCHITECTURE
		for BM : sbox
			use entity work.sbox(behavioral);
		end for;
		for DM : sbox
			use entity work.sbox(dataflow);
		end for;
		for SM : sbox
			use entity work.sbox(structural);
		end for;
	end for;
end TESTBENCH_FOR_sbox;

