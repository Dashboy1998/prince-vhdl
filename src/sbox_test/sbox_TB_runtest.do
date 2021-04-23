SetActiveLib -work
comp -include "$dsn\src\sbox.vhd" 
comp -include "$dsn\src\sbox_test\sbox_TB.vhd" 
asim +access +r TESTBENCH_FOR_sbox 
wave 
wave -noreg data_in
wave -noreg BM_data_out 
wave -noreg DM_data_out
wave -noreg SM_data_out
wave -noreg DM_Error
wave -noreg SM_Error
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\sbox_test\sbox_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_sbox 
