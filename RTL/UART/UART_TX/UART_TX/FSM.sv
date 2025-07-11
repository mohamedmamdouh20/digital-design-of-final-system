module FSM (
	input				ser_Done,
	//input				Data_Valid,
	input				PAR_EN,
	input		[3:0]		counter_ser,
	input				CLK,
	input				RST,
	input    			f_empty,
		
	output	reg	[1:0]	mux_sel,
	output	reg			    busy_op,
	output reg       ser_en
);
  reg			    busy;
  wire				Data_Valid;
  
  assign Data_Valid = ~f_empty;
	
	//declaring states:


	typedef enum bit [2:0] {
	      idle_state = 'b000,
				start_state = 'b001,
				send_state = 'b010,
				stop_state = 'b011,
				par_state = 'b100
	}state_e;
	
	state_e    next_state, current_state;
	
  //declaring mux selections
	parameter 	start_bit_sel = 'b00,
				send_sel = 'b01,
				par_sel = 'b10,
				stop_bit_sel = 'b11;
				
				

//FSM controller logic:
	always @ (posedge CLK or negedge RST) 
	begin
	if(!RST)
		begin
		current_state <= idle_state;
		end
		
	else
		begin
		current_state <= next_state;
		end
	end
	
	always @ (*)
		begin
		  ser_en = 'b0;
			case(current_state)
				idle_state:
					begin
					busy = 'b0;
					mux_sel = stop_bit_sel;
					if(Data_Valid)
						begin
							next_state = start_state;
						end
					else
						begin
							next_state = idle_state;
						end
					end
				start_state:
					begin
						ser_en = 'b1;
						busy = 'b1;
						mux_sel = start_bit_sel;
						next_state = send_state;
					end

				send_state:
					begin
					  ser_en = 'b1;
						busy = 'b1;
						mux_sel = send_sel;
						if(counter_ser == 8 && PAR_EN)
							begin
								next_state = par_state;
							end
						else if(!PAR_EN && counter_ser == 8)
							begin
								next_state = stop_state;
							end
						else
							begin
								next_state = send_state;
							end
					end
				par_state:
					begin
						mux_sel = par_sel;
						busy = 'b1;
						next_state = stop_state;
					end

				stop_state:
					begin
						busy = 'b1;
						mux_sel = stop_bit_sel;
						next_state = idle_state;
					end

				default:	
					begin
						busy = 'b0;
						mux_sel = stop_bit_sel;
						next_state = idle_state;
					end
			endcase
		end
	
	always@ (posedge CLK or negedge RST)
	 begin
	     if(!RST)
	       begin
	         busy_op <= 0;
	       end
	      else
	        begin
	          busy_op <= busy;
	        end
	   end
endmodule