module stop_check_rx(
  //declaring module inputs
  input               stop_bit, //the sampled bit from data_sampling block
  input               stop_check_en, //the enable signal from fsm
  input               CLK,
  input               RST,
  
  output    reg       stop_err //output if 1 therefor there is an error in the stop signal

);
  wire                stop_err_comb;
  
  // stop error is 1 only if enable is high and stop bit is zero
  assign  stop_err_comb = ((!stop_bit) && stop_check_en);
  
  always @ (posedge CLK or negedge RST)
    begin
      if(!RST)
        begin
          stop_err <= 0;
        end
      else if(stop_check_en)
        begin
          stop_err <= stop_err_comb;
        end
    end
  
endmodule