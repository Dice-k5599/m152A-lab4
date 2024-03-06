# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param xicom.use_bs_reader 1
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/Student/Desktop/team_15_w24/lab4_whack_a_mole/lab4_whack_a_mole.cache/wt [current_project]
set_property parent.project_path C:/Users/Student/Desktop/team_15_w24/lab4_whack_a_mole/lab4_whack_a_mole.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo c:/Users/Student/Desktop/team_15_w24/lab4_whack_a_mole/lab4_whack_a_mole.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib {
  C:/Users/Student/Desktop/team_15_w24/lab4_whack_a_mole/lab4_whack_a_mole.srcs/sources_1/new/wam_cnt.v
  C:/Users/Student/Desktop/team_15_w24/lab4_whack_a_mole/lab4_whack_a_mole.srcs/sources_1/new/wam_dis.v
  C:/Users/Student/Desktop/team_15_w24/lab4_whack_a_mole/lab4_whack_a_mole.srcs/sources_1/new/wam_gen.v
  C:/Users/Student/Desktop/team_15_w24/lab4_whack_a_mole/lab4_whack_a_mole.srcs/sources_1/new/wam_hit.v
  C:/Users/Student/Desktop/team_15_w24/lab4_whack_a_mole/lab4_whack_a_mole.srcs/sources_1/new/wam_hrd.v
  C:/Users/Student/Desktop/team_15_w24/lab4_whack_a_mole/lab4_whack_a_mole.srcs/sources_1/new/wam_led.v
  C:/Users/Student/Desktop/team_15_w24/lab4_whack_a_mole/lab4_whack_a_mole.srcs/sources_1/new/wam_lst.v
  C:/Users/Student/Desktop/team_15_w24/lab4_whack_a_mole/lab4_whack_a_mole.srcs/sources_1/new/wam_obd.v
  C:/Users/Student/Desktop/team_15_w24/lab4_whack_a_mole/lab4_whack_a_mole.srcs/sources_1/new/wam_par.v
  C:/Users/Student/Desktop/team_15_w24/lab4_whack_a_mole/lab4_whack_a_mole.srcs/sources_1/new/wam_rdn.v
  C:/Users/Student/Desktop/team_15_w24/lab4_whack_a_mole/lab4_whack_a_mole.srcs/sources_1/new/wam_scr.v
  C:/Users/Student/Desktop/team_15_w24/lab4_whack_a_mole/lab4_whack_a_mole.srcs/sources_1/new/wam_tap.v
  C:/Users/Student/Desktop/team_15_w24/lab4_whack_a_mole/lab4_whack_a_mole.srcs/sources_1/new/wam_tch.v
  C:/Users/Student/Desktop/team_15_w24/lab4_whack_a_mole/lab4_whack_a_mole.srcs/sources_1/new/wam_m.v
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/Student/Desktop/team_15_w24/lab4_whack_a_mole/lab4_whack_a_mole.srcs/constrs_1/new/Basys-3-Master.xdc
set_property used_in_implementation false [get_files C:/Users/Student/Desktop/team_15_w24/lab4_whack_a_mole/lab4_whack_a_mole.srcs/constrs_1/new/Basys-3-Master.xdc]

set_param ips.enableIPCacheLiteLoad 0
close [open __synthesis_is_running__ w]

synth_design -top wam_m -part xc7a35tcpg236-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef wam_m.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file wam_m_utilization_synth.rpt -pb wam_m_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
