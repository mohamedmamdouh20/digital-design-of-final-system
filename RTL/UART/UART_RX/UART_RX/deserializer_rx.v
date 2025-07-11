module    deserializer_rx(
  input                   deserializer_en,
  input                   CLK,
  input                   RST,
  input                   sampled_bit_in,
  
  output    reg  [7:0]     p_data
);

  
  always @ (posedge CLK or negedge RST)
    begin
      if(!RST)
        begin
          p_data <= 0;

        end
        
      else if(deserializer_en)
        begin
              p_data[7] <= sampled_bit_in;
              p_data[6] <= p_data[7];
              p_data[5] <= p_data[6];
              p_data[4] <= p_data[5];
              p_data[3] <= p_data[4];
              p_data[2] <= p_data[3];
              p_data[1] <= p_data[2];
              p_data[0] <= p_data[1];
        end
        
      else
        begin
          p_data <= p_data;
        end
        
    end

endmodule
