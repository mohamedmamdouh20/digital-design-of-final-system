module UART_TX_TOP (
	input		[7:0]		P_DATA,
	input					PAR_EN,
	input					PAR_TYP,
	input					CLK,
	input					RST,
	input     				f_empty,
	
	output					Busy,
	output					TX_OUT
);

	wire		[3:0]  		counter_ser;
	wire					ser_en;
	wire					ser_done;
	wire					par_bit;
	wire					ser_data;
	wire		[1:0]		mux_sel;
	
	serializer U0_serializer(
		.P_Data			(P_DATA),
		.Data_Valid		(DATA_VALID),
		.ser_EN			(ser_en),
		.CLK			(CLK),
		.RST			(RST),
		.ser_OUT		(ser_data),
		.ser_Done		(ser_done),
		.counter_ser	(counter_ser)
	);
	
	MUX U0_MUX(
		.mux_sel		  (mux_sel),
		.ser_data		 (ser_data),
		.par_bit		  (par_bit),
		.CLK        (CLK),
		.RST        (RST),
		.TX_OUT			  (TX_OUT)	
	);
	
	FSM	U0_FSM (
		.ser_Done		(ser_done),
		.PAR_EN			(PAR_EN),
		.counter_ser	(counter_ser),
		.CLK			(CLK),
		.RST			(RST),
		.mux_sel		(mux_sel),
		.busy_op			(Busy),
		.ser_en   (ser_en),
		.f_empty  (f_empty)
	);
	
	parity_calc U0_parity_calc (
		.PAR_TYP		    (PAR_TYP),
		.P_Data			    (P_DATA),
		.Data_Valid		 (DATA_VALID),
		.RST          (RST),
		.par_bit		    (par_bit),
		.CLK				(CLK)
	);
	
endmodule
