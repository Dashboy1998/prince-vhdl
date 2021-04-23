SetActiveLib -work
comp -include "$dsn\src\linear_mprime.vhd" 
comp -include "$dsn\src\linear_mprime_test\linear_mprime_TB.vhd" 
asim +access +r TESTBENCH_FOR_linear_mprime 
wave 
wave -noreg data_in
wave -noreg DM_data_out
wave -noreg SM_data_out
wave -noreg SM_Error
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\linear_mprime_test\linear_mprime_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_linear_mprime 
