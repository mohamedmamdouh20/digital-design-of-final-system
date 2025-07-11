onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /DATA_SYNC_tb/CLK_tb
add wave -noupdate -expand -group tb /DATA_SYNC_tb/RST_tb
add wave -noupdate -expand -group tb /DATA_SYNC_tb/bus_enable_tb
add wave -noupdate -expand -group tb /DATA_SYNC_tb/enable_pulse_tb
add wave -noupdate -expand -group tb /DATA_SYNC_tb/sync_bus_tb
add wave -noupdate -expand -group tb /DATA_SYNC_tb/unsync_bus_tb
add wave -noupdate -expand -group dut /DATA_SYNC_tb/DUT/bus_enable
add wave -noupdate -expand -group dut /DATA_SYNC_tb/DUT/enable_pulse
add wave -noupdate -expand -group dut /DATA_SYNC_tb/DUT/enable_pulse_reg
add wave -noupdate -expand -group dut /DATA_SYNC_tb/DUT/pulse_gen_ff
add wave -noupdate -expand -group dut /DATA_SYNC_tb/DUT/sync_bus
add wave -noupdate -expand -group dut /DATA_SYNC_tb/DUT/synchronizers_ff
add wave -noupdate -expand -group dut /DATA_SYNC_tb/DUT/mux_op
add wave -noupdate -expand -group dut /DATA_SYNC_tb/DUT/unsync_bus
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {45 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 201
configure wave -valuecolwidth 176
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {148 ps}
