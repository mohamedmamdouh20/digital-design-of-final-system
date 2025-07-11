vlib work
vlog *.*v
vsim -voptargs=_acc work.SYS_tb
do wave.do
run -all