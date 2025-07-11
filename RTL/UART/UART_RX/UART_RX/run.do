vlib work
vlog *.*v
vsim -voptargs=_acc work.UART_RX_tb
do wave.do
run -all