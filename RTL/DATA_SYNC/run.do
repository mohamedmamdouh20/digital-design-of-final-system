vlib work
vlog *.*v
vsim -voptargs=_acc work.DATA_SYNC_tb
do wave.do
run -all