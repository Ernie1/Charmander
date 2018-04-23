proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {Common 17-41} -limit 10000000
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  open_checkpoint led_8lights_placed.dcp
  set_property webtalk.parent_dir D:/ECOP/hw2/led_8lights/led_8lights.cache/wt [current_project]
  route_design 
  write_checkpoint -force led_8lights_routed.dcp
  report_drc -file led_8lights_drc_routed.rpt -pb led_8lights_drc_routed.pb
  report_timing_summary -warn_on_violation -max_paths 10 -file led_8lights_timing_summary_routed.rpt -rpx led_8lights_timing_summary_routed.rpx
  report_power -file led_8lights_power_routed.rpt -pb led_8lights_power_summary_routed.pb
  report_route_status -file led_8lights_route_status.rpt -pb led_8lights_route_status.pb
  report_clock_utilization -file led_8lights_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  catch { write_mem_info -force led_8lights.mmi }
  write_bitstream -force led_8lights.bit -bin_file
  catch { write_sysdef -hwdef led_8lights.hwdef -bitfile led_8lights.bit -meminfo led_8lights.mmi -file led_8lights.sysdef }
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

