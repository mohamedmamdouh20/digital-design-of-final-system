module MUX(
	input		[1:0]		 mux_sel,
	input					     ser_data,
	input					     par_bit,
	input          CLK,
	input          RST,
	
	output		reg			TX_OUT
);

	parameter	start_bit = 1'b0,
				stop_bit  = 1'b1;


	parameter 	start_bit_sel = 'b00,
				send_sel = 'b01,
				par_sel = 'b10,
				stop_bit_sel = 'b11;


	
	always @ (posedge CLK or negedge RST)
		begin
			if(!RST)
				begin
					TX_OUT <= stop_bit;
				end
			else
				begin
					case (mux_sel)
						start_bit_sel:
							begin
								TX_OUT <= start_bit; 
							end
						send_sel:
							begin
								TX_OUT	<= ser_data;
							end
						par_sel:
							begin
								TX_OUT <= par_bit;
							end
						stop_bit_sel:
							begin
								TX_OUT <= stop_bit;
							end
					endcase
				end
		end
	
	
endmodule