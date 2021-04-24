SetActiveLib -work
comp -include "$dsn\src\Gates\delays.vhd" 
comp -include "$dsn\src\constants.vhd" 
comp -include "$dsn\src\Gates\xor3.vhd" 
comp -include "$dsn\src\Gates\or4.vhd" 
comp -include "$dsn\src\Gates\or3.vhd" 
comp -include "$dsn\src\Gates\and3.vhd" 
comp -include "$dsn\src\Gates\and2.vhd" 
comp -include "$dsn\src\Gates\not1.vhd" 
comp -include "$dsn\src\sbox_inv.vhd" 
comp -include "$dsn\src\linear_mprime.vhd" 
comp -include "$dsn\src\linear_m_inv.vhd" 
comp -include "$dsn\src\Gates\or5.vhd" 
comp -include "$dsn\src\sbox.vhd" 
comp -include "$dsn\src\Gates\xor3_fan.vhd" 
comp -include "$dsn\src\linear_m.vhd" 
comp -include "$dsn\src\Gates\xor2.vhd" 
comp -include "$dsn\src\prince_core.vhd" 
comp -include "$dsn\src\Gates\xor2_fan.vhd" 
comp -include "$dsn\src\prince_top.vhd" 
comp -include "$dsn\src\TestBench\prince_top_TB.vhd" 
asim +access +r TESTBENCH_FOR_prince_top 
wave 
wave -noreg data_in
wave -noreg key
wave -noreg data_out
wave -noreg expected
wave -noreg counter
wave -noreg error
wave -noreg CLK
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\prince_top_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_prince_top 
