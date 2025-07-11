module  data_sampling_rx(
  input             rx_in,
  input             data_sample_en,
  input    [5:0]    edge_count,
  input    [5:0]    prescale,
  input             CLK,
  input             RST,
  
  output   reg      sampled_data
);
  reg       rx_sample_1;
  reg       rx_sample_2;
  reg       rx_sample_3;
  
  always @ (posedge CLK or negedge RST)
    begin
      if(!RST)
        begin
          rx_sample_1 <= 0;
          rx_sample_2 <= 0;
          rx_sample_3 <= 0;
        end
      else if(data_sample_en)
        begin
          if(edge_count == (prescale>>1))
            begin
              rx_sample_1 <= rx_in;
            end
          else if(edge_count == ((1+(prescale>>1)) && (prescale != 4)))
            begin
              rx_sample_2 <= rx_in;
            end
          else if(edge_count == ((prescale>>1)-1) && (prescale != 4))
            begin
              rx_sample_3 <= rx_in;
            end
        end
    end
    
  always @ (*)
    begin
      if(prescale == 4)
        begin
          sampled_data = rx_sample_1;
        end
      else
        begin
          sampled_data = (rx_sample_1 && rx_sample_2) | (rx_sample_2 && rx_sample_3) | (rx_sample_1 && rx_sample_3);
        end
      
    end  
endmodule
