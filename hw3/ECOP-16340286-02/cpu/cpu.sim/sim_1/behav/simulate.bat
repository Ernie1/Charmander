@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.3\\bin
call %xv_path%/xsim cpu_sim_behav -key {Behavioral:sim_1:Functional:cpu_sim} -tclbatch cpu_sim.tcl -view Y:/ECOP/hw3/ECOP-16340286-02/cpu/cpu_sim_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
