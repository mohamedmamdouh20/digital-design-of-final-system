onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {tb signals} /UART_RX_tb/CLK_tb
add wave -noupdate -expand -group {tb signals} /UART_RX_tb/PAR_EN_tb
add wave -noupdate -expand -group {tb signals} /UART_RX_tb/PAR_TYP_tb
add wave -noupdate -expand -group {tb signals} /UART_RX_tb/P_DATA_tb
add wave -noupdate -expand -group {tb signals} /UART_RX_tb/RST_tb
add wave -noupdate -expand -group {tb signals} /UART_RX_tb/RX_IN_tb
add wave -noupdate -expand -group {tb signals} /UART_RX_tb/data_valid_tb
add wave -noupdate -expand -group {tb signals} /UART_RX_tb/parity_ext_err
add wave -noupdate -expand -group {tb signals} /UART_RX_tb/start_ext_err
add wave -noupdate -expand -group {tb signals} /UART_RX_tb/stop_ext_err
add wave -noupdate -expand -group {tb signals} -radix unsigned /UART_RX_tb/prescale_tb
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/U0_FSM_rx/CLK
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/U0_FSM_rx/RST
add wave -noupdate -expand -group FSM -radix unsigned /UART_RX_tb/DUT/U0_FSM_rx/bit_count
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/U0_FSM_rx/current_state
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/U0_FSM_rx/data_sampling_en
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/U0_FSM_rx/data_valid
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/U0_FSM_rx/data_valid_internal
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/U0_FSM_rx/deserializer_en
add wave -noupdate -expand -group FSM -radix unsigned /UART_RX_tb/DUT/U0_FSM_rx/edge_bit_counter_en
add wave -noupdate -expand -group FSM -radix unsigned /UART_RX_tb/DUT/U0_FSM_rx/edge_count
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/U0_FSM_rx/next_state
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/U0_FSM_rx/par_en
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/U0_FSM_rx/par_err
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/U0_FSM_rx/parity_check_en
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/U0_FSM_rx/parity_err_internal
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/U0_FSM_rx/rx_in
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/U0_FSM_rx/start_check_en
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/U0_FSM_rx/start_glitch
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/U0_FSM_rx/start_glitch_internal
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/U0_FSM_rx/stop_check_en
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/U0_FSM_rx/stop_err
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/U0_FSM_rx/stop_err_internal
add wave -noupdate -expand -group {data sampler} /UART_RX_tb/DUT/U0_data_sampling_rx/CLK
add wave -noupdate -expand -group {data sampler} /UART_RX_tb/DUT/U0_data_sampling_rx/RST
add wave -noupdate -expand -group {data sampler} /UART_RX_tb/DUT/U0_data_sampling_rx/data_sample_en
add wave -noupdate -expand -group {data sampler} -radix unsigned /UART_RX_tb/DUT/U0_data_sampling_rx/edge_count
add wave -noupdate -expand -group {data sampler} /UART_RX_tb/DUT/U0_data_sampling_rx/prescale
add wave -noupdate -expand -group {data sampler} /UART_RX_tb/DUT/U0_data_sampling_rx/rx_in
add wave -noupdate -expand -group {data sampler} /UART_RX_tb/DUT/U0_data_sampling_rx/rx_sample_1
add wave -noupdate -expand -group {data sampler} /UART_RX_tb/DUT/U0_data_sampling_rx/rx_sample_2
add wave -noupdate -expand -group {data sampler} /UART_RX_tb/DUT/U0_data_sampling_rx/rx_sample_3
add wave -noupdate -expand -group {data sampler} /UART_RX_tb/DUT/U0_data_sampling_rx/sampled_data
add wave -noupdate -expand -group deserializer /UART_RX_tb/DUT/U0_deserializer_rx/deserializer_en
add wave -noupdate -expand -group deserializer /UART_RX_tb/DUT/U0_deserializer_rx/CLK
add wave -noupdate -expand -group deserializer /UART_RX_tb/DUT/U0_deserializer_rx/RST
add wave -noupdate -expand -group deserializer /UART_RX_tb/DUT/U0_deserializer_rx/sampled_bit_in
add wave -noupdate -expand -group deserializer /UART_RX_tb/DUT/U0_deserializer_rx/p_data
add wave -noupdate -expand -group {parity check} /UART_RX_tb/DUT/U0_par_check_rx/par_typ
add wave -noupdate -expand -group {parity check} /UART_RX_tb/DUT/U0_par_check_rx/parallel_data
add wave -noupdate -expand -group {parity check} /UART_RX_tb/DUT/U0_par_check_rx/par_check_en
add wave -noupdate -expand -group {parity check} /UART_RX_tb/DUT/U0_par_check_rx/parity_bit
add wave -noupdate -expand -group {parity check} /UART_RX_tb/DUT/U0_par_check_rx/parity_error
add wave -noupdate -expand -group {stop check} /UART_RX_tb/DUT/U0_stop_check_rx/stop_bit
add wave -noupdate -expand -group {stop check} /UART_RX_tb/DUT/U0_stop_check_rx/stop_check_en
add wave -noupdate -expand -group {stop check} /UART_RX_tb/DUT/U0_stop_check_rx/stop_err
add wave -noupdate -expand -group edge_bit_counter /UART_RX_tb/DUT/U0_edge_bit_counter_rx/CLK
add wave -noupdate -expand -group edge_bit_counter /UART_RX_tb/DUT/U0_edge_bit_counter_rx/RST
add wave -noupdate -expand -group edge_bit_counter /UART_RX_tb/DUT/U0_edge_bit_counter_rx/enable
add wave -noupdate -expand -group edge_bit_counter -radix unsigned /UART_RX_tb/DUT/U0_edge_bit_counter_rx/prescaler
add wave -noupdate -expand -group edge_bit_counter -radix unsigned /UART_RX_tb/DUT/U0_edge_bit_counter_rx/bit_counter
add wave -noupdate -expand -group edge_bit_counter -radix unsigned /UART_RX_tb/DUT/U0_edge_bit_counter_rx/edge_counter
add wave -noupdate -expand -group start_check /UART_RX_tb/DUT/U0_start_check_rx/start_check_en
add wave -noupdate -expand -group start_check /UART_RX_tb/DUT/U0_start_check_rx/start_bit
add wave -noupdate -expand -group start_check /UART_RX_tb/DUT/U0_start_check_rx/start_glitch
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1722580 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 137
configure wave -valuecolwidth 188
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
WaveRestoreZoom {1722466 ns} {1723013 ns}
