# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {Common 17-41} -limit 10000000
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir D:/ECOP/hw2/led_8lights/led_8lights.cache/wt [current_project]
set_property parent.project_path D:/ECOP/hw2/led_8lights/led_8lights.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property vhdl_version vhdl_2k [current_fileset]
read_verilog -library xil_defaultlib {
  D:/ECOP/hw2/led_8lights/led_8lights.srcs/sources_1/new/decoder38.v
  D:/ECOP/hw2/led_8lights/led_8lights.srcs/sources_1/new/clcok_div.v
  D:/ECOP/hw2/led_8lights/led_8lights.srcs/sources_1/new/counter8.v
  D:/ECOP/hw2/led_8lights/led_8lights.srcs/sources_1/new/led_8lights.v
}
read_xdc D:/ECOP/hw2/led_8lights/led_8lights.srcs/constrs_1/new/led_8lights.xdc
set_property used_in_implementation false [get_files D:/ECOP/hw2/led_8lights/led_8lights.srcs/constrs_1/new/led_8lights.xdc]

synth_design -top led_8lights -part xc7a35tcpg236-1
write_checkpoint -noxdef led_8lights.dcp
catch { report_utilization -file led_8lights_utilization_synth.rpt -pb led_8lights_utilization_synth.pb }
