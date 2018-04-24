@echo off
set xv_path=D:\\Xilinx\\Vivado\\2015.3\\bin
call %xv_path%/xelab  -wto 17a9330877934091a51653cfc7f2a750 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot led_sim_behav xil_defaultlib.led_sim xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
