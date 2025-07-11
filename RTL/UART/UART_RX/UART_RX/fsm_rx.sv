module fsm_rx(
  input                       CLK,
  input                       RST,
  input                       par_en,
  input     [3:0]             bit_count,
  input     [5:0]             edge_count,
  input                       rx_in,
  input                       par_err,
  input                       start_glitch,
  input                       stop_err,
  
  
  output    reg               parity_check_en,
  output    reg               start_check_en,
  output    reg               stop_check_en,
  output    reg               edge_bit_counter_en,
  output    reg               deserializer_en,
  output    reg               data_sampling_en,
  output    reg               data_valid,
  output    reg               parity_ext_err,
  output    reg               framing_error
  
);
  typedef enum bit [2:0] {
            idle_state = 'b000,
            start_state = 'b001,
            data_read_state = 'b010,
            parity_state = 'b011,
            stop_state = 'b100,
            data_valid_state = 'b101
  }state_e;
	
	state_e    next_state, current_state;
  
  reg             parity_err_internal;
  reg             data_valid_internal;
  reg             stop_err_internal;
  reg             start_glitch_internal;
  reg             stop_ext_err,start_ext_err;
 
  always @ (*)
    begin
      start_glitch_internal = 0;
      parity_err_internal = 0;
      stop_err_internal = 0;
      parity_check_en = 0;
      start_check_en = 0;
      stop_check_en = 0;
      edge_bit_counter_en = 0;
      deserializer_en = 0;
      data_sampling_en = 0;
      data_valid_internal = 0;
      case (current_state)
        
          //idle state:
          idle_state:
            begin
              if(!rx_in)
                begin
                  next_state = start_state;
                end
              else
                begin
                  next_state = idle_state;
                end
            end
            
          //start_state:
          start_state: //check if there is a start glitch dont continue else continue all states
            begin
              edge_bit_counter_en = 1;
              start_check_en = (bit_count == 2);
              data_sampling_en = 1;
              if(bit_count == 2 && !start_glitch)
                begin
                  next_state = data_read_state;
                end
              else if(start_glitch && bit_count == 2)
                begin
                  next_state = idle_state;
                end
              else
                begin
                  next_state = start_state;
                end
            end
          
          //read_data_state:
          data_read_state:
            begin
              edge_bit_counter_en = 1;
              data_sampling_en = 1;
              deserializer_en = (edge_count == 1);
              if((bit_count == 10) && par_en)
                begin
                  next_state = parity_state;
                end
              else if((bit_count == 10) && !par_en)
                begin
                  next_state = stop_state;
                end
              else
                begin
                  next_state = data_read_state;
                end
            end
  
          //parity_check_state:
          parity_state:
            begin
              data_sampling_en = 1;
              edge_bit_counter_en = 1;
              parity_check_en = (bit_count == 11);
              if(bit_count == 11 )
                begin
                  next_state = stop_state;
                end
              else
                begin
                  next_state = parity_state;
                end
            end
          
          //stop_state:
          stop_state:
            begin
              data_sampling_en = 1; 
              edge_bit_counter_en = 1;
              stop_check_en = (bit_count == 12);
              
              if(bit_count == 12 && par_en)
                begin
                  next_state = data_valid_state;
                end
                
              else if(bit_count == 11 && !par_en)
                begin
                  next_state = data_valid_state;
                end
                
              else
                begin
                  next_state = stop_state;
                end
            end
          
          //data_valid_state:
          data_valid_state:
            begin
              data_sampling_en = 1; 
              edge_bit_counter_en = 1;
              data_valid_internal = !stop_err && !par_err && !start_glitch;
              parity_err_internal = par_err;
              start_glitch_internal = start_glitch;
              stop_err_internal = stop_err;
              if(!rx_in)
                begin
                  next_state = start_state;
                end
              else
                begin
                  next_state = idle_state;
              end
            end
            
            //default:
          default:
            begin
              parity_check_en = 0;
              start_check_en = 0;
              stop_check_en = 0;
              edge_bit_counter_en = 0;
              deserializer_en = 0;
              data_sampling_en = 0;
              data_valid_internal = 0;
              start_glitch_internal = 0;
              parity_err_internal = 0;
              stop_err_internal = 0;
							next_state = idle_state;
            end
      endcase
    end
    
    always @ (posedge CLK or negedge RST)
      begin
        if(!RST)
          begin
            current_state <= idle_state;
            data_valid <= 0;
          end
        else
          begin
            data_valid <= data_valid_internal;
            current_state <= next_state;
            parity_ext_err <= parity_err_internal;
            if(stop_ext_err || start_ext_err)
              begin
                framing_error <= 1;
              end
            else
              begin
                framing_error <= 0;
              end
          end
      end
   

endmodule
