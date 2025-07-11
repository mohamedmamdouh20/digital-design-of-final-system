onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {test bench} /SYS_tb/RST_N_tb
add wave -noupdate -expand -group {test bench} /SYS_tb/UART_CLK_tb
add wave -noupdate -expand -group {test bench} /SYS_tb/UART_RX_IN_tb
add wave -noupdate -expand -group {test bench} /SYS_tb/UART_TX_O_tb
add wave -noupdate -expand -group {test bench} /SYS_tb/framing_error_tb
add wave -noupdate -expand -group {test bench} /SYS_tb/parity_error_tb
add wave -noupdate -expand -group {test bench} /SYS_tb/REF_CLK_tb
add wave -noupdate -group {TX_CLK
} /SYS_tb/DUT/UART_TOP_U0/UART_TX_TOP_U0/CLK
add wave -noupdate -group {TX_CLK
} /SYS_tb/DUT/clock_divider_TX_U0/o_div_clk
add wave -noupdate -expand -group {FIFO_CHECK
} /SYS_tb/DUT/system_control_U0/CLK
add wave -noupdate -expand -group {FIFO_CHECK
} /SYS_tb/DUT/system_control_U0/RdEN
add wave -noupdate -expand -group {FIFO_CHECK
} /SYS_tb/DUT/UART_TOP_U0/UART_TX_TOP_U0/U0_FSM/busy
add wave -noupdate -expand -group {FIFO_CHECK
} /SYS_tb/DUT/UART_TOP_U0/UART_TX_TOP_U0/U0_FSM/busy_op
add wave -noupdate -expand -group {FIFO_CHECK
} /SYS_tb/DUT/UART_TOP_U0/UART_TX_TOP_U0/f_empty
add wave -noupdate -expand -group {FIFO_CHECK
} /SYS_tb/DUT/system_control_U0/WrEN
add wave -noupdate -expand -group {FIFO_CHECK
} /SYS_tb/DUT/UART_TOP_U0/TX_IN
add wave -noupdate -expand -group {FIFO_CHECK
} /SYS_tb/DUT/UART_TOP_U0/UART_TX_TOP_U0/U0_FSM/Data_Valid
add wave -noupdate -expand -group {FIFO_CHECK
} -color {Violet Red} /SYS_tb/DUT/system_control_U0/TX_D_VLD
add wave -noupdate -expand -group {FIFO_CHECK
} /SYS_tb/DUT/system_control_U0/TX_P_DATA
add wave -noupdate -expand -group {FIFO_CHECK
} -expand /SYS_tb/DUT/Async_fifo_U0/u_fifo_mem/FIFO_MEM
add wave -noupdate -expand -group {FIFO_CHECK
} /SYS_tb/DUT/UART_TOP_U0/UART_TX_TOP_U0/U0_FSM/current_state
add wave -noupdate -expand -group {FIFO_CHECK
} /SYS_tb/DUT/UART_TOP_U0/UART_TX_TOP_U0/U0_FSM/next_state
add wave -noupdate -expand -group {FIFO_CHECK
} /SYS_tb/DUT/system_control_U0/RX_D_VLD
add wave -noupdate -group {UART
} /SYS_tb/DUT/UART_TOP_U0/UART_RX_TOP_U0/CLK
add wave -noupdate -group {UART
} /SYS_tb/DUT/UART_TOP_U0/UART_RX_TOP_U0/PAR_EN
add wave -noupdate -group {UART
} /SYS_tb/DUT/UART_TOP_U0/UART_RX_TOP_U0/PAR_TYP
add wave -noupdate -group {UART
} /SYS_tb/DUT/UART_TOP_U0/UART_RX_TOP_U0/P_DATA
add wave -noupdate -group {UART
} /SYS_tb/DUT/UART_TOP_U0/UART_RX_TOP_U0/RST
add wave -noupdate -group {UART
} /SYS_tb/DUT/UART_TOP_U0/UART_RX_TOP_U0/RX_IN
add wave -noupdate -group {UART
} /SYS_tb/DUT/UART_TOP_U0/UART_RX_TOP_U0/bit_counter
add wave -noupdate -group {UART
} /SYS_tb/DUT/UART_TOP_U0/UART_RX_TOP_U0/data_sample_en
add wave -noupdate -group {UART
} -color Blue /SYS_tb/DUT/UART_TOP_U0/UART_RX_TOP_U0/data_valid
add wave -noupdate -group {UART
} /SYS_tb/DUT/UART_TOP_U0/UART_RX_TOP_U0/deser_en
add wave -noupdate -group {UART
} /SYS_tb/DUT/UART_TOP_U0/UART_RX_TOP_U0/edge_bit_counter_en
add wave -noupdate -group {UART
} /SYS_tb/DUT/UART_TOP_U0/UART_RX_TOP_U0/edge_counter
add wave -noupdate -group {UART
} /SYS_tb/DUT/UART_TOP_U0/UART_RX_TOP_U0/framing_err
add wave -noupdate -group {UART
} /SYS_tb/DUT/UART_TOP_U0/UART_RX_TOP_U0/par_err
add wave -noupdate -group {UART
} /SYS_tb/DUT/UART_TOP_U0/UART_RX_TOP_U0/parity_check_en
add wave -noupdate -group {UART
} /SYS_tb/DUT/UART_TOP_U0/UART_RX_TOP_U0/parity_ext_err
add wave -noupdate -group {UART
} /SYS_tb/DUT/UART_TOP_U0/UART_RX_TOP_U0/prescale
add wave -noupdate -group {UART
} /SYS_tb/DUT/UART_TOP_U0/UART_RX_TOP_U0/sampled_bit
add wave -noupdate -group {UART
} /SYS_tb/DUT/UART_TOP_U0/UART_RX_TOP_U0/start_check_en
add wave -noupdate -group {UART
} /SYS_tb/DUT/UART_TOP_U0/UART_RX_TOP_U0/start_glitch
add wave -noupdate -group {UART
} /SYS_tb/DUT/UART_TOP_U0/UART_RX_TOP_U0/stop_check_en
add wave -noupdate -group {UART
} /SYS_tb/DUT/UART_TOP_U0/UART_RX_TOP_U0/U0_FSM_rx/current_state
add wave -noupdate -group {UART
} /SYS_tb/DUT/UART_TOP_U0/UART_RX_TOP_U0/U0_FSM_rx/next_state
add wave -noupdate -group {UART
} /SYS_tb/DUT/UART_TOP_U0/UART_RX_TOP_U0/stop_err
add wave -noupdate -group {REG2
} /SYS_tb/DUT/RegFile_U0/REG2
add wave -noupdate -group data_sync_out /SYS_tb/DUT/DATA_SYNC_U0/unsync_bus
add wave -noupdate -group data_sync_out -expand /SYS_tb/DUT/DATA_SYNC_U0/synchronizers_ff
add wave -noupdate -group data_sync_out /SYS_tb/DUT/DATA_SYNC_U0/pulse_gen_ff
add wave -noupdate -group data_sync_out /SYS_tb/DUT/DATA_SYNC_U0/enable_pulse_reg
add wave -noupdate -group data_sync_out /SYS_tb/DUT/DATA_SYNC_U0/bus_enable
add wave -noupdate -group data_sync_out /SYS_tb/DUT/DATA_SYNC_U0/sync_bus
add wave -noupdate -group data_sync_out /SYS_tb/DUT/DATA_SYNC_U0/CLK
add wave -noupdate -group {UART_RST
} /SYS_tb/DUT/RST_SYNC_UART_U0/RST
add wave -noupdate -group {UART_RST
} /SYS_tb/DUT/RST_SYNC_UART_U0/CLK
add wave -noupdate -group {UART_RST
} /SYS_tb/DUT/RST_SYNC_UART_U0/RST_SYNC
add wave -noupdate -group {UART_RST
} /SYS_tb/DUT/RST_SYNC_UART_U0/regs
add wave -noupdate -group {UART_RST
} /SYS_tb/DUT/RST_SYNC_UART_U0/N
add wave -noupdate -group {control_RST
} /SYS_tb/DUT/RST_SYNC_SYS_CTRL_U0/RST
add wave -noupdate -group {control_RST
} /SYS_tb/DUT/RST_SYNC_SYS_CTRL_U0/CLK
add wave -noupdate -group {control_RST
} /SYS_tb/DUT/RST_SYNC_SYS_CTRL_U0/RST_SYNC
add wave -noupdate -group {control_RST
} /SYS_tb/DUT/RST_SYNC_SYS_CTRL_U0/regs
add wave -noupdate -group {control_RST
} /SYS_tb/DUT/RST_SYNC_SYS_CTRL_U0/N
add wave -noupdate -group {REG_FILE
} /SYS_tb/DUT/RegFile_U0/Address
add wave -noupdate -group {REG_FILE
} -color Red /SYS_tb/DUT/RegFile_U0/WrEn
add wave -noupdate -group {REG_FILE
} /SYS_tb/DUT/RegFile_U0/WrData
add wave -noupdate -group {REG_FILE
} -expand /SYS_tb/DUT/RegFile_U0/regArr
add wave -noupdate -group {REG_FILE
} /SYS_tb/DUT/RegFile_U0/RdEn
add wave -noupdate -group {system control
} /SYS_tb/DUT/system_control_U0/CLK
add wave -noupdate -group {system control
} /SYS_tb/DUT/system_control_U0/RdEN
add wave -noupdate -group {system control
} /SYS_tb/DUT/system_control_U0/WrEN
add wave -noupdate -group {system control
} /SYS_tb/DUT/system_control_U0/Wr_D
add wave -noupdate -group {system control
} /SYS_tb/DUT/system_control_U0/current_state
add wave -noupdate -group {system control
} /SYS_tb/DUT/system_control_U0/next_state
add wave -noupdate -group {system control
} /SYS_tb/DUT/system_control_U0/READ_REG
add wave -noupdate -group {system control
} /SYS_tb/DUT/system_control_U0/Address
add wave -noupdate -group {system control
} -color Gold /SYS_tb/DUT/system_control_U0/RDData_Valid
add wave -noupdate -group {system control
} -color Red /SYS_tb/DUT/system_control_U0/RX_D_VLD
add wave -noupdate -group {system control
} /SYS_tb/DUT/system_control_U0/RX_P_Data
add wave -noupdate -expand -group {ALU_CHECK
} /SYS_tb/DUT/ALU_U0/ALU_FUN
add wave -noupdate -expand -group {ALU_CHECK
} /SYS_tb/DUT/Async_fifo_U0/i_r_inc
add wave -noupdate -expand -group {ALU_CHECK
} /SYS_tb/DUT/Async_fifo_U0/i_w_inc
add wave -noupdate -expand -group {ALU_CHECK
} /SYS_tb/DUT/Async_fifo_U0/o_full
add wave -noupdate -expand -group {ALU_CHECK
} /SYS_tb/DUT/Async_fifo_U0/i_w_data
add wave -noupdate -expand -group {ALU_CHECK
} /SYS_tb/DUT/Async_fifo_U0/o_empty
add wave -noupdate -expand -group {ALU_CHECK
} /SYS_tb/DUT/ALU_U0/ALU_OUT
add wave -noupdate -expand -group {ALU_CHECK
} -color Blue /SYS_tb/DUT/ALU_U0/OUT_VALID
add wave -noupdate -expand -group {ALU_CHECK
} /SYS_tb/DUT/system_control_U0/ALU_EN
add wave -noupdate -expand -group {ALU_CHECK
} /SYS_tb/DUT/ALU_U0/EN
add wave -noupdate -expand -group {ALU_CHECK
} /SYS_tb/DUT/system_control_U0/ALU_FUN
add wave -noupdate -expand -group {ALU_CHECK
} /SYS_tb/DUT/system_control_U0/ALU_OUT
add wave -noupdate -expand -group {ALU_CHECK
} /SYS_tb/DUT/system_control_U0/ALU_OUT_ENABLE
add wave -noupdate -expand -group {ALU_CHECK
} /SYS_tb/DUT/system_control_U0/ALU_OUT_reg
add wave -noupdate -expand -group {ALU_CHECK
} /SYS_tb/DUT/system_control_U0/FIFO_FULL
add wave -noupdate -expand -group {ALU_CHECK
} /SYS_tb/DUT/system_control_U0/OP_A_enable
add wave -noupdate -expand -group {ALU_CHECK
} /SYS_tb/DUT/system_control_U0/TX_D_VLD
add wave -noupdate -expand -group {ALU_CHECK
} /SYS_tb/DUT/system_control_U0/WR_INC
add wave -noupdate -expand -group {ALU_CHECK
} /SYS_tb/DUT/system_control_U0/TX_P_DATA
add wave -noupdate -expand -group {ALU_CHECK
} /SYS_tb/DUT/system_control_U0/OP_B_enable
add wave -noupdate -expand -group {ALU_CHECK
} /SYS_tb/DUT/system_control_U0/OUT_Valid
add wave -noupdate -expand -group {ALU_CHECK
} /SYS_tb/DUT/system_control_U0/WrEN
add wave -noupdate -expand -group {ALU_CHECK
} /SYS_tb/DUT/system_control_U0/Wr_D
add wave -noupdate -expand -group {ALU_CHECK
} /SYS_tb/DUT/system_control_U0/current_state
add wave -noupdate -expand -group {ALU_CHECK
} /SYS_tb/DUT/system_control_U0/next_state
add wave -noupdate -expand -group {ALU_CHECK
} /SYS_tb/DUT/ALU_U0/A
add wave -noupdate -expand -group {ALU_CHECK
} /SYS_tb/DUT/ALU_U0/B
add wave -noupdate -expand -group {ALU_CHECK
} /SYS_tb/DUT/ALU_U0/CLK
add wave -noupdate -expand -group {ALU_CHECK
} -color Red /SYS_tb/DUT/system_control_U0/RX_D_VLD
add wave -noupdate -expand -group {ALU_CHECK
} /SYS_tb/DUT/system_control_U0/ALU_FUN_enable
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {742542183 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 170
configure wave -valuecolwidth 68
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
WaveRestoreZoom {742475331 ps} {742727262 ps}
