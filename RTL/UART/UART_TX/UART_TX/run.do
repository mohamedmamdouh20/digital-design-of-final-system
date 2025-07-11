vlib work
vlog *.*v
vsim -voptargs=_acc work.UART_TX_tb
do wave.do
run -all