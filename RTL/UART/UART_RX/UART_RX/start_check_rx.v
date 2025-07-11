module    start_check_rx(
  input           start_check_en,
  input           start_bit,
  input           CLK,
  input           RST,
  
  output   reg    start_glitch
);
  wire            start_glitch_comb;
  
  assign  start_glitch_comb = start_check_en && start_bit;
  
  always @ (posedge CLK or negedge RST)
    begin
      if(!RST)
        begin
          start_glitch <= 0;
        end
      else if (start_check_en)
        begin
          start_glitch <= start_glitch_comb;
        end
   end
endmodule