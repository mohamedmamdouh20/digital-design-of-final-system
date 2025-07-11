module edge_bit_counter_rx(
  //declaring inputs to module
  input                       CLK, //input clock 
  input                       RST,  //input async reset signal
  input                       enable, //enable signal from the internal control block
  input          [5:0]        prescaler,
  //declaring outputs from module
  output   reg   [3:0]        bit_counter, //output telling the control unit what is the index of the bit being sampled 
  output   reg   [5:0]        edge_counter //output signal help in the logic of incrementing the bit index and depend on the value of prescaler
);
  
  
  always @ (posedge CLK or negedge RST)
    begin
      if (!RST)
        begin
          bit_counter <=  1;
          edge_counter <= 1;
        end
      else if(enable)
        begin
          edge_counter <= edge_counter + 1;
          if(edge_counter == prescaler)
            begin
              bit_counter <= bit_counter + 1;
              edge_counter <= 1;
            end
          else if( bit_counter == 12)
            begin
              bit_counter <= 1;
              edge_counter <= 1;
            end
          else
            begin
              bit_counter <= bit_counter;
            end
        end
      else
        begin
          bit_counter <= 1;
          edge_counter <= 1;
        end
    end
  
  
endmodule
