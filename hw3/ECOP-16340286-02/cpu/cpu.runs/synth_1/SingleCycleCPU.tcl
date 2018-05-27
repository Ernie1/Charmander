# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir Y:/ECOP/hw3/cpu/cpu.cache/wt [current_project]
set_property parent.project_path Y:/ECOP/hw3/cpu/cpu.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property vhdl_version vhdl_2k [current_fileset]
read_verilog -library xil_defaultlib {
  Y:/ECOP/hw3/cpu/cpu.srcs/sources_1/new/InstructionMemory.v
  Y:/ECOP/hw3/cpu/cpu.srcs/sources_1/new/SignZeroExtend.v
  Y:/ECOP/hw3/cpu/cpu.srcs/sources_1/new/RegisterFile.v
  Y:/ECOP/hw3/cpu/cpu.srcs/sources_1/new/DataMemory.v
  Y:/ECOP/hw3/cpu/cpu.srcs/sources_1/new/ControlUnit.v
  Y:/ECOP/hw3/cpu/cpu.srcs/sources_1/new/ALU.v
  Y:/ECOP/hw3/cpu/cpu.srcs/sources_1/new/PC.v
  Y:/ECOP/hw3/cpu/cpu.srcs/sources_1/new/SingleCycleCPU.v
}
synth_design -top SingleCycleCPU -part xc7a35tcpg236-1
write_checkpoint -noxdef SingleCycleCPU.dcp
catch { report_utilization -file SingleCycleCPU_utilization_synth.rpt -pb SingleCycleCPU_utilization_synth.pb }