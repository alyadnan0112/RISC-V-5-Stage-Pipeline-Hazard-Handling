

-sv
-timescale 1ns/1ps

// ---- leaf / pipeline-register modules ----
Program_counter.sv
PC_calculation.sv
imm_and_pc_mux.sv
instruction_memory.sv
IF_ID.sv
immediate_extension.sv
Register_file.sv
imm_and_rs2_mux.sv
control_unit.sv
alu_control.sv
alu.sv
Data_memory.sv
ALU_and_mem_mux.sv
ID_IE.sv
IE_MEM.sv
MEM_WB.sv
data_hazard.sv
ForwardA_mux.sv
ForwardB_mux.sv

// ---- top-level DUT ----
top.sv

// ---- testbench ----
top_tb.sv

// ---- simulation top ----
-top top_tb