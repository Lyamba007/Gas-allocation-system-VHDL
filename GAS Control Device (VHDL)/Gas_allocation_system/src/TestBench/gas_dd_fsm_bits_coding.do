SetActiveLib -work
comp -include "$dsn\src\GAS_Diagnostic_Device and TB\GAS_Diagnostic_Device.vhd" 
comp -include "$dsn\src\GAS_Diagnostic_Device and TB\GAS_DD_FSM.vhd" 
comp -include "$dsn\src\TestBench\gas_dd_fsm_TB.vhd" 
asim +access +r TESTBENCH_FOR_gas_dd_fsm 
wave 
wave -noreg clk
wave -noreg reset
wave -noreg D
wave -noreg Yx
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\gas_dd_fsm_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_gas_dd_fsm 
